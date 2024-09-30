-- https://www.w3schools.com/mysql/mysql_insert_into_select.asp

INSERT INTO asset_device (device_id, project_id, system_id, group_id, name, `type`, model, description, create_time,
                          update_time, device_short_id, gauge_table_id)
SELECT gauge_table_device_id,
       project_id,
       system_id,
       group_id,
       gauge_table_name,
       'IT机房',
       NULL,
       NULL,
       NOW(),
       NOW(),
       gauge_table_id,
       gauge_table_id
FROM asset_gauge_table
WHERE create_time >= '2024-09-21 14:00:00';