-- 1. Volem fer etiquetes per les portes dels espais on es faran les conferències amb els noms dels ponents.
-- Fes una consulta per obtenir el nom de tots els ponents en majúscules.
SELECT UPPER(nom) FROM ponent;

-- 2. El departament de màrqueting necessita un llistat de contacte per al catàleg de mà de l'esdeveniment.
-- Obté el cognom de tots els ponents en minúscules i l'empresa on treballen, ordenats per empresa de la A a la Z.
SELECT LOWER(cognom1), empresa FROM ponent ORDER BY empresa ASC;

-- 3. Per a la impressió de les targetes de visita oficials, ens demanen un format combinat de nom i cognom.
-- Genera un llistat amb un únic text per registre amb el nom i el cognom separats per un espai i posa-li l'àlies 'Nom_Complet'.
SELECT CONCAT(nom, ' ', cognom1) AS Nom_Complet FROM ponent;

-- * 4. El sistema d'inventari necessita codis de referència curts per a cada expert segons el seu lloc de treball.
-- Fes una consulta en la que generi una columna anomenada 'Codi' amb les 3 primeres lletres de l'empresa i mostra també el nom del ponent.
SELECT LEFT(TRIM(empresa), 3) AS Codi, nom FROM ponent;

-- 5. L'equip de xarxes socials vol verificar si els títols de les sessions caben en els seus bàners publicitaris.
-- Mostra el títol de cada sessió i la seva longitud, filtrant només aquelles que fan més de 20 caràcters.
SELECT titol, LENGTH(titol) FROM sessio WHERE LENGTH(titol) > 20;

-- 6. Per a un llistat d'estil vintage, volem canviar l'estètica dels cognoms dels ponents en la base de dades.
-- Mostra el cognom substituint totes les lletres 'a' per '@' i anomena la columna 'Cognom_Modificat'.
SELECT REPLACE(cognom1, 'a', '@') AS Cognom_Modificat FROM ponent;

-- 7. S'ha detectat que alguns noms d'empresa es van introduir amb espais accidentals als costats.
-- Mostra el camp empresa net d'espais prefixats o sufixats i el nom del ponent per a tots els IDs entre 1 i 5.
SELECT TRIM(empresa) AS empresa_neta, nom FROM ponent WHERE id BETWEEN 1 AND 5;

-- 8. El personal de recepció necessita un format de llista que identifiqui ràpidament el ponent amb el seu ID.
-- Crea un text que mostri el nom i l'ID entre parèntesis, filtrant només ponents de l'empresa 'tech corp'.
SELECT CONCAT(nom, ' (', id, ')') AS identificador FROM ponent WHERE TRIM(empresa) = 'tech corp';

-- 9. En la web del congrés no hi ha espai per a títols llargs en el menú lateral.
-- Selecciona les sessions mostrant només les 10 primeres lletres seguides del text '...' i posa l'àlies 'Titol_Curt'.
SELECT CONCAT(SUBSTRING(titol, 1,10), '...') AS Titol_Curt FROM sessio;

-- 10. L'equip de disseny vol fer un joc visual amb la darrera lletra dels cognoms dels ponents.
-- Obté un llistat amb el nom, el cognom i la darrera lletra del cognom de tots els ponents, ordenat alfabèticament pel nom.
SELECT nom, cognom1, RIGHT(cognom1, 1) AS darrera_lletra FROM ponent ORDER BY nom ASC;

-- 11. Per decidir l'ordre de les entrevistes, volem assignar una prioritat aleatòria a cada expert per no beneficiar ningú.
-- Genera un número decimal aleatori entre 0 i 1 per a cada ponent i mostra'l en una columna nova al costat del seu nom i cognom.
SELECT nom, cognom1, RAND() AS prioritat_aleatoria FROM ponent;

-- 12. Volem fer un sorteig d'una tauleta d'última generació entre tots els ponents de l'esdeveniment.
-- Fes una consulta, on li assignis a cada ponent un número de loteria sencer entre 1 i 100 i mostra'l a una columna anomenada 'Numero_Sorteig'.
SELECT nom, cognom1, FLOOR(1 + RAND() * 100) AS Numero_Sorteig FROM dades_ponent;

