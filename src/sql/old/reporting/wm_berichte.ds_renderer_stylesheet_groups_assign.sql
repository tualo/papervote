delimiter ;
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('1','wm_berichte',1);
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('2','wm_berichte',1);
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('3','wm_berichte',1);
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('4','wm_berichte',1);
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('1','wm_berichte_beteiligung_tagesprokoll_wrapper',1);
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('2','wm_berichte_beteiligung_tagesprokoll_wrapper',1);
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('3','wm_berichte_beteiligung_tagesprokoll_wrapper',1);
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('4','wm_berichte_beteiligung_tagesprokoll_wrapper',1);
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('1','wm_berichte_blocksystem_wrapper',1);
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('2','wm_berichte_blocksystem_wrapper',1);
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('3','wm_berichte_blocksystem_wrapper',1);
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('4','wm_berichte_blocksystem_wrapper',1);
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('1','wm_berichte_tanboegen',1);
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('2','wm_berichte_tanboegen',1);
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('3','wm_berichte_tanboegen',1);
insert ignore into ds_renderer_stylesheet_groups_assign (group_id,pug_id,active) values ('4','wm_berichte_tanboegen',1);

insert ignore into ds_renderer (
    table_name,
    pug_template,
    label
)
values (
    'view_beteiligung_stimmzettel_pro_tag',
    'wm_berichte_beteiligung_tagesprokoll_wrapper',
    'PDF'
);