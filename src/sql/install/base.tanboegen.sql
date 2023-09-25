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



