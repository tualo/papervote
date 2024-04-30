delimiter ;

create table if not exists stimmzettel_roi (
    stimmzettel_id integer not null,
    sz_rois_id integer not null,
    primary key (stimmzettel_id, sz_rois_id),
    constraint fk_stimmzettel_roi_stimmzettel  foreign key (stimmzettel_id) references stimmzettel (id)  on delete cascade on update cascade,
    constraint fk_stimmzettel_roi_sz_rois  foreign key (sz_rois_id) references sz_rois (id) on delete cascade on update cascade
);
alter table add constraint fk_stimmzettel_roi_stimmzettel foreign key (stimmzettel_id) references stimmzettel (id);

