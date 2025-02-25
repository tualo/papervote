#!/bin/sh
echo "delimiter ;" > papervote/src/sql/install/menu.base.sql
mysqldump --no-create-info $1 macc_groups --where "name like 'wahl_%'" >> papervote/src/sql/install/menu.base.sql
mysqldump --no-create-info $1 rolle_menu --where "rolle like 'wahl_%'" >> papervote/src/sql/install/menu.base.sql
mysqldump --single-transaction --no-create-info $1 macc_menu --where "id in (select id from rolle_menu where rolle like 'wahl_%')" >> papervote/src/sql/install/menu.base.sql

cat papervote/src/sql/install/menu.base.sql | grep "INSERT\|(" > papervote/src/sql/install/menu.base2.sql
mv papervote/src/sql/install/menu.base2.sql papervote/src/sql/install/menu.base.sql
sed -i '' 's/INSERT INTO /INSERT IGNORE INTO SESSIONDB./g' papervote/src/sql/install//menu.base.sql