-- Per fer les consultes 13, 14, i 15, has d'afegir un nou camp complex_rate, on no facis l'arrodoniment
-- (ja afegit i omplert a la secció de preparació)

-- * 13. La direcció vol veure els nivells dels ponents (complex_rate) sense complicacions de decimals per simplificar l'informe.
-- Mostra un llistat amb el nom del ponent i el seu 'complex_rate' truncat a 0 decimals, però només per a aquells que tinguin un 'rate' superior a 7.
SELECT nom, TRUNCATE(complex_rate, 0) AS complex_rate_truncat FROM dades_ponent WHERE rate > 7;

-- * 14. Per a un informe estadístic que anirà a premsa, necessitem arrodonir les puntuacions al sencer més proper.
-- Selecciona el nom, l'empresa i el 'complex_rate' arrodonit (ROUND), ordenant els resultats de major a menor puntuació.
SELECT nom, TRIM(empresa) AS empresa, ROUND(complex_rate) AS complex_rate_arrodonit
FROM ponent ORDER BY ROUND(complex_rate) DESC;

-- * 15. L'organització ha decidit ser generosa i pujar la categoria dels ponents al següent nivell sencer.
-- Obté el nom i el 'rate' arrodonit sempre a l'alça (CEILING) per a tots els ponents, excepte els que treballen a 'innovate asix'.
SELECT nom, CEILING(complex_rate) AS rate_ceiling
FROM ponent WHERE TRIM(empresa) != 'innovate asix';

-- 16. El departament de comptabilitat vol aplicar la política de "mínims de qualitat" en les valoracions internes.
-- Mostra el 'complex_rate' arrodonit sempre a la baixa (FLOOR) i el nom, filtrant només els ponents amb ID parell que tinguin un 'complex_rate' superior a 6.
SELECT nom, FLOOR(complex_rate) AS complex_rate_floor
FROM ponent WHERE MOD(id, 2) = 0 AND complex_rate > 6;

-- 17. S'ha detectat un error en l'entrada de dades manual i algunes puntuacions de 'rate' podrien haver-se gravat amb signe negatiu.
-- Fes una consulta que retorni el valor absolut del 'rate' i el nom del ponent.
SELECT nom, ABS(rate) AS rate_absolut FROM ponent;

-- 18. Necessitem calcular la potència de càlcul teòrica disponible segons els equips que aporta cada ponent.
-- Obté un llistat amb el nom i el resultat d'elevar 2 al nombre d'ordinadors, posant l'àlies 'Capacitat_Calcul'.
SELECT nom, POW(2, ordinadors) AS Capacitat_Calcul FROM ponent;

-- 19. Volem dividir els ponents en dos grups de treball segons si el seu identificador és parell o senar.
-- Fes un llistat que obtingui el nom del ponent i el residu de dividir l'ID per 2, ordenant per aquest residu.
SELECT nom, MOD(id, 2) AS residu FROM ponent ORDER BY residu;

-- 20. El departament de qualitat necessita conèixer la ràtio de "puntuació per equip" de cada expert.
-- Divideix el 'rate' pel nombre d'ordinadors, arrodoneix el resultat a 2 decimals i mostra el nom.
SELECT nom, ROUND(ABS(rate) / ordinadors, 2) AS ratio_puntuacio_equip FROM ponent;

-- 21. La gerència vol saber la dimensió total del cos de ponents.
-- Fes una consulta que compti quants ponents hi ha registrats en total.
SELECT COUNT(*) AS total_ponents FROM ponent;

-- 22. L'equip de logística necessita saber quants endolls i ordinadors s'han de gestionar en total.
-- Calcula la suma de la columna 'ordinadors' per a tots els ponents, amb l'àlies 'endolls'.
SELECT SUM(ordinadors) AS endolls FROM ponent;

-- 23. Per avaluar el nivell general de l'esdeveniment, volem saber la qualitat mitjana dels nostres ponents.
-- Obté la mitjana de la puntuació 'rate' i anomena la columna 'Mitjana_Qualitat'.
SELECT AVG(ABS(rate)) AS Mitjana_Qualitat FROM ponent;

