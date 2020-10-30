--1. feladat, Létrehozás
CREATE DATABASE szinesz
CHARACTER SET utf8
COLLATE utf8_hungarian_ci;

CREATE TABLE szinesz.hallgato (
  id int(11) NOT NULL,
  osztalyid int(11) NOT NULL,
  nev varchar(255) NOT NULL,
  ferfi tinyint(1) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

CREATE TABLE szinesz.osztaly (
  id int(11) NOT NULL,
  kezdeseve int(11) NOT NULL,
  vegzeseve int(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

CREATE TABLE szinesz.tanitja (
  id int(11) NOT NULL,
  tanarid int(11) NOT NULL,
  osztalyid int(11) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

CREATE TABLE szinesz.tanar (
  id int(11) NOT NULL,
  nev varchar(255) NOT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_hungarian_ci;

--A táblák és mezők létrehozása után importálom az adatokat a txt állományokból

--2. feladat, Bach Kata
INSERT INTO hallgato (id,osztalyid,nev,ferfi)
  VALUES ((SELECT MAX(ID) FROM hallgato)+1,(SELECT MAX(osztalyid) FROM hallgato),'Bach Kata', 0);

--3. feladat, 5 éves képzések évei
SELECT kezdeseve
FROM osztaly
WHERE vegzeseve-kezdeseve=5
ORDER BY kezdeseve;

--4. feladat, '70-es években egynél több osztállyal rendelkező tanárok
SELECT tanar.nev
FROM tanar, tanitja, osztaly
WHERE (((tanar.id)=[tanitja].[tanarid]) 
    AND ((tanitja.osztalyid)=[osztaly].[id])
    AND ((osztaly.[vegzeseve]) Between 1970 And 1979))
GROUP BY tanar.nev
HAVING (((Count(tanitja.[osztalyid]))>1));

--5. feladat, Mikor nem indult először osztály
SELECT TOP 1 [kezdeseve]+1
FROM osztaly
WHERE (([kezdeseve]+1 Not In (SELECT kezdeseve FROM osztaly)))
GROUP BY [kezdeseve]+1
ORDER BY Min([kezdeseve]+1);


--6. feladat, Hány osztálynak nincs tanára
SELECT Count(id) AS hiányzik
FROM osztaly
WHERE (((osztaly.[id]) Not In (SELECT osztalyid FROM tanitja)));

--7. feladat, Mikor kezdtek el tanítani azok a tanárok, akik az SZFE-n tanultak
SELECT tanar.nev, Min(tanarosztaly.kezdeseve) AS kezdes
FROM tanar, tanitja, osztaly AS tanarosztaly, osztaly AS hallgatoosztaly, hallgato
WHERE tanar.id=tanitja.tanarid
    AND tanitja.osztalyid=tanarosztaly.id
    AND tanar.nev=hallgato.nev
    AND hallgato.osztalyid=hallgatoosztaly.id
GROUP BY tanar.nev;
