DROP DATABASE IF EXISTS MLR3;

CREATE DATABASE IF NOT EXISTS MLR3;
ALTER DATABASE MLR3 CHARACTER SET utf8 COLLATE utf8_general_ci;
USE MLR3;

# -----------------------------------------------------------------------------
#       TABLE : SALARI�
# -----------------------------------------------------------------------------
CREATE TABLE SALARI�
 (
   NOM_S VARCHAR (30) NOT NULL  ,
   LIBELL�_P VARCHAR (30) NOT NULL  ,
   NOM_S_CHEF_DE_PROJET VARCHAR (30) NULL  ,
   PR�NOM VARCHAR (30) NOT NULL  ,
   EMPLOI VARCHAR (30) NOT NULL  ,
   ANCIENNET� DATE NULL  
   , PRIMARY KEY (NOM_S) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE SALARI�
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_SALARI�_PROJET ON SALARI� (LIBELL�_P ASC asc);
CREATE INDEX I_FK_SALARI�_SALARI� ON SALARI� (NOM_S_CHEF_DE_PROJET ASC asc);

# -----------------------------------------------------------------------------
#       TABLE : T�CHES
# -----------------------------------------------------------------------------
CREATE TABLE T�CHES
 (
   LIBELL�_T VARCHAR (30) NOT NULL  ,
   DUR�E DATE NOT NULL  ,
   COUT DECIMAL (13,2) NOT NULL  ,
   DATE_D�BUT DATE NOT NULL  ,
   DATE_FIN DATE NOT NULL  
   , PRIMARY KEY (LIBELL�_T) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# -----------------------------------------------------------------------------
#       TABLE : CLIENT
# -----------------------------------------------------------------------------
CREATE TABLE CLIENT
 (
   NOM VARCHAR (30) NOT NULL  ,
   ADRESSE VARCHAR (128) NULL  ,
   NOM_DIRECTEUR VARCHAR (30) NOT NULL  ,
   NOM_INTERLOCUTEUR VARCHAR (30) NOT NULL  
   , PRIMARY KEY (NOM) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# -----------------------------------------------------------------------------
#       TABLE : PROJET
# -----------------------------------------------------------------------------
CREATE TABLE PROJET
 (
   LIBELL�_P VARCHAR (30) NOT NULL  ,
   NOM VARCHAR (30) NOT NULL  ,
   DATE_D�BUT DATE NOT NULL  ,
   DATE_FIN DATE NULL  ,
   DUR�E_PR�VU DATE NOT NULL  
   , PRIMARY KEY (LIBELL�_P) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE PROJET
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_PROJET_CLIENT ON PROJET (NOM ASC asc);

# -----------------------------------------------------------------------------
#       TABLE : COMP�TENCE_SALARIALE
# -----------------------------------------------------------------------------
CREATE TABLE COMP�TENCE_SALARIALE
 (
   COMP�TENCE_SALARI� VARCHAR (30) NOT NULL  ,
   NIVEAU_QUALIFICATION INTEGER NOT NULL  ,
   ORDRE_GRANDEUR INTEGER NOT NULL  ,
   ANN�E_COMP�TENCE_D�BUT DATE NOT NULL  
   , PRIMARY KEY (COMP�TENCE_SALARI�) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# -----------------------------------------------------------------------------
#       TABLE : POSS�DE
# -----------------------------------------------------------------------------
CREATE TABLE POSS�DE
 (
   NOM_S VARCHAR (30) NOT NULL  ,
   COMP�TENCE_SALARI� VARCHAR (30) NOT NULL  
   , PRIMARY KEY (NOM_S,COMP�TENCE_SALARI�) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE POSS�DE
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_POSS�DE_SALARI� ON POSS�DE (NOM_S ASC asc);
CREATE INDEX I_FK_POSS�DE_COMP�TENCE_SALARIALE ON POSS�DE (COMP�TENCE_SALARI� ASC asc);

# -----------------------------------------------------------------------------
#       TABLE : MAT�RIEL
# -----------------------------------------------------------------------------
CREATE TABLE MAT�RIEL
 (
   LIBELL�_T VARCHAR (30) NOT NULL  ,
   NOM_S VARCHAR (30) NOT NULL  ,
   NOM VARCHAR (30) NULL  ,
   TYPE VARCHAR (30) NULL  
   , PRIMARY KEY (LIBELL�_T,NOM_S) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE MAT�RIEL
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_MAT�RIEL_T�CHES ON MAT�RIEL (LIBELL�_T ASC asc);
CREATE INDEX I_FK_MAT�RIEL_SALARI� ON MAT�RIEL (NOM_S ASC asc);

# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------

ALTER TABLE SALARI� 
  ADD FOREIGN KEY FK_SALARI�_PROJET (LIBELL�_P) REFERENCES PROJET (LIBELL�_P) ;

ALTER TABLE SALARI� 
  ADD FOREIGN KEY FK_SALARI�_SALARI� (NOM_S_CHEF_DE_PROJET) REFERENCES SALARI� (NOM_S) ;

ALTER TABLE PROJET 
  ADD FOREIGN KEY FK_PROJET_CLIENT (NOM) REFERENCES CLIENT (NOM) ;

ALTER TABLE POSS�DE 
  ADD FOREIGN KEY FK_POSS�DE_SALARI� (NOM_S) REFERENCES SALARI� (NOM_S) ;

ALTER TABLE POSS�DE 
  ADD FOREIGN KEY FK_POSS�DE_COMP�TENCE_SALARIALE (COMP�TENCE_SALARI�) REFERENCES COMP�TENCE_SALARIALE (COMP�TENCE_SALARI�) ;

ALTER TABLE MAT�RIEL 
  ADD FOREIGN KEY FK_MAT�RIEL_T�CHES (LIBELL�_T) REFERENCES T�CHES (LIBELL�_T) ;

ALTER TABLE MAT�RIEL 
  ADD FOREIGN KEY FK_MAT�RIEL_SALARI� (NOM_S) REFERENCES SALARI� (NOM_S) ;

