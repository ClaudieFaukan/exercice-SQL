DROP DATABASE IF EXISTS projets;

CREATE DATABASE IF NOT EXISTS projets;
ALTER DATABASE projets CHARACTER SET utf8 COLLATE utf8_general_ci;
USE projets;

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
   LIBELLE_P VARCHAR (30) NOT NULL  ,
   NOM VARCHAR (30) NOT NULL  ,
   DATE_DEBUT DATE NOT NULL  ,
   DATE_FIN DATE NULL  ,
   DUR�E_PREVU DATE NOT NULL  
   , PRIMARY KEY (LIBELLE_P) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE PROJET
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_PROJET_CLIENT ON PROJET (NOM ASC);

# -----------------------------------------------------------------------------
#       TABLE : SALARIE
# -----------------------------------------------------------------------------
CREATE TABLE  SALARIE
 (
   NOM_S VARCHAR (30) NOT NULL  ,
   LIBELLE_P VARCHAR (30) NOT NULL  ,
   NOM_S_CHEF_DE_PROJET VARCHAR (30) NULL  ,
   PRENOM VARCHAR (30) NOT NULL  ,
   EMPLOI VARCHAR (30) NOT NULL  ,
   ANCIENNETE DATE NULL  
   , PRIMARY KEY (NOM_S) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE SALARIE
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_SALARIE_PROJET ON SALARIE (LIBELLE_P ASC);
CREATE INDEX I_FK_SALARIE_SALARIE ON SALARIE (NOM_S_CHEF_DE_PROJET ASC);

# -----------------------------------------------------------------------------
#       TABLE : COMP�TENCE_SALARIALE
# -----------------------------------------------------------------------------
CREATE TABLE  COMP�TENCE_SALARIALE
 (
   COMPETENCE_SALARIE VARCHAR (30) NOT NULL  ,
   NIVEAU_QUALIFICATION INTEGER NOT NULL  ,
   ORDRE_GRANDEUR INTEGER NOT NULL  ,
   ANN�E_COMPETENCE_DEBUT DATE NOT NULL  
   , PRIMARY KEY (COMPETENCE_SALARIE) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# -----------------------------------------------------------------------------
#       TABLE : TACHES
# -----------------------------------------------------------------------------
CREATE TABLE  TACHES
 (
   LIBELLE_T VARCHAR (30) NOT NULL  ,
   DUREE DATE NOT NULL  ,
   COUT DECIMAL (13,2) NOT NULL  ,
   DATE_DEBUT DATE NOT NULL  ,
   DATE_FIN DATE NOT NULL  
   , PRIMARY KEY (LIBELLE_T) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# -----------------------------------------------------------------------------
#       TABLE : MAT�RIEL
# -----------------------------------------------------------------------------
CREATE TABLE  MAT�RIEL
 (
   LIBELLE_T VARCHAR (30) NOT NULL  ,
   NOM_S VARCHAR (30) NOT NULL  ,
   NOM VARCHAR (30) NULL  ,
   TYPE VARCHAR (30) NULL  
   , PRIMARY KEY (LIBELLE_T,NOM_S) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE MAT�RIEL
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_MAT�RIEL_TACHES ON MAT�RIEL (LIBELLE_T ASC);
CREATE INDEX I_FK_MAT�RIEL_SALARIE ON MAT�RIEL (NOM_S ASC);

# -----------------------------------------------------------------------------
#       TABLE : POSSEDE
# -----------------------------------------------------------------------------
CREATE TABLE  POSSEDE
 (
   NOM_S VARCHAR (30) NOT NULL  ,
   COMPETENCE_SALARIE VARCHAR (30) NOT NULL  
   , PRIMARY KEY (NOM_S,COMPETENCE_SALARIE) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE POSSEDE
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_POSSEDE_SALARIE ON POSSEDE (NOM_S ASC);
CREATE INDEX I_FK_POSSEDE_COMP�TENCE_SALARIALE ON POSSEDE (COMPETENCE_SALARIE ASC);

# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------

ALTER TABLE PROJET 
  ADD FOREIGN KEY FK_PROJET_CLIENT (NOM) REFERENCES CLIENT (NOM) ;

ALTER TABLE SALARIE 
  ADD FOREIGN KEY FK_SALARIE_PROJET (LIBELLE_P) REFERENCES PROJET (LIBELLE_P) ;

ALTER TABLE SALARIE 
  ADD FOREIGN KEY FK_SALARIE_SALARIE (NOM_S_CHEF_DE_PROJET) REFERENCES SALARIE (NOM_S) ;

ALTER TABLE MAT�RIEL 
  ADD FOREIGN KEY FK_MAT�RIEL_TACHES (LIBELLE_T) REFERENCES TACHES (LIBELLE_T) ;

ALTER TABLE MAT�RIEL 
  ADD FOREIGN KEY FK_MAT�RIEL_SALARIE (NOM_S) REFERENCES SALARIE (NOM_S) ;

ALTER TABLE POSSEDE 
  ADD FOREIGN KEY FK_POSSEDE_SALARIE (NOM_S) REFERENCES SALARIE (NOM_S) ;

ALTER TABLE POSSEDE 
  ADD FOREIGN KEY FK_POSSEDE_COMP�TENCE_SALARIALE (COMPETENCE_SALARIE) REFERENCES COMP�TENCE_SALARIALE (COMPETENCE_SALARIE) ;

