create or   replace  view view_sz_expected_marks AS
select 
        stimmzettel.id,
        count(kandidaten.id) as expected_marks
from
kandidaten 
        join stimmzettelgruppen on kandidaten.stimmzettelgruppen = stimmzettelgruppen.ridx
        join stimmzettel on stimmzettel.ridx = stimmzettelgruppen.stimmzettel
group by stimmzettel.id


create or   replace  view view_sz_titles_by_page AS
select
json_arrayagg(
    json_object("titel",stimmzettel.name)
) t,
sz_titel_regions.x,
sz_titel_regions.y,
sz_titel_regions.width,
sz_titel_regions.height,
sz_page_sizes.width page_width,
sz_page_sizes.height page_height
from 
stimmzettel 
        join stimmzettel_roi on stimmzettel_roi.stimmzettel_id = stimmzettel.id
        join sz_rois on stimmzettel_roi.sz_rois_id = sz_rois.id
        join sz_to_region on sz_to_region.id_sz = stimmzettel.id
        join sz_titel_regions on  sz_titel_regions.id = sz_to_region.id_sz_titel_regions
        join sz_to_page_sizes on sz_to_page_sizes.id_sz = stimmzettel.id
        join sz_page_sizes on  sz_to_page_sizes.id_sz_page_sizes = sz_page_sizes.id
group by sz_titel_regions.x,
sz_titel_regions.y,
sz_titel_regions.width,
sz_titel_regions.height,
sz_page_sizes.width,
sz_page_sizes.height
;

create or   replace  view view_sz_optical_config AS
select

    json_object(
        "titles",view_sz_titles_by_page.t,

        "titleRegion",
        json_object(
            "x", titel_regions_x,
            "y", titel_regions_y,
            "width", titel_regions_width,
            "height", titel_regions_height
        ),

        "pagesize", json_object(
            "width", pagesize_width,
            "height", pagesize_height
        ),
        "circleSize", 3,
        "circleMinDistance", 22,
        "rois",json_arrayagg(
            json_object(
                    "types", `types`,
                    "x", x.x,
                    "y", x.y,
                    "width", x.width,
                    "height", x.height,
                    "excpectedMarks", x.expected_marks
            )
        )
    ) o 
from (
    select 
        stimmzettel.id,
        -- json_arrayagg(stimmzettel.name) titles,
        json_arrayagg(
                json_object(
                        'title',stimmzettel.name,
                        'id',stimmzettel.id
                )
        ) `types`,

        sz_rois.x,
        sz_rois.y,
        sz_rois.width,
        sz_rois.height,
        sz_titel_regions.name,
        sz_titel_regions.x as titel_regions_x,
        sz_titel_regions.y as titel_regions_y,
        sz_titel_regions.width as titel_regions_width,
        sz_titel_regions.height as titel_regions_height,
        view_sz_expected_marks.expected_marks,
        sz_page_sizes.width as pagesize_width,
        sz_page_sizes.height as pagesize_height
    from 
        view_sz_expected_marks 
        join stimmzettel on stimmzettel.ridx = view_sz_expected_marks.id
        join stimmzettel_roi on stimmzettel_roi.stimmzettel_id = stimmzettel.id
        join sz_rois on stimmzettel_roi.sz_rois_id = sz_rois.id
        join sz_to_region on sz_to_region.id_sz = stimmzettel.id
        join sz_titel_regions on  sz_titel_regions.id = sz_to_region.id_sz_titel_regions
        join sz_to_page_sizes on sz_to_page_sizes.id_sz = stimmzettel.id
        join sz_page_sizes on  sz_to_page_sizes.id_sz_page_sizes = sz_page_sizes.id
    group by 
        view_sz_expected_marks.expected_marks,
        sz_rois.x,
        sz_rois.y,
        sz_rois.width,
        sz_rois.height
) x
join view_sz_titles_by_page
on (
    view_sz_titles_by_page.x,
    view_sz_titles_by_page.y,
    view_sz_titles_by_page.width,
    view_sz_titles_by_page.height,
    view_sz_titles_by_page.page_width,
    view_sz_titles_by_page.page_height
) = (
    x.titel_regions_x,
    x.titel_regions_y,
    x.titel_regions_width,
    x.titel_regions_height,
    x.pagesize_width,
    x.pagesize_height
)
group by titel_regions_x,titel_regions_y,titel_regions_width,titel_regions_height,pagesize_width,pagesize_height
;