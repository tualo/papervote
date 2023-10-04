delimiter ; 
insert ignore into ds_addcommands_xtypes (id,name) values ('wm_pwgen_importcmd','Importieren');
insert ignore into ds_addcommands_xtypes (id,name) values ('wm_wb_importcmd','Importieren');
insert ignore into ds_addcommands_xtypes (id,name) values ('pwgen_pw_command','Passwortgenerator');


INSERT IGNORE INTO `ds_addcommands` (`table_name`, `xtype`, `location`, `position`, `label`, `iconCls`) VALUES ("wahlberechtigte_anlage","wm_wb_importcmd","toolbar",1,"Importieren",NULL);