DELIMITER ;

CREATE TABLE IF NOT EXISTS wm_tanboegen ( 
    id    INT NOT NULL, 
    datum DATE, 
    zeit  TIME, 
    PRIMARY KEY (id) 
) ;


CREATE TABLE IF NOT EXISTS wm_tannummer  ( 
    tannummer VARCHAR(25) NOT NULL, 
    aktiv     INT DEFAULT 0, 
    bogen     INT NOT NULL, 
    PRIMARY KEY (tannummer), 
    INDEX idx_wm_tanboegen_bogen (bogen),
    CONSTRAINT fk_wm_tanboegen_bogen FOREIGN KEY (bogen) REFERENCES wm_tanboegen (id) ON DELETE CASCADE ON UPDATE CASCADE
) ;



DELIMITER //

CREATE OR REPLACE TRIGGER `trigger_wm_tanboegen_create_numbers`
    AFTER INSERT
    ON `wm_tanboegen` FOR EACH ROW
BEGIN
    DECLARE tan varchar(25);

    FOR i in 1 .. 20 DO
        SET tan = concat(
            'FC9',
            chr(65+round(rand()*25)),
            chr(65+round(rand()*25)),
            chr(65+round(rand()*25)),
            chr(65+round(rand()*25)),
            chr(65+round(rand()*25)),
            chr(65+round(rand()*25)),
            chr(65+round(rand()*25))
        );
        INSERT IGNORE INTO wm_tannummer
        (
            tannummer,
            aktiv,
            bogen
        )
        VALUES 
        (
            tan,
            1,
            NEW.id
        );
    END FOR;
END //


FOR i in 1 .. 10 DO
    insert IGNORE INTO wm_tanboegen (id,datum,zeit) values (i,curdate(),curtime());
END FOR //
