DELIMITER ;
create or replace view view_stimmenanzahl_ranking_los_monitor_list_stand as select concat('Stand: ' , date_format( ifnull(max(mx),now()) ,'%d. %M %Y %H:%i'))  mx from view_stimmenanzahl_ranking_los_monitor_list_gescannt;
