#!/bin/sh
echo "delimiter ;" > papervote/src/sql/install/ds.base.sql
./ds/src/sqlexport/dump_ds_definition abgabetyp $1 >> papervote/src/sql/install/ds.base.sql
./ds/src/sqlexport/dump_ds_definition wahlbezirk $1 >> papervote/src/sql/install/ds.base.sql
./ds/src/sqlexport/dump_ds_definition wahlgruppe $1 >> papervote/src/sql/install/ds.base.sql
./ds/src/sqlexport/dump_ds_definition stimmzettel $1 >> papervote/src/sql/install/ds.base.sql
./ds/src/sqlexport/dump_ds_definition stimmzettelgruppen $1 >> papervote/src/sql/install/ds.base.sql
./ds/src/sqlexport/dump_ds_definition kandidaten $1 >> papervote/src/sql/install/ds.base.sql
./ds/src/sqlexport/dump_ds_definition wahlruecklauf_felder $1 >> papervote/src/sql/install/ds.base.sql
./ds/src/sqlexport/dump_ds_definition wahlberechtigte $1 >> papervote/src/sql/install/ds.base.sql
./ds/src/sqlexport/dump_ds_definition wahlzeichnungsberechtigter $1 >> papervote/src/sql/install/ds.base.sql
./ds/src/sqlexport/dump_ds_definition wahlschein $1 >> papervote/src/sql/install/ds.base.sql
./ds/src/sqlexport/dump_ds_definition wahlberechtigte_anlage $1 >> papervote/src/sql/install/ds.base.sql
./ds/src/sqlexport/dump_ds_definition wm_tanboegen $1 >> papervote/src/sql/install/ds.base.sql
./ds/src/sqlexport/dump_ds_definition wm_tannummer $1 >> papervote/src/sql/install/ds.base.sql

sed -i '' 's/INSERT INTO/INSERT IGNORE INTO/g' papervote/src/sql/install/ds.base.sql