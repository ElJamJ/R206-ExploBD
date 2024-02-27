-- EX1

CREATE TABLE typeChalet (
    NumTypeChalet INT PRIMARY KEY,
    NomTypeChalet VARCHAR2(20),
    Capacite INT,
    Descript VARCHAR2(20)
);

CREATE TABLE baseLoisir (
    NumBaseL INT PRIMARY KEY,
    NomBaseL VARCHAR2(20),
    AdrBaseL VARCHAR2(20),
    CPBaseL INT,
    VilleBaseL VARCHAR2(20)
);

CREATE TABLE camping(
    NumCamping INT PRIMARY KEY,
    NomCamping VARCHAR2(30) CONSTRAINT nomChaletUnique UNIQUE,
    AdrCamping VARCHAR2(100),
    CPCamping NUMBER(8),
    VilleCamping VARCHAR2(30),
    TelCamping VARCHAR2(20),
    BaseLoisirs INT,
    DateOuv DATE,
    DateFerm DATE,
    CONSTRAINT DateCoherence CHECK(DateOuv < DateFerm),
    NbEtoiles NUMBER(1) CONSTRAINT nombreEtoiles CHECK(NbEtoiles BETWEEN 0 AND 4),
    QualiteFrance VARCHAR2(3) DEFAULT 'Non' CHECK (QualiteFrance IN ('Oui', 'Non')),
    FOREIGN KEY (BaseLoisirs) REFERENCES baseLoisirs(NumBaseL)
);

CREATE TABLE compoCamping (
    NumCamping INT,
    NumTypeChalet INT,
    NbreChalet INT,
    PRIMARY KEY (NumCamping, NumTypeChalet),
    FOREIGN KEY (NumTypeChalet) REFERENCES typeChalet (NumTypeChalet),
    FOREIGN KEY (NumCamping) REFERENCES camping (NumCamping)
);


-- DROP TABLE compoCamping;
-- DROP TABLE camping;
-- DROP TABLE baseLoisir;
-- DROP TABLE typeChalet;

-- EX2