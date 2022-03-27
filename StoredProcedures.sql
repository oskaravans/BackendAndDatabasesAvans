

DROP FUNCTION IF EXISTS `retrieveHashedPasswordByEmail`;
DROP FUNCTION IF EXISTS `retrieveAccountIDByEmail`;
DROP PROCEDURE IF EXISTS `verwijderAccount`;
DROP PROCEDURE IF EXISTS `plaatsAdvertentie`;
DROP PROCEDURE IF EXISTS `wijzigBedrijfsProfiel`;
DROP PROCEDURE IF EXISTS `VulBeoordelingIn`;
DROP PROCEDURE IF EXISTS `BekijkAdvertenties`;
DROP PROCEDURE IF EXISTS `wijzigSpecialistProfiel`;
DROP PROCEDURE IF EXISTS `wijzigAlgemeenProfiel`;



DELIMITER //
CREATE FUNCTION retrieveHashedPasswordByEmail(`EmailInput`VARCHAR(35))
RETURNS VARCHAR(35)
BEGIN
RETURN (SELECT `Wachtwoord` FROM `accounts` WHERE `EmailInput` = `Email`);
END //

DELIMITER //
CREATE FUNCTION retrieveAccountIDByEmail(`EmailInput` VARCHAR(35))
RETURNS INT(11)
BEGIN
RETURN (SELECT `AccountID` FROM `accounts` WHERE `EmailInput` = `Email`);
END //

DELIMITER //
CREATE PROCEDURE verwijderAccount
(IN `EmailInput` VARCHAR(35), IN `WachtwoordInput` VARCHAR(35))
BEGIN
DELETE FROM `accounts` WHERE `EmailInput` = `Email` AND `WachtwoordInput` = `Wachtwoord`;
END //

DELIMITER //
CREATE PROCEDURE plaatsAdvertentie
(IN `CreatorIDIN` INT(11), IN `AdvertentieTitelIN` VARCHAR(35), IN `InhoudIn` TEXT, IN `OpleverDatumIN` DATE, IN `BedragIN` INT(11), IN `ValutaIN` VARCHAR(3), OUT `AdvertentieID` INT(11))
BEGIN
INSERT INTO `advertenties` (`CreatorID`, `AdvertentieTitel`, `Inhoud`, `Opleverdatum`, `Bedrag`, `Valuta`)
VALUES
(`CreatorIDIN`, `AdvertentieTitelIN`, `InhoudIn`, `OpleverDatumIN`, `BedragIN`, `ValutaIN`);
SET `AdvertentieID` = LAST_INSERT_ID();
END //

DELIMITER //
CREATE PROCEDURE wijzigBedrijfsProfiel
(IN `bedrijfsnaamIN` VARCHAR(35), IN `rolrecruitmentIN` VARCHAR(35), IN `aantalmdwIN` INT(10), IN `accountInfoIN` VARCHAR(35), IN `BedrijfslogoUrlIN` VARCHAR(255), IN `BedrijfsomschrijvingIN` TEXT, IN `AccountIDIN` INT(11))
BEGIN
UPDATE `aanbieders`
SET `bedrijfsnaam` = `bedrijfsnaamIN`, `rolrecruitment` = `rolrecruitmentIN`, `aantalmdw` = `aantalmdwIN`, `accountInfo` = `accountInfoIN`, `BedrijfslogoUrl` = `BedrijfslogoUrlIN`, `Bedrijfsomschrijving` = `BedrijfsomschrijvingIN`
WHERE
`Account_AccountID` = `AccountIDIN`;
END //

DELIMITER //
CREATE PROCEDURE VulBeoordelingIn
(IN `SpecialistAccountIDIN` INT(11), IN `AanbiederAccountIDIN` INT(11), IN `inhoudIN` TEXT, IN `richtingIN` VARCHAR(3), IN `cijferIN` INT(2), OUT `BeoordelingID` INT(11))
BEGIN
INSERT INTO `beoordelingen` (`Specialist_AccountID`, `Aanbieder_AccountID`, `inhoud`, `richting`, `cijfer`)
VALUES (`Specialist_AccountIDIN`, `AanbiederAccountIDIN`, `inhoudIN`, `richtingIN`, `cijferIN`);
SET `BeoordelingID` = LAST_INSERT_ID();
END //

DELIMITER //
CREATE PROCEDURE BekijkAdvertenties
(IN `limit` INT(11), IN `offset` INT(11))
BEGIN
SELECT `AdvertentieID`, `CreatorID`, `AdvertentieTitel`, `Inhoud` from `advertenties` ORDER BY `AdvertentieID` LIMIT `limit` OFFSET `offset`;
END //

DELIMITER //
CREATE PROCEDURE wijzigSpecialistProfiel
(IN `ExpertiseIN` VARCHAR(255), IN `WerkervaringIN` TEXT, IN `OpleidingenIN` TEXT, IN `TalenIN` TEXT, IN `VaardighedenIN` TEXT, IN `BiografieIN` TEXT, IN `ProfielfotoUrlIN` VARCHAR(255), `AccountIDIN` INT(11))
BEGIN
UPDATE `specialisten`
SET `Expertise` = `ExpertiseIN`, `Werkervaring` = `WerkervaringIN`, `Opleidingen` = `OpleidingenIN`, `Talen` = `TalenIN`, `Vaardigheden` = `VaardighedenIN`, `Biografie` = `BiografieIN`, `ProfielfotoUrl` = `ProfielfotoUrlIN`
WHERE `Account_AccountID` = `AccountIDIN`;
END //

DELIMITER //
CREATE PROCEDURE wijzigAlgemeenProfiel
(IN `AccountIDIN` INT(11), IN `EmailIN` VARCHAR(35), IN `WachtwoordIN` VARCHAR(35), IN `VoornaamIN` VARCHAR(35), IN `AchternaamIN` VARCHAR(35), IN `StraatnaamIN` VARCHAR(35), IN `PostcodeIN` VARCHAR(6), IN `HuisnummerIN` INT(6), IN `ToevoegingIN` VARCHAR(10), IN `TelefoonnummerIN` VARCHAR(20), IN `NieuwsbriefIN` BOOLEAN)
BEGIN
UPDATE `accounts`
SET `Email` = `EmailIN`, `Wachtwoord` = `WachtwoordIN`, `Voonaam` = `VoornaamIN`, `Achternaam` = `AchternaamIN`, `Straatnaam` = `StraatnaamIN`, `Postcode` = `PostcodeIN`, `Huisnummer` = `HuisnummerIN`, `Toevoeging` = `ToevoegingIN`, `Telefoonnummer` = `TelefoonnummerIN`, `Nieuwsbrief` = `NieuwsbriefIN`
WHERE
`AccountID` = `AccountIDIN`;
END //