-- 24. Volem felicitar el ponent que ha obtingut la millor valoració.
-- Troba quina és la puntuació 'rate' més alta registrada.
SELECT MAX(ABS(rate)) AS rate_maxim FROM ponent;

-- 25. Per planificar el transport, volem saber quina és la càrrega mínima de material informàtic.
-- Obté el nombre mínim d'ordinadors que porta un sol ponent.
SELECT MIN(ordinadors) AS min_ordinadors FROM ponent;

-- 26. El departament d'agenda vol confirmar el volum de continguts i xerrades programades.
-- Fes una consulta que compti quantes sessions o xerrades diferents hi ha programades.
SELECT COUNT(*) AS total_sessions FROM sessio;

-- 27. L'empresa patrocinadora 'tech corp' vol saber quants dels seus treballadors estan actius.
-- Compta quants ponents pertanyen a l'empresa 'tech corp'.
SELECT COUNT(*) AS total_tech_corp FROM ponent WHERE TRIM(empresa) = 'tech corp';

-- 28. Volem analitzar els recursos que aporten els ponents amb ID superior a 2.
-- Calcula la suma total d'ordinadors que porten aquests ponents.
SELECT SUM(ordinadors) AS total_ordinadors FROM ponent WHERE id > 2;

-- 29. L'organització vol donar un premi als ponents d'elit (rate 9 o 10).
-- Calcula la mitjana d'ordinadors que porten exclusivament els ponents amb rate >= 9.
SELECT AVG(ordinadors) AS mitjana_ordinadors_elit FROM ponent WHERE ABS(rate) >= 9;

-- 30. L'equip de publicacions vol saber el volum de text total dels títols.
-- Obté la suma de la longitud de tots els títols de les sessions programades.
SELECT SUM(LENGTH(titol)) AS suma_longitud_titols FROM sessio;

-- 31. Necessitem un informe del volum de participació corporativa.
-- Agrupa els ponents per empresa i mostra el nom de l'empresa i quants ponents n'hi ha de cada una.
SELECT TRIM(empresa) AS empresa, COUNT(*) AS num_ponents FROM ponent GROUP BY TRIM(empresa);

-- 32. Volem saber com es distribueixen els equips informàtics segons el nivell d'expertesa.
-- Agrupa per cada nivell de 'rate' i calcula la suma total d'ordinadors per a cadascun.
SELECT ABS(rate) AS rate, SUM(ordinadors) AS total_ordinadors FROM ponent GROUP BY ABS(rate);

-- 33. Hi ha sales que podrien estar massa saturades si tenen massa xerrades assignades.
-- Obté el nom de les sales que tenen més d'una sessió programada.
SELECT sala, COUNT(*) AS num_sessions FROM sessio GROUP BY sala HAVING COUNT(*) > 1;

-- 34. Volem analitzar si els experts tenen prou eines segons el seu nivell acadèmic.
-- Agrupa els ponents pel seu 'rate', mostra la mitjana d'equips i filtra on la mitjana superi 1.
SELECT ABS(rate) AS rate, AVG(ordinadors) AS mitjana_ordinadors
FROM ponent GROUP BY ABS(rate) HAVING AVG(ordinadors) > 1;

-- 35. L'equip de dades vol fer una estadística de les inicials dels ponents.
-- Mostra la primera lletra del nom i quants ponents tenen aquesta inicial, agrupat i ordenat pel recompte.
SELECT LEFT(nom, 1) AS inicial, COUNT(*) AS num_ponents
FROM ponent GROUP BY LEFT(nom, 1) ORDER BY num_ponents;

-- 36. Hi ha ponents que encara no han estat avaluats i la columna 'rate' té valors buits o desconeguts.
-- Mostra un llistat amb el nom i el 'rate', però si el valor és NULL, mostra un 5 com a valor mínim de seguretat.
SELECT nom, IFNULL(rate, 5) AS rate FROM ponent;

-- 37. Per a la llista pública de ponents a la web, no volem que ningú aparegui sense empresa assignada.
-- Obté el nom i cognom, i si un ponent no té empresa, mostra el text 'Freelance'.
SELECT nom, cognom1, IFNULL(TRIM(empresa), 'Freelance') AS Empresa_Publica FROM ponent;

