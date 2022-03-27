DROP TABLE IF EXISTS `opdrachten`;
DROP TABLE IF EXISTS `beoordelingen`;
DROP TABLE IF EXISTS `reacties`;
DROP TABLE IF EXISTS `advertenties`;
DROP TABLE IF EXISTS `specialisten`;
DROP TABLE IF EXISTS `aanbieders`;
DROP TABLE IF EXISTS `accounts`;

CREATE TABLE `accounts` (
`AccountID` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
`Email` VARCHAR(35),
`Wachtwoord` VARCHAR(35),
`Sekse` VARCHAR(1),
`Voornaam` VARCHAR(35),
`Achternaam` VARCHAR(35),
`Straatnaam` VARCHAR(35),
`Postcode` VARCHAR(6),
`Huisnummer` INT(8),
`Toevoeging` VARCHAR(10),
`Telefoon` VARCHAR(20),
`Nieuwsbrief` BOOLEAN,
`Accounttype` VARCHAR(20)
);

CREATE TABLE `aanbieders` (
`Account_AccountID` INT(11),
`Bedrijfsnaam` VARCHAR(35),
`Rolrecruitment` VARCHAR(35),
`Adres` VARCHAR(50),
`Aantalmdw` INT(10),
`Accountinfo` VARCHAR(35),
`BedrijfslogoUrl` VARCHAR(255),
`Bedrijfsomschrijving` TEXT,
`Branche` VARCHAR(35),
	CONSTRAINT `AccountConstraintAanbieder` 
	FOREIGN KEY `AccountFKAanbieder` (`Account_AccountID`)
	REFERENCES `accounts` (`AccountID`)
	);

CREATE TABLE `specialisten` (
`Account_AccountID` INT(11),
`Expertise` VARCHAR(255),
`Werkervaring` TEXT,
`Opleidingen` TEXT,
`Talen` TEXT,
`Vaardigheden` TEXT,
`Biografie` TEXT,
`Branche` VARCHAR(35),
`ProfielfotoUrl` VARCHAR(255),
	CONSTRAINT `AccountConstraintSpecialist` 
	FOREIGN KEY `AccountFKSpecialist` (`Account_AccountID`)
	REFERENCES `accounts` (`AccountID`)
	);


CREATE TABLE `advertenties` (
`AdvertentieID` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
`CreatorID` INT(11),
`Advertentietitel` VARCHAR(35),
`Inhoud` TEXT,
`Opleverdatum` DATE,
`Bedrag` INT(11),
`Valuta` VARCHAR(3),
	CONSTRAINT `AanbiederConstraintAdvertentie`
	FOREIGN KEY `AanbiederFKAdvertentie` (`CreatorID`)
	REFERENCES `accounts` (`AccountID`)
);


CREATE TABLE `reacties` (
`ReactieID` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
`Inhoud` TEXT,
`CreatorID` INT(11),
`Advertentie_AdvertentieID` INT(11),
	CONSTRAINT `SpecialistConstraintReactie`
	FOREIGN KEY `SpecialistFKReactie` (`CreatorID`)
	REFERENCES `accounts` (`AccountID`),
	CONSTRAINT `AdvertentieConstraintReactie`
	FOREIGN KEY `AdvertentieFKReactie` (`Advertentie_AdvertentieID`)
	REFERENCES `advertenties` (`AdvertentieID`)
);


CREATE TABLE `opdrachten` (
`inhoud` TEXT,
`Specialist_AccountID` INT(11),
`Advertentie_AdvertentieID` INT(11),
	CONSTRAINT `SpecialistConstraintOpdracht`
	FOREIGN KEY `SpecialistFKOpdracht` (`Specialist_AccountID`)
	REFERENCES `accounts` (`AccountID`),
	CONSTRAINT `AdvertentieConstraintOpdracht`
	FOREIGN KEY `AdvertentieFKOpdracht` (`Advertentie_AdvertentieID`)
	REFERENCES `advertenties` (`AdvertentieID`)
);

CREATE TABLE `beoordelingen` (
`BeoordelingID` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
`inhoud` TEXT,
`cijfer` INT(2),
`richting` VARCHAR(3),
`Aanbieder_AccountID` INT(11),
`Specialist_AccountID` INT(11),
CONSTRAINT `SpecialistConstraintBeoordeling`
FOREIGN KEY `SpecialistFKBeoordeling` (`Specialist_AccountID`)
REFERENCES `accounts` (`AccountID`),
CONSTRAINT `AanbiederConstraintBeoordeling`
FOREIGN KEY `AanbiederFKBeoordeling` (`Aanbieder_AccountID`)
REFERENCES `accounts` (`AccountID`)
);