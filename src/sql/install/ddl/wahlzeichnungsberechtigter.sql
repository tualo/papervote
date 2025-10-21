DELIMITER //


CREATE TABLE IF NOT EXISTS wahlzeichnungsberechtigter (
    id INT NOT NULL,
    name VARCHAR(255),
    funktion VARCHAR(255),
    personenident VARCHAR(255),
    wahlberechtigte bigint(20),
    geburtsdatum DATE default '1900-01-01',
    vorname VARCHAR(255),
    nachname VARCHAR(255),
    namenstitel VARCHAR(255),
    nachtitel VARCHAR(255),
    PRIMARY KEY (id),

    INDEX idx_wahlzeichnungsberechtigter_wahlberechtigte (wahlberechtigte),
    
    CONSTRAINT fk_wahlzeichnungsberechtigter_wahlberechtigte FOREIGN KEY (wahlberechtigte) REFERENCES `wahlberechtigte` (`id`) ON

    DELETE CASCADE ON
    UPDATE CASCADE,

  `login` varchar(255) NOT NULL,
  `created_at` timestamp not null default current_timestamp,
  `updated_at` timestamp not null default current_timestamp on update current_timestamp

) //

CREATE OR REPLACE TRIGGER `trigger_wahlzeichnungsberechtigter_bi_defaults`
BEFORE INSERT ON `wahlzeichnungsberechtigter` FOR EACH ROW
BEGIN
  IF NEW.login IS NULL THEN
    SET NEW.login = getSessionUser();
  END IF;
  IF NEW.created_at IS NULL THEN
    SET NEW.created_at = CURRENT_TIMESTAMP;
  END IF;
END //

CREATE OR REPLACE TRIGGER `trigger_wahlzeichnungsberechtigter_bu_defaults`
BEFORE UPDATE ON `wahlzeichnungsberechtigter` FOR EACH ROW
BEGIN
  IF NEW.login IS NULL THEN
    SET NEW.login = getSessionUser();
  END IF;
  IF NEW.created_at IS NULL THEN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
  END IF;
END //