-- 38. Volem automatitzar la classificació visual dels ponents segons la seva valoració.
-- Crea un llistat amb una columna 'Estatus' que mostri 'Expert' si el rate és >= 9 i 'Standard' en cas contrari.
SELECT nom, IF(ABS(rate) >= 9, 'Expert', 'Standard') AS Estatus FROM ponent;

-- 39. Logística vol saber quines sales necessiten reforç de personal de protocol.
-- Mostra el títol de la sessió i 'Sala_Principal' si és a la 'sala a' o 'Sala_Secundaria' si és a qualsevol altra.
SELECT titol,
  IF(sala = 'sala a', 'Sala_Principal', 'Sala_Secundaria') AS tipus_sala
FROM sessio;

-- 40. El departament de recursos humans vol una escala de rangs clara per classificar els perfils.
-- Mostra el nom i l'empresa, i usa CASE WHEN per mostrar: 5-6 'Junior', 7-8 'Senior', 9-10 'Master'.
SELECT nom, TRIM(empresa) AS empresa,
  CASE
    WHEN ABS(rate) BETWEEN 5 AND 6 THEN 'Junior'
    WHEN ABS(rate) BETWEEN 7 AND 8 THEN 'Senior'
    WHEN ABS(rate) BETWEEN 9 AND 10 THEN 'Master'
    ELSE 'Sense rang'
  END AS rang
FROM ponent;

-- 41. El sistema de seguretat necessita imprimir en cada informe el dia exacte en què s'ha consultat la base de dades.
-- Fes una consulta que mostri la data actual del servidor amb l'àlies 'Data_Consulta'.
SELECT CURDATE() AS Data_Consulta;

-- 42. Per al registre de logs de l'aplicació mòbil, necessitem el segell de temps complet.
-- Obté la data i l'hora exacta del sistema (NOW) en una columna anomenada 'Timestamp_Execucio'.
SELECT NOW() AS Timestamp_Execucio;

-- 43. Volem saber quant de temps de marge tenim des que va començar l'any del congrés.
-- Calcula quants dies han passat des de l'1 de gener de 2026 fins al dia d'avui.
SELECT DATEDIFF(CURDATE(), '2026-01-01') AS dies_des_de_any;

-- 44. El servei de neteja només necessita saber a quina hora en punt comencen les sessions.
-- Mostra el títol de la sessió i només el valor de l'hora d'inici (sense minuts), ordenat cronològicament.
SELECT titol, HOUR(hora) AS hora_inici FROM sessio ORDER BY hora ASC;

-- 45. L'equip del catering vol organitzar els torns de l'esmorzar i del dinar.
-- Mostra el títol de la sessió i posa 'Torn_1' si l'hora és anterior a les 11:30:00, o 'Torn_2' si és posterior.
SELECT titol,
  IF(hora < '11:30:00', 'Torn_1', 'Torn_2') AS torn
FROM sessio;

-- 46. Per a un missatge de benvinguda automatitzat, volem ajuntar el nom del ponent i la data actual.
-- Mostra un llistat que ajunti en una sola columna el nom del professor i la data d'avui (CURDATE).
SELECT CONCAT(nom, ' - ', CURDATE()) AS benvinguda FROM ponent;

-- 47. El tècnic de so vol saber quants minuts han passat des de l'inici del dia per a cada sessió.
-- Calcula el total de minuts que transcorren de les 00:00:00 per a cada sessió a partir de la seva hora d'inici.
SELECT titol, (HOUR(hora) * 60 + MINUTE(hora)) AS minuts_des_de_mitjanit FROM sessio;

-- 48. Per motius de traçabilitat, volem saber quin usuari és el responsable de les consultes actuals.
-- Selecciona el nom de l'usuari que està connectat actualment a la base de dades.
SELECT USER() AS usuari_connectat;

-- 49. El servei de manteniment informàtic ha de verificar si el servidor és prou modern per al nou programari.
-- Obté una consulta que retorni la versió del servidor de base de dades.
SELECT VERSION() AS versio_servidor;

-- 50. Volem confirmar que estem operant sobre la base de dades de l'esdeveniment i no sobre una de proves.
-- Mostra el nom de la base de dades que està activa en aquest instant.
SELECT DATABASE() AS base_de_dades_activa;

