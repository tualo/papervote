DELIMITER //

CREATE OR REPLACE TRIGGER `kandidaten_bi_ridx`
BEFORE INSERT ON `kandidaten` FOR EACH  ROW
BEGIN
    IF NEW.ridx='' OR new.ridx is null THEN
        SET NEW.ridx = new.id;
    END IF;
END //