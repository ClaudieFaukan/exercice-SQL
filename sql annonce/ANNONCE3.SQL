DROP DATABASE IF EXISTS Annonce;

CREATE DATABASE IF NOT EXISTS Annonce;
ALTER DATABASE Annonce CHARACTER SET utf8 COLLATE utf8_general_ci;
USE Annonce;

# -----------------------------------------------------------------------------
#       TABLE : IMAGE
# -----------------------------------------------------------------------------
CREATE TABLE  IMAGE
 (
   ID_IMAGE VARCHAR (30) NOT NULL  ,
   ID_ANNONCE VARCHAR (30) NOT NULL  ,
   HREF VARCHAR (40) NOT NULL  
   , PRIMARY KEY (ID_IMAGE) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE IMAGE
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_IMAGE_ANNONCE ON IMAGE (ID_ANNONCE ASC);

# -----------------------------------------------------------------------------
#       TABLE : UTILISATEUR
# -----------------------------------------------------------------------------
CREATE TABLE  UTILISATEUR
 (
   ID_USER VARCHAR (30) NOT NULL  ,
   MDP VARCHAR (30) NOT NULL  ,
   NOM VARCHAR (30) NOT NULL  ,
   PRENOM VARCHAR (30) NOT NULL  ,
   MAIL VARCHAR (50) NOT NULL  ,
   ADMIN TINYINT NOT NULL  
   , PRIMARY KEY (ID_USER) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# -----------------------------------------------------------------------------
#       TABLE : RUBRIQUE
# -----------------------------------------------------------------------------
CREATE TABLE  RUBRIQUE
 (
   ID_RUBRIQUE VARCHAR (30) NOT NULL  ,
   LIBELLE VARCHAR (30) NOT NULL  
   , PRIMARY KEY (ID_RUBRIQUE) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# -----------------------------------------------------------------------------
#       TABLE : ANNONCE
# -----------------------------------------------------------------------------
CREATE TABLE  ANNONCE
 (
   ID_ANNONCE VARCHAR (30) NOT NULL  ,
   ID_USER VARCHAR (30) NOT NULL  ,
   ID_RUBRIQUE VARCHAR (30) NOT NULL  ,
   EN_TETE VARCHAR (80) NOT NULL  ,
   CORP TEXT NOT NULL  ,
   DATE_VALIDITE DATE NULL  ,
   DATE_DEPOT DATE NOT NULL  
   , PRIMARY KEY (ID_ANNONCE) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
# -----------------------------------------------------------------------------
#       INDEX DE LA TABLE ANNONCE
# -----------------------------------------------------------------------------
CREATE INDEX I_FK_ANNONCE_UTILISATEUR ON ANNONCE (ID_USER ASC);
CREATE INDEX I_FK_ANNONCE_RUBRIQUE ON ANNONCE (ID_RUBRIQUE ASC);

# -----------------------------------------------------------------------------
#       TABLE : PARAMETRE
# -----------------------------------------------------------------------------
CREATE TABLE  PARAMETRE
 (
   DUREE_ANNONCE DATE NOT NULL  
   , PRIMARY KEY (DUREE_ANNONCE) 
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

# -----------------------------------------------------------------------------
#       CREATION DES REFERENCES DE TABLE
# -----------------------------------------------------------------------------

ALTER TABLE IMAGE 
  ADD FOREIGN KEY FK_IMAGE_ANNONCE (ID_ANNONCE) REFERENCES ANNONCE (ID_ANNONCE) ;

ALTER TABLE ANNONCE 
  ADD FOREIGN KEY FK_ANNONCE_UTILISATEUR (ID_USER) REFERENCES UTILISATEUR (ID_USER) ;

ALTER TABLE ANNONCE 
  ADD FOREIGN KEY FK_ANNONCE_RUBRIQUE (ID_RUBRIQUE) REFERENCES RUBRIQUE (ID_RUBRIQUE) ;

