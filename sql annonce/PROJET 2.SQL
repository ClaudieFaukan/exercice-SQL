DROP DATABASE IF EXISTS Projet 2;

CREATE DATABASE IF NOT EXISTS Projet 2;
ALTER DATABASE Projet 2 CHARACTER SET utf8 COLLATE utf8_general_ci;
USE Projet 2;

# -----------------------------------------------------------------------------
#       TABLE : SALARIÉ
# -----------------------------------------------------------------------------
CREATE TABLE  SALARIÉ
 (
   NOM_S VARCHAR (30) NOT NULL  ,
   LIBELLÉ_P VARCHAR (30) NOT NULL  ,
   NOM_S_CHEF_DE_PROJET VARCHAR (30) NULL  ,
   PRÉNOM VARCHAR (30) NOT NULL  ,
   EMPLOI VARCHAR (30) NOT NULL  ,
   ANCIENNETÉ DATE NULL  
   , PRIMARY KEY (NOM_S) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE SALARIÉ
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_SALARIÉ_PROJET ON SALARIÉ (LIBELLÉ_P ASC);
CREATE INDEX I_FK_SALARIÉ_SALARIÉ ON SALARIÉ (NOM_S_CHEF_DE_PROJET ASC);

# -----------------------------------------------------------------------------
#       TABLE : TÂCHES
# -----------------------------------------------------------------------------
CREATE TABLE  TÂCHES
 (
   LIBELLÉ_T VARCHAR (30) NOT NULL  ,
   DURÉE DATE NOT NULL  ,
   COUT DECIMAL (13,2) NOT NULL  ,
   DATE_DÉBUT DATE NOT NULL  ,
   DATE_FIN DATE NOT NULL  
   , PRIMARY KEY (LIBELLÉ_T) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# -----------------------------------------------------------------------------
#       TABLE : CLIENT
# -----------------------------------------------------------------------------
CREATE TABLE  CLIENT
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
CREATE TABLE  PROJET
 (
   LIBELLÉ_P VARCHAR (30) NOT NULL  ,
   NOM VARCHAR (30) NOT NULL  ,
   DATE_DÉBUT DATE NOT NULL  ,
   DATE_FIN DATE NULL  ,
   DURÉE_PRÉVU DATE NOT NULL  
   , PRIMARY KEY (LIBELLÉ_P) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE PROJET
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_PROJET_CLIENT ON PROJET (NOM ASC);

# -----------------------------------------------------------------------------
#       TABLE : COMPÉTENCE_SALARIALE
# -----------------------------------------------------------------------------
CREATE TABLE  COMPÉTENCE_SALARIALE
 (
   COMPÉTENCE_SALARIÉ VARCHAR (30) NOT NULL  ,
   NIVEAU_QUALIFICATION INTEGER NOT NULL  ,
   ORDRE_GRANDEUR INTEGER NOT NULL  ,
   ANNÉE_COMPÉTENCE_DÉBUT DATE NOT NULL  
   , PRIMARY KEY (COMPÉTENCE_SALARIÉ) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# -----------------------------------------------------------------------------
#       TABLE : POSSÈDE
# -----------------------------------------------------------------------------
CREATE TABLE  POSSÈDE
 (
   NOM_S VARCHAR (30) NOT NULL  ,
   COMPÉTENCE_SALARIÉ VARCHAR (30) NOT NULL  
   , PRIMARY KEY (NOM_S,COMPÉTENCE_SALARIÉ) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE POSSÈDE
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_POSSÈDE_SALARIÉ ON POSSÈDE (NOM_S ASC);
CREATE INDEX I_FK_POSSÈDE_COMPÉTENCE_SALARIALE ON POSSÈDE (COMPÉTENCE_SALARIÉ ASC);

# -----------------------------------------------------------------------------
#       TABLE : MATÉRIEL
# -----------------------------------------------------------------------------
CREATE TABLE  MATÉRIEL
 (
   LIBELLÉ_T VARCHAR (30) NOT NULL  ,
   NOM_S VARCHAR (30) NOT NULL  ,
   NOM VARCHAR (30) NULL  ,
   TYPE VARCHAR (30) NULL  
   , PRIMARY KEY (LIBELLÉ_T,NOM_S) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE MATÉRIEL
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_MATÉRIEL_TÂCHES ON MATÉRIEL (LIBELLÉ_T ASC);
CREATE INDEX I_FK_MATÉRIEL_SALARIÉ ON MATÉRIEL (NOM_S ASC);

# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------

ALTER TABLE SALARIÉ 
  ADD FOREIGN KEY FK_SALARIÉ_PROJET (LIBELLÉ_P) REFERENCES PROJET (LIBELLÉ_P) ;

ALTER TABLE SALARIÉ 
  ADD FOREIGN KEY FK_SALARIÉ_SALARIÉ (NOM_S_CHEF_DE_PROJET) REFERENCES SALARIÉ (NOM_S) ;

ALTER TABLE PROJET 
  ADD FOREIGN KEY FK_PROJET_CLIENT (NOM) REFERENCES CLIENT (NOM) ;

ALTER TABLE POSSÈDE 
  ADD FOREIGN KEY FK_POSSÈDE_SALARIÉ (NOM_S) REFERENCES SALARIÉ (NOM_S) ;

ALTER TABLE POSSÈDE 
  ADD FOREIGN KEY FK_POSSÈDE_COMPÉTENCE_SALARIALE (COMPÉTENCE_SALARIÉ) REFERENCES COMPÉTENCE_SALARIALE (COMPÉTENCE_SALARIÉ) ;

ALTER TABLE MATÉRIEL 
  ADD FOREIGN KEY FK_MATÉRIEL_TÂCHES (LIBELLÉ_T) REFERENCES TÂCHES (LIBELLÉ_T) ;

ALTER TABLE MATÉRIEL 
  ADD FOREIGN KEY FK_MATÉRIEL_SALARIÉ (NOM_S) REFERENCES SALARIÉ (NOM_S) ;

