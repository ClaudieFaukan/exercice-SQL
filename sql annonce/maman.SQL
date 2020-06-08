DROP DATABASE IF EXISTS MLR6;

CREATE DATABASE IF NOT EXISTS MLR6;
ALTER DATABASE MLR6 CHARACTER SET utf8 COLLATE utf8_general_ci;
USE MLR6;

# -----------------------------------------------------------------------------
#       TABLE : MATERIEL
# -----------------------------------------------------------------------------
CREATE TABLE  MATERIEL
 (
   ID_MATERIEL INTEGER NOT NULL  ,
   NOM VARCHAR (30) NOT NULL  ,
   TYPE VARCHAR (30) NOT NULL  
   , PRIMARY KEY (ID_MATERIEL) 
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
   LIBELLE_P VARCHAR (30) NOT NULL  ,
   NOM VARCHAR (30) NOT NULL  ,
   DATE_DEBUT DATE NOT NULL  ,
   DATE_FIN DATE NULL  ,
   DURÉE_PREVU DATE NOT NULL  
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
   LIBELLE_T VARCHAR (30) NOT NULL  ,
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
CREATE INDEX I_FK_SALARIE_TACHES ON SALARIE (LIBELLE_T ASC);

# -----------------------------------------------------------------------------
#       TABLE : COMPÉTENCE_SALARIALE
# -----------------------------------------------------------------------------
CREATE TABLE  COMPÉTENCE_SALARIALE
 (
   COMPETENCE_SALARIE VARCHAR (30) NOT NULL  ,
   NIVEAU_QUALIFICATION INTEGER NOT NULL  ,
   ORDRE_GRANDEUR INTEGER NOT NULL  ,
   ANNÉE_COMPETENCE_DEBUT DATE NOT NULL  
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
#       TABLE : UTILISE
# -----------------------------------------------------------------------------
CREATE TABLE  UTILISE
 (
   ID_MATERIEL INTEGER NOT NULL  ,
   NOM_S VARCHAR (30) NOT NULL  
   , PRIMARY KEY (ID_MATERIEL,NOM_S) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE UTILISE
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_UTILISE_MATERIEL ON UTILISE (ID_MATERIEL ASC);
CREATE INDEX I_FK_UTILISE_SALARIE ON UTILISE (NOM_S ASC);

# -----------------------------------------------------------------------------
#       TABLE : DIVISE
# -----------------------------------------------------------------------------
CREATE TABLE  DIVISE
 (
   LIBELLE_P VARCHAR (30) NOT NULL  ,
   LIBELLE_T VARCHAR (30) NOT NULL  
   , PRIMARY KEY (LIBELLE_P,LIBELLE_T) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE DIVISE
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_DIVISE_PROJET ON DIVISE (LIBELLE_P ASC);
CREATE INDEX I_FK_DIVISE_TACHES ON DIVISE (LIBELLE_T ASC);

# -----------------------------------------------------------------------------
#       TABLE : COMPOSE
# -----------------------------------------------------------------------------
CREATE TABLE  COMPOSE
 (
   ID_MATERIEL_COMPOSE INTEGER NOT NULL  ,
   ID_MATERIEL_EST_COMPOSE_DE INTEGER NOT NULL  
   , PRIMARY KEY (ID_MATERIEL_COMPOSE,ID_MATERIEL_EST_COMPOSE_DE) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE COMPOSE
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_COMPOSE_MATERIEL ON COMPOSE (ID_MATERIEL_COMPOSE ASC);
CREATE INDEX I_FK_COMPOSE_MATERIEL_2 ON COMPOSE (ID_MATERIEL_EST_COMPOSE_DE ASC);

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
CREATE INDEX I_FK_POSSEDE_COMPÉTENCE_SALARIALE ON POSSEDE (COMPETENCE_SALARIE ASC);

# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------

ALTER TABLE PROJET 
  ADD FOREIGN KEY FK_PROJET_CLIENT (NOM) REFERENCES CLIENT (NOM) ;

ALTER TABLE SALARIE 
  ADD FOREIGN KEY FK_SALARIE_PROJET (LIBELLE_P) REFERENCES PROJET (LIBELLE_P) ;

ALTER TABLE SALARIE 
  ADD FOREIGN KEY FK_SALARIE_SALARIE (NOM_S_CHEF_DE_PROJET) REFERENCES SALARIE (NOM_S) ;

ALTER TABLE SALARIE 
  ADD FOREIGN KEY FK_SALARIE_TACHES (LIBELLE_T) REFERENCES TACHES (LIBELLE_T) ;

ALTER TABLE UTILISE 
  ADD FOREIGN KEY FK_UTILISE_MATERIEL (ID_MATERIEL) REFERENCES MATERIEL (ID_MATERIEL) ;

ALTER TABLE UTILISE 
  ADD FOREIGN KEY FK_UTILISE_SALARIE (NOM_S) REFERENCES SALARIE (NOM_S) ;

ALTER TABLE DIVISE 
  ADD FOREIGN KEY FK_DIVISE_PROJET (LIBELLE_P) REFERENCES PROJET (LIBELLE_P) ;

ALTER TABLE DIVISE 
  ADD FOREIGN KEY FK_DIVISE_TACHES (LIBELLE_T) REFERENCES TACHES (LIBELLE_T) ;

ALTER TABLE COMPOSE 
  ADD FOREIGN KEY FK_COMPOSE_MATERIEL (ID_MATERIEL_COMPOSE) REFERENCES MATERIEL (ID_MATERIEL) ;

ALTER TABLE COMPOSE 
  ADD FOREIGN KEY FK_COMPOSE_MATERIEL_2 (ID_MATERIEL_EST_COMPOSE_DE) REFERENCES MATERIEL (ID_MATERIEL) ;

ALTER TABLE POSSEDE 
  ADD FOREIGN KEY FK_POSSEDE_SALARIE (NOM_S) REFERENCES SALARIE (NOM_S) ;

ALTER TABLE POSSEDE 
  ADD FOREIGN KEY FK_POSSEDE_COMPÉTENCE_SALARIALE (COMPETENCE_SALARIE) REFERENCES COMPÉTENCE_SALARIALE (COMPETENCE_SALARIE) ;