-- 51. Per protegir les dades personals en fitxers externs, volem crear un identificador xifrat basat en el cognom.
-- Genera un codi MD5 a partir del cognom del ponent i mostra'l al costat del seu nom real.
SELECT nom, MD5(cognom1) AS codi_md5 FROM ponent;

-- 52. Per exportar els llistats a un sistema de correu antic, necessitem un format de text pla senzill.
-- Concatena el nom, el cognom i l'empresa separats per barres verticals ('|') i posa l'àlies 'Registre_Exportacio'.
SELECT CONCAT(nom, '|', cognom1, '|', IFNULL(TRIM(empresa), 'Freelance')) AS Registre_Exportacio FROM ponent;

-- 53. Els títols de les sessions a la web han de seguir un format de codi d'URL sense espais.
-- Mostra el títol en majúscules i canvia tots els espais per guions baixos ('_'), filtrant només les sessions de la 'sala b'.
SELECT REPLACE(UPPER(titol), ' ', '_') AS titol_url FROM sessio WHERE sala = 'sala b';

-- 54. Volem saber quina és la xerrada amb el títol més llarg per ajustar el tamany de la lletra.
-- Obté la longitud del títol més extens de tota la taula de sessions.
SELECT MAX(LENGTH(titol)) AS longitud_titol_maxima FROM sessio;

-- 55. El departament de disseny vol imprimir unes xapes rodones petites on només hi caben noms de 4 caràcters.
-- Selecciona el nom i cognom dels ponents que tenen un nom de exactament 4 caràcters, ordenats per l'empresa.
SELECT nom, cognom1 FROM ponent WHERE LENGTH(nom) = 4 ORDER BY empresa;

-- 56. Per a un joc de pistes durant el descans, volem mostrar només una part del nom dels ponents.
-- Mostra les lletres que van de la posició 2 a la 5 del nom de cada ponent i anomena la columna 'Pista_Nom'.
SELECT SUBSTRING(nom, 2, 4) AS Pista_Nom FROM ponent;

-- 57. Volem crear un efecte visual curiós en la pantalla de benvinguda de la sala d'actes.
-- Mostra el nom del ponent i el seu mateix nom escrit totalment a l'inrevés (REVERSE).
SELECT nom, REVERSE(nom) AS nom_invers FROM ponent;

-- 58. El departament de qualitat vol simular un increment del 25% en totes les puntuacions de nivell.
-- Multiplica el 'rate' per 1.25, arrodoneix el resultat a 1 decimal i mostra-ho al costat del nom.
SELECT nom, ROUND(ABS(rate) * 1.25, 1) AS rate_incrementat FROM ponent;

-- 59. L'equip de dades necessita fer una operació matemàtica complexa sobre els identificadors de les xerrades.
-- Calcula el quadrat de l'ID de cada sessió i obté la suma total de tots aquests valors quadràtics.
SELECT SUM(POW(id, 2)) AS suma_quadrats_ids FROM sessio;

-- 60. Volem generar uns codis de seguretat exponencials per als ponents.
-- Obté un llistat amb l'ID del ponent i el resultat d'elevar l'ID al seu propi valor d'ID, amb l'àlies 'Hash_Exponencial'.
SELECT id, POW(id, id) AS Hash_Exponencial FROM ponent;

-- 61. Per donar visibilitat a tothom, volem triar un ponent a l'atzar cada vegada que carreguem la web.
-- Obté el nom i l'empresa d'un sol ponent triat de forma aleatòria.
SELECT nom, TRIM(empresa) AS empresa FROM ponent ORDER BY RAND() LIMIT 1;

-- 62. Volem fer tres torns diferents de recollida d'acreditacions.
-- Fes un llistat que mostri el nom del ponent i el residu de dividir el seu ID per 3.
SELECT nom, MOD(id, 3) AS torn FROM ponent;

