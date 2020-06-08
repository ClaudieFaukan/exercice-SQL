
UPDATE `annonce`.`annonce` 
	SET
	`ID_ANNONCE` = 'ID_ANNONCE' , 
	`ID_USER` = 'ID_USER' , 
	`ID_RUBRIQUE` = 'ID_RUBRIQUE' , 
	`EN_TETE` = 'EN_TETE' , 
	`CORP` = 'CORP' , 
	`DATE_VALIDITE` = 'DATE_VALIDITE' , 
	`DATE_DEPOT` = 'DATE_DEPOT'
	
	WHERE
	`ID_ANNONCE` = 'ID_ANNONCE' ;

INSERT INTO `annonce`.`annonce` 
	(`ID_ANNONCE`, 
	`ID_USER`, 
	`ID_RUBRIQUE`, 
	`EN_TETE`, 
	`CORP`, 
	`DATE_VALIDITE`, 
	`DATE_DEPOT`
	)
	VALUES
	('ID_ANNONCE', 
	'ID_USER', 
	'ID_RUBRIQUE', 
	'EN_TETE', 
	'CORP', 
	'DATE_VALIDITE', 
	'DATE_DEPOT'
	);
