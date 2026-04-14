ALTER TABLE dades_ponent
ADD COLUMN ordinadors INT CHECK (ordinadors <= 4),
ADD COLUMN rate INT CHECK (rate >= 5 AND rate <= 10);

-- Afegim camp complex_rate per als exercicis 13-16 (sense arrodoniment)
ALTER TABLE dades_ponent
ADD COLUMN complex_rate DECIMAL(5,2);

SET SQL_SAFE_UPDATES = 0;

-- Omplim ordinadors (1-4) i rate (5-10) amb valors aleatoris
UPDATE dades_ponent SET
  ordinadors = FLOOR(1 + RAND() * 4),
  rate       = FLOOR(5 + RAND() * 6),
  complex_rate = 5 + RAND() * 5;

-- Per provar exercici 7: afegim espais accidentals als costats en alguns registres
UPDATE dades_ponent SET empresa = '  tech corp  ' WHERE id = 1;
UPDATE dades_ponent SET empresa = ' data solutions ' WHERE id = 2;

-- Per provar exercici 17: puntuació negativa
UPDATE dades_ponent SET rate = 7 WHERE id = 3;
-- Per provar exercici 36: rate NULL
UPDATE ponent SET rate = NULL WHERE id = 2;

-- Per provar exercici 37: empresa NULL
UPDATE ponent SET empresa = NULL WHERE id = 3;

SET SQL_SAFE_UPDATES = 1;