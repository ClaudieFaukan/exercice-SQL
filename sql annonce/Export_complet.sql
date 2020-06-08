/*
SQLyog Community v12.16 (32 bit)
MySQL - 5.7.26 : Database - annonce
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`annonce` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `annonce`;

/*Table structure for table `annonce` */

DROP TABLE IF EXISTS `annonce`;

CREATE TABLE `annonce` (
  `ID_ANNONCE` int(4) NOT NULL AUTO_INCREMENT,
  `ID_USER` int(4) NOT NULL,
  `ID_RUBRIQUE` int(4) NOT NULL,
  `EN_TETE` varchar(80) NOT NULL,
  `CORP` text NOT NULL,
  `DATE_VALIDITE` date DEFAULT NULL,
  `DATE_DEPOT` date DEFAULT NULL,
  PRIMARY KEY (`ID_ANNONCE`),
  KEY `I_FK_ANNONCE_UTILISATEUR` (`ID_USER`),
  KEY `I_FK_ANNONCE_RUBRIQUE` (`ID_RUBRIQUE`),
  CONSTRAINT `annonce_ibfk_1` FOREIGN KEY (`ID_USER`) REFERENCES `utilisateur` (`ID_USER`),
  CONSTRAINT `annonce_ibfk_2` FOREIGN KEY (`ID_RUBRIQUE`) REFERENCES `rubrique` (`ID_RUBRIQUE`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `annonce` */

insert  into `annonce`(`ID_ANNONCE`,`ID_USER`,`ID_RUBRIQUE`,`EN_TETE`,`CORP`,`DATE_VALIDITE`,`DATE_DEPOT`) values 
(1,1,2,'maison proche mer','loresum ipipipsd loresum ipipipsd loresum ipipipsd loresum ipipipsdloresum ipipipsd',NULL,'2019-10-01'),
(2,1,6,'Chien malpropre','loresum ipipipsdloresum ipipipsdloresum ipipipsdloresum ipipipsdloresum ipipipsd',NULL,'2019-10-14'),
(3,2,3,'Opel Astra ','loresum ipipipsdloresum ipipipsdloresum ipipipsdloresum ipipipsdloresum ipipipsd',NULL,'2019-10-04'),
(4,3,4,'Pullover','loresum ipipipsdloresum ipipipsdloresum ipipipsd',NULL,'2019-10-10'),
(5,5,1,'MAcbook','loresum ipipipsdloresum ipipipsdloresum ipipipsd',NULL,'2019-09-20'),
(6,4,5,'Developpeur web','loresum ipipipsdloresum ipipipsdloresum ipipipsdloresum ipipipsd',NULL,'2019-10-09'),
(7,2,3,'test','jghfhdhyhds','2019-11-05','2019-10-15');

/*Table structure for table `image` */

DROP TABLE IF EXISTS `image`;

CREATE TABLE `image` (
  `ID_IMAGE` int(4) NOT NULL,
  `ID_ANNONCE` int(4) NOT NULL,
  `HREF` varchar(40) NOT NULL,
  PRIMARY KEY (`ID_IMAGE`),
  KEY `I_FK_IMAGE_ANNONCE` (`ID_ANNONCE`),
  CONSTRAINT `image_ibfk_1` FOREIGN KEY (`ID_ANNONCE`) REFERENCES `annonce` (`ID_ANNONCE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `image` */

/*Table structure for table `parametre` */

DROP TABLE IF EXISTS `parametre`;

CREATE TABLE `parametre` (
  `DUREE_ANNONCE` date NOT NULL,
  PRIMARY KEY (`DUREE_ANNONCE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `parametre` */

/*Table structure for table `rubrique` */

DROP TABLE IF EXISTS `rubrique`;

CREATE TABLE `rubrique` (
  `ID_RUBRIQUE` int(4) NOT NULL AUTO_INCREMENT,
  `LIBELLE` varchar(30) NOT NULL,
  PRIMARY KEY (`ID_RUBRIQUE`),
  UNIQUE KEY `ID_RUBRIQUE` (`ID_RUBRIQUE`),
  UNIQUE KEY `LIBELLE` (`LIBELLE`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `rubrique` */

insert  into `rubrique`(`ID_RUBRIQUE`,`LIBELLE`) values 
(6,'Animaux'),
(5,'Emploi'),
(2,'Immobilier'),
(1,'Informatique'),
(3,'Vehicule'),
(4,'Vetements');

/*Table structure for table `utilisateur` */

DROP TABLE IF EXISTS `utilisateur`;

CREATE TABLE `utilisateur` (
  `ID_USER` int(4) NOT NULL AUTO_INCREMENT,
  `MDP` varchar(224) NOT NULL,
  `NOM` varchar(30) NOT NULL,
  `PRENOM` varchar(30) NOT NULL,
  `MAIL` varchar(50) NOT NULL,
  `ADMIN` enum('non','oui') NOT NULL,
  PRIMARY KEY (`ID_USER`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Data for the table `utilisateur` */

insert  into `utilisateur`(`ID_USER`,`MDP`,`NOM`,`PRENOM`,`MAIL`,`ADMIN`) values 
(1,'1230','Petrel','Pierre','pierre@hotmail.fr','oui'),
(2,'1470','Baba','Orhum','clan@gmail.com','non'),
(3,'lololo','Gaston','lagaff','spray@outlook.fr','non'),
(4,'carotte','Chasseur','Jean','fusil46@gmail.com','non'),
(5,'azerty','Opel','Clara','caca@hotmail.fr','non'),
(11,'794293b5706d6f85da86d164393511bb834cd222812a2016e68bb54c','12','12','12','non');

/* Trigger structure for table `annonce` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `date.default` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `date.default` BEFORE INSERT ON `annonce` FOR EACH ROW BEGIN
IF (NEW.date_depot IS NULL) THEN
SET NEW.date_depot = NOW();
END IF;
IF (NEW.date_validite IS NULL) THEN
SET NEW.date_validite = ADDDATE(CURDATE(), INTERVAL 21 DAY);
END IF;
END */$$


DELIMITER ;

/* Trigger structure for table `utilisateur` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `crypt_sha2` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `crypt_sha2` BEFORE INSERT ON `utilisateur` FOR EACH ROW 
    SET new.mdp =sha2(new.mdp, 224) */$$


DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
