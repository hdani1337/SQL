-- A feladatok megoldására elkészített SQL parancsokat illessze be a feladat sorszáma után!


-- 8. feladat:
CREATE DATABASE `2020_maj_szakmai`
	CHARACTER SET utf8
	COLLATE utf8_hungarian_ci;

-- 10. feladat:
USE 2020_maj_szakmai;
UPDATE megyek SET megyenev = "Budapest"
  WHERE megyenev = "BP";

-- 11. feladat:
SELECT
  konyvtarak.konyvtarNev,
  telepulesek.irsz
FROM konyvtarak
  INNER JOIN telepulesek
    ON konyvtarak.irsz = telepulesek.irsz
  INNER JOIN megyek
    ON telepulesek.megyeId = megyek.id
  WHERE konyvtarak.konyvtarNev LIKE "%Szakkönyvtár%";

-- 12. feladat:
SELECT
  konyvtarak.konyvtarNev,
  telepulesek.irsz,
  konyvtarak.cim
FROM konyvtarak
  INNER JOIN telepulesek
    ON konyvtarak.irsz = telepulesek.irsz
  INNER JOIN megyek
    ON telepulesek.megyeId = megyek.id
  WHERE konyvtarak.irsz LIKE "1%";
ORDER BY konyvtarak.irsz;


-- 13. feladat:
SELECT
  telepulesek.telepNev,
  COUNT(telepulesek.telepNev) AS konyvtarDarab
FROM konyvtarak
  INNER JOIN telepulesek
    ON konyvtarak.irsz = telepulesek.irsz
GROUP BY telepulesek.telepNev
HAVING konyvtarDarab > 6;


-- 14. feladat:
SELECT
  megyek.megyeNev,
  COUNT(telepulesek.irsz) AS telepulesDarab
FROM telepulesek
  INNER JOIN megyek
    ON telepulesek.megyeId = megyek.id
  WHERE megyek.megyeNev NOT LIKE "Budapest"
GROUP BY megyek.megyeNev
  ORDER BY telepulesDarab DESC;