-- 63. La impremta ens pregunta quina és l'empresa amb el nom més curt per estalviar espai en els fulletons.
-- Troba quina és la longitud mínima del camp empresa i mostra també el nom d'aquella empresa específica.
SELECT TRIM(empresa) AS empresa, LENGTH(TRIM(empresa)) AS longitud
FROM ponent
WHERE LENGTH(TRIM(empresa)) = (SELECT MIN(LENGTH(TRIM(empresa))) FROM ponent WHERE empresa IS NOT NULL)
LIMIT 1;

-- 64. Necessitem un llistat informatiu per als panells de cada planta que indiqui la sessió i la sala.
-- Fes un llistat que mostri concatenat el text 'Xerrada: ', el títol, ' Ubicació: ' i la sala.
SELECT CONCAT('Xerrada: ', titol, ' Ubicació: ', sala) AS Guia_Sessio FROM sessio;

-- 65. Per evitar que la web mostri espais buits quan un ponent no porta material propi.
-- Mostra un llistat amb el nom del ponent i el nombre d'ordinadors, però si és NULL, mostra el text 'Material_Propi'.
SELECT nom, IFNULL(CAST(ordinadors AS CHAR), 'Material_Propi') AS ordinadors FROM ponent;

-- 66. L'equip de manteniment vol saber el volum de feina a la 'sala a' i la 'sala b'.
-- Compta quantes sessions es fan en aquestes dues sales en total.
SELECT COUNT(*) AS total_sessions FROM sessio WHERE sala IN ('sala a', 'sala b');

-- 67. Volem analitzar l'impacte dels ponents que pertanyen a l'empresa 'innovate asix'.
-- Obté la suma de tots els IDs dels ponents que treballen en aquesta empresa concreta.
SELECT SUM(id) AS suma_ids_innovate FROM ponent WHERE TRIM(empresa) = 'innovate asix';

-- 68. Per a un estudi sobre la diversitat de noms en els congressos de tecnologia.
-- Obté quina és la mitjana de caràcters (longitud) que tenen els cognoms de tots els ponents.
SELECT AVG(LENGTH(cognom1)) AS mitjana_longitud_cognoms FROM ponent;

-- 69. Per a un format de llista més compacte per a dispositius mòbils antics.
-- Fes un llistat que mostri el nom del ponent i només la primera lletra del seu cognom seguida d'un punt (ex: 'anna g.').
SELECT CONCAT(nom, ' ', LEFT(cognom1, 1), '.') AS format_compacte FROM ponent;

-- 70. El cost d'assegurar cada ordinador que entra a l'edifici és de 50€.
-- Calcula quin és el cost total d'assegurança per a cada ponent.
SELECT nom, (ordinadors * 50) AS cost_asseguranca FROM ponent;

-- 71. L'equip de coordinació de tarda necessita la graella de xerrades a partir del migdia.
-- Selecciona totes les sessions que comencen a les 13:00:00 o més tard, mostrant el títol i l'hora d'inici.
SELECT titol, hora FROM sessio WHERE hora >= '13:00:00';

-- 72. Volem detectar títols de xerrades que puguin tenir espais innecessaris que trenquin el disseny.
-- Mostra el títol i una columna amb la diferència entre la seva longitud real i la longitud sense espais.
SELECT titol, (LENGTH(titol) - LENGTH(REPLACE(titol, ' ', ''))) AS espais_al_titol FROM sessio;

-- 73. Per a un exercici de nivell variable, volem establir un llindar de referència que canviï.
-- Genera un número aleatori que es trobi exactament entre el valor mínim de 'rate' i el valor màxim guardats a la taula.
SELECT (MIN(ABS(rate)) + RAND() * (MAX(ABS(rate)) - MIN(ABS(rate)))) AS llindar_aleatori FROM ponent;

-- 74. Volem saber quins noms de ponent són més "sonors" per a la megafonia.
-- Obté un llistat dels ponents que tenen més d'una lletra 'a' al seu nom.
SELECT nom FROM ponent
WHERE (LENGTH(nom) - LENGTH(REPLACE(nom, 'a', ''))) > 1;

-- 75. Per a la pòlissa de riscos laborals, necessitem calcular l'IVA dels equips.
-- Obté el 21% de la suma total d'ordinadors de tots els ponents multiplicada per una base de 100€ per unitat.
SELECT (SUM(ordinadors) * 100 * 0.21) AS iva_equips FROM ponent;

