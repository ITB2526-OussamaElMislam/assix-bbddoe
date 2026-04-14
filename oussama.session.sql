-- =========================================================
-- SCRIPT DE PREPARACIÓ: ITB TECH SUMMIT
-- Aquest script crea l'estat inicial de la base de dades.
-- =========================================================

DROP DATABASE IF EXISTS tech_summit;
CREATE DATABASE tech_summit;
USE tech_summit;

-- 1. Taula de ponents (estat inicial abans de les reformes)
CREATE TABLE dades_ponent (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50),
    cognom VARCHAR(100),
    empresa VARCHAR(100)
);

-- 2. Taula de sessions o xerrades
CREATE TABLE sessio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titol VARCHAR(150) NOT NULL UNIQUE,
    sala VARCHAR(50) NOT NULL,
    hora TIME NOT NULL
);

-- 3. Inserció de dades inicials amb IDs manuals 
-- (Metodologia: Forçar la consciència de les claus primàries)

INSERT INTO dades_ponent (id, nom, cognom, empresa) VALUES 
(1, 'anna', 'garcia', 'tech corp'),
(2, 'marc', 'rovira', 'data solutions'),
(3, 'laia', 'vidal', 'innovate asix');

INSERT INTO sessio (id, titol, sala, hora) VALUES 
(1, 'ia generativa en el núvol', 'sala a', '10:00:00'),
(2, 'seguretat en xarxes locals', 'sala b', '11:30:00'),
(3, 'automatització amb scripts', 'sala a', '13:00:00'),
(4, 'futur de les bases de dades', 'sala c', '16:00:00');

-- =========================================================
-- FI DE L'SCRIPT D'INICIALITZACIÓ