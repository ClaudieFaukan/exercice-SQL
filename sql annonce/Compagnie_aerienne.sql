CREATE DATABASE Compagnie_aerienne

set nocount		on
set dateformat	dmy

GO

use Compagnie_aerienne

GO

execute sp_addtype tNomPilote, 'varchar(20)', 'NOT NULL'
execute sp_addtype tAdresse, 'varchar(30)', 'NULL'
execute sp_addtype tIdent, 'int', 'NOT NULL'
execute sp_addtype tNumVol, 'char(5)', 'NOT NULL'

GO

CREATE TABLE AVION
(
	av#             tIdent			CONSTRAINT    CK_avion_id    PRIMARY KEY    CLUSTERED	IDENTITY(100, 1),
		
	Marque			varchar(15)		NOT NULL DEFAULT 'AIRBUS',
	
	Type			varchar(10)		NOT NULL CHECK(Type like '[A-Z]%') DEFAULT 'A340',
	
	Capacité		smallint		NOT NULL CHECK(Capacité between 50 and 400) DEFAULT 100,
	
	Localisation	tAdresse		NULL,
)

GO

CREATE TABLE PILOTE
(
	pil#			tIdent
	
		CONSTRAINT UPKCL_pilidind PRIMARY KEY CLUSTERED,
	
	Nom				tNomPilote			NOT NULL UNIQUE,
	
	Adresse			tAdresse			NULL,
)

GO

CREATE TABLE VOL
(
	vol#		tNumVol			CHECK (vol# like '[IT]%[0-9][0-9][0-9]')
		
		CONSTRAINT UPKCL_volidind PRIMARY KEY CLUSTERED,
	
	av			tIdent			NOT NULL
		
		REFERENCES	AVION(av#),
		
	pil			tIdent			NOT NULL
	
		REFERENCES	PILOTE(pil#),

		
	Ville_Départ	varchar(15)			NOT NULL,
	
	Ville_Arrivée	varchar(15)			NOT NULL,
	
	Heure_Départ	smallint			NOT NULL CHECK(Heure_Départ between 0 and 23),
	
	Heure_Arrivée	smallint			NOT NUll CHECK(Heure_Arrivée between 0 and 23),
)

GO

insert AVION
	values('AIRBUS', 'A320', '300', 'Nice')
insert AVION
	values('BOEING', 'B707', '250', 'Paris')
insert AVION
	values('AIRBUS', 'A320', '300', 'Toulouse')
insert AVION
	values('CARAVELLE', 'Caravelle', '200', 'Toulouse')
insert AVION
	values('BOEING', 'B747', '400', 'Paris')
insert AVION
	values('AIRBUS', 'A320', '300', 'Grneoble')
insert AVION
	values('ATR', 'ATR42', '50', 'Paris')
insert AVION
	values('BOEING', 'B727', '300', 'Lyon')
insert AVION
	values('BOEING', 'B727', '300', 'Nantes')
insert AVION
	values('AIRBUS', 'A340', '350', 'Bastia')

GO

insert PILOTE
	values('1', 'SERGE', 'Nice')
insert PILOTE
	values('2', 'JEAN', 'Paris')
insert PILOTE
	values('3', 'CLAUDE', 'Grenoble')
insert PILOTE
	values('4', 'ROBERT', 'Nantes')
insert PILOTE
	values('5', 'MICHEL', 'Paris')
insert PILOTE
	values('6', 'LUCIEN', 'Toulouse')
insert PILOTE
	values('7', 'BERTRAND', 'Lyon')
insert PILOTE
	values('8', 'HERVE', 'Bastia')
insert PILOTE
	values('9', 'LUC', 'Paris')
	
GO

insert VOL
	values('IT100', '100', '1', 'NICE', 'PARIS', '7', '9')
insert VOL
	values('IT101', '100', '2', 'PARIS', 'TOULOUSE', '11', '12')
insert VOL
	values('IT102', '101', '1', 'PARIS', 'NICE', '12', '14')
insert VOL
	values('IT103', '105', '3', 'GRENOBLE', 'TOULOUSE', '9', '11')
insert VOL
	values('IT104', '105', '3', 'TOULOUSE', 'GRENOBLE', '17', '19')
insert VOL
	values('IT105', '107', '7', 'LYON', 'PARIS', '6', '7')
insert VOL
	values('IT106', '109', '8', 'BASTIA', 'PARIS', '10', '13')
insert VOL
	values('IT107', '106', '9', 'PARIS', 'BRIVE', '7', '8')
insert VOL
	values('IT108', '106', '9', 'BRIVE', 'PARIS', '19', '20')
insert VOL
	values('IT109', '107', '7', 'PARIS', 'LYON', '18', '19')
insert VOL
	values('IT110', '102', '2', 'TOULOUSE', 'PARIS', '15', '16')
insert VOL
	values('IT111', '101', '4', 'NICE', 'NANTES', '17', '19')

GO

--Si on veut tout détruire : 
/*
DROP TABLE VOL

GO

DROP TABLE PILOTE

GO

DROP TABLE AVION

GO

execute sp_droptype tNomPilote
execute sp_droptype tAdresse
execute sp_droptype tIdent
execute sp_droptype tNumVol

GO*/