-- 76. El departament de trànsit de persones vol saber quins horaris estan més saturats de xerrades.
-- Agrupa les sessions per l'hora d'inici i mostra l'hora i quantes n'hi ha a cada franja.
SELECT HOUR(hora) AS hora_inici, COUNT(*) AS num_sessions FROM sessio GROUP BY HOUR(hora);

-- 77. Per crear els indicadors que aniran penjats del sostre dels passadissos.
-- Fes un llistat que mostri la sala i el títol de la sessió ajuntats amb una fletxa " >>> ".
SELECT CONCAT(sala, ' >>> ', titol) AS Indicador_Direccio FROM sessio;

-- 78. Volem identificar el cognom més llarg per assegurar-nos que cap nom queda tallat.
-- Troba el cognom que té més caràcters i mostra la seva longitud màxima.
SELECT MAX(LENGTH(cognom1)) AS longitud_cognom_maxima FROM ponent;

-- 79. Necessitem un filtre ràpid per a la gestió d'accessos: matí o tarda.
-- Fes un llistat amb una columna que mostri 'MATI' si la sessió comença abans de les 14:00:00 o 'TARDA' si comença més tard.
SELECT titol,
  IF(hora < '14:00:00', 'MATI', 'TARDA') AS torn_del_dia
FROM sessio;

-- 80. Volem comparar la diferència tècnica entre els dos ponents més veterans (ID 1 i ID 2).
-- Calcula la diferència absoluta entre el nombre d'equips del ponent amb ID 1 i el ponent amb ID 2 en una sola consulta.
SELECT ABS(
  (SELECT ordinadors FROM ponent WHERE id = 1) -
  (SELECT ordinadors FROM ponent WHERE id = 2)
) AS diferencia_equips;

-- 81. Per a la secció de crèdits finals de la web, volem un ordre alfabètic invers.
-- Mostra el títol de totes les sessions en minúscules i ordenades de la Z a la A.
SELECT LOWER(titol) AS titol FROM sessio ORDER BY titol DESC;

-- 82. Volem saber la riquesa de col·laboracions empresarials que tenim en aquesta edició.
-- Compta quantes empreses diferents (sense repetir) participen en total.
SELECT COUNT(DISTINCT TRIM(empresa)) AS empreses_diferents FROM ponent;

-- 83. Per crear un efecte animat de càrrega de dades en el panell de l'administrador.
-- Mostra l'ID, el nom i una columna nova on el nom aparegui repetit 5 vegades seguides per a cada registre.
SELECT id, nom, REPEAT(nom, 5) AS nom_repetit FROM ponent;

-- 84. Hi ha hagut un canvi d'última hora en el nom de les instal·lacions de l'esdeveniment.
-- Obté un llistat on la paraula 'sala' aparegui substituïda pel text 'AULARI_TECNIC'.
SELECT REPLACE(sala, 'sala', 'AULARI_TECNIC') AS sala_nova FROM sessio;

-- 85. Per a les estadístiques que s'enviaran a la Generalitat, necessitem la mitjana d'equips sense decimals.
-- Calcula la mitjana d'ordinadors de tots els ponents i trunca el resultat per mostrar només la part entera.
SELECT TRUNCATE(AVG(ordinadors), 0) AS mitjana_ordinadors_truncada FROM ponent;

-- 86. Si el prestigi dels nostres professors augmenta de manera exponencial segons la seva nota actual.
-- Calcula el 'rate' elevat al quadrat per a cada ponent i mostra el resultat al costat de la seva empresa.
SELECT TRIM(empresa) AS empresa, POW(ABS(rate), 2) AS rate_quadrat FROM ponent;

-- 87. Per a un sistema d'etiquetatge que segueix les normes d'arxiu tradicionals.
-- Fes un llistat que mostri el cognom en majúscules, seguit d'una coma i el nom original (ex: 'ROVIRA, marc').
SELECT CONCAT(UPPER(cognom1), ', ', nom) AS etiqueta_arxiu FROM ponent;

-- 88. L'equip de màrqueting ja està pensant en el Tech Summit del 2027.
-- Calcula quants dies falten des d'avui mateix fins al 15 de febrer de 2027.
SELECT DATEDIFF('2027-02-15', CURDATE()) AS dies_fins_2027;

