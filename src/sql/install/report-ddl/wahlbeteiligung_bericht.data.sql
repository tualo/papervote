delimiter ;
insert ignore into wahlbeteiligung_bericht (id,aktiv,checktyp,name,abgabetyp) values

(1,1,0,'Wähler','{"abgabetyp1":true,"abgabetyp2":true}'),
(2,1,0,'Unzustellbar','{"abgabetyp1":true,"abgabetyp2":true}'),
(3,1,0,'Bereinigt','{"abgabetyp1":true,"abgabetyp2":true}'),
(4,1,1,'Angenommen','{"abgabetyp1":true,"abgabetyp2":true}'),
(5,1,0,'Abgewiesen','{"abgabetyp1":true,"abgabetyp2":false}'),
(6,1,0,'Klärungen','{"abgabetyp1":true,"abgabetyp2":false}'),
(7,1,0,'ohne Wahlschein','{"abgabetyp1":true,"abgabetyp2":false}'),
(8,1,0,'versp?tet','{"abgabetyp1":true,"abgabetyp2":true}'),
(9,0,0,'abgemeldet','{"abgabetyp1":true,"abgabetyp2":true}'),
(10,0,0,'E-Aktiv','{"abgabetyp1":true,"abgabetyp2":true}'),

(11,0,0,'Gültig','{"abgabetyp1":true,"abgabetyp2":true}'),
(12,0,0,'Gültig Online','{"abgabetyp1":true,"abgabetyp2":true}'),

(13,0,0,'Wahlberechtigte','{"abgabetyp1":true,"abgabetyp2":true}'),
(14,0,0,'nicht zustellbar','{"abgabetyp1":true,"abgabetyp2":true}'),
(15,0,0,'Wahlberechtigte (bereinigt)','{"abgabetyp1":true,"abgabetyp2":true}'),
(16,0,0,'eingegangene Wahlunterlagen','{"abgabetyp1":true,"abgabetyp2":true}'),
(17,0,0,'davon zurückgewiesen','{"abgabetyp1":true,"abgabetyp2":true}'),
(18,0,0,'davon zurückgewiesen ohne Wahlschein','{"abgabetyp1":true,"abgabetyp2":true}'),
(19,1,0,'Inaktiv','{"abgabetyp1":true,"abgabetyp2":true}');