-- 89. Volem trobar ràpidament quines xerrades tracten sobre Intel·ligència Artificial.
-- Mostra el títol de la sessió i la posició numèrica on apareix el text 'ia' dins del títol.
SELECT titol, LOCATE('ia', titol) AS posicio_ia FROM sessio;

-- 90. Per a una integració amb un sistema de gestió d'hotels que només accepta camps de 20 caràcters fixos.
-- Mostra el nom del ponent omplint amb asteriscs '*' a l'esquerra fins a arribar exactament als 20 caràcters.
SELECT LPAD(nom, 20, '*') AS nom_padded FROM ponent;

-- 91. Volem crear una puntuació de referència paral·lela que no canviï cada vegada que s'executa la consulta.
-- Mostra el 'rate' multiplicat per un número aleatori fixant la llavor (seed) amb el número 50.
SELECT nom, (ABS(rate) * RAND(50)) AS rate_seed FROM ponent;

-- 92. El departament de manteniment vol fer una revisió als ponents que porten un nombre parell d'ordinadors.
-- Selecciona tots els ponents que porten un nombre parell d'ordinadors i mostra el seu nom i cognom.
SELECT nom, cognom1 FROM ponent WHERE MOD(ordinadors, 2) = 0;

-- 93. Per a la creació de comptes de correu temporals per a l'ús de la xarxa Wi-Fi interna.
-- Fes un llistat que mostri concatenat el nom del ponent amb el sufix '@itb.cat'.
SELECT CONCAT(nom, '@itb.cat') AS Email_WiFi_Intern FROM ponent;

-- 94. El departament d'anàlisi estratègica vol una xifra d'impacte tecnològic per cada expert.
-- Calcula el valor del 'rate' elevat al nombre d'ordinadors per a cada ponent i mostra també la seva empresa.
SELECT TRIM(empresa) AS empresa, POW(ABS(rate), ordinadors) AS impacte_tecnologic FROM ponent;

-- 95. Per a la capçalera de l'informe de tancament de trimestre.
-- Mostra la data d'avui i el número del mes actual en dues columnes amb àlies propis.
SELECT CURDATE() AS Data_Avui, MONTH(CURDATE()) AS Mes_Actual;

-- 96. Volem preveure l'espai i el consum elèctric si l'any vinent cada ponent d''innovate asix' portés 2 ordinadors més.
-- Mostra el nom i el nombre d'ordinadors actuals sumant-li 2 unitats, només per als ponents d'aquesta empresa.
SELECT nom, (ordinadors + 2) AS ordinadors_futurs
FROM ponent WHERE TRIM(empresa) = 'innovate asix';

-- 97. Per crear un efecte de misteri en els fulletons publicitaris de les xerrades.
-- Selecciona el títol de cada sessió però retalla'l de manera que no es mostrin les 3 darreres lletres.
SELECT LEFT(titol, LENGTH(titol) - 3) AS titol_misteri FROM sessio;

-- 98. Volem donar un tracte preferent en la llista de trasllats al ponent que es va inscriure primer.
-- Mostra el nom i una columna que digui 'Cap_de_Llista' si l'ID és igual a 1, o 'Resta_de_Ponents' en cas contrari.
SELECT nom,
  IF(id = 1, 'Cap_de_Llista', 'Resta_de_Ponents') AS posicio_llista
FROM ponent;

-- 99. Per a un índex ràpid de participació que sumi el nivell acadèmic i els recursos materials.
-- Obté la suma de les columnes 'rate' i 'ordinadors' per a cada ponent en una columna anomenada 'Index_Global'.
SELECT nom, (ABS(rate) + ordinadors) AS Index_Global FROM ponent;

-- 100. Per donar per finalitzat el llistat oficial de dades del Tech Summit 2026.
-- Selecciona el nom, el cognom i l'empresa, i afegeix una darrera columna fixa amb el text 'REGISTRE_VERIFICAT'.
SELECT nom, cognom1, TRIM(empresa) AS empresa, 'REGISTRE_VERIFICAT' AS estat FROM ponent;