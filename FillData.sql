INSERT INTO `accounts` (`Email`, `Wachtwoord`, `Sekse`, `Voornaam`, `Achternaam`, `Straatnaam`, `Postcode`, `Huisnummer`, `Toevoeging`, `Telefoon`, `Nieuwsbrief`, `Accounttype`)
VALUES ('oskar@oskar.oskar', 'nasjweark34t', 'm', 'Oskar', 'Kohler', 'Daniel Catterwijckstraat', '2282HK', 134, NULL, 0612345678, false, 'Specialist');

INSERT INTO `accounts` (`Email`, `Wachtwoord`, `Sekse`, `Voornaam`, `Achternaam`, `Straatnaam`, `Postcode`, `Huisnummer`, `Toevoeging`, `Telefoon`, `Nieuwsbrief`, `Accounttype`)
VALUES ('thijs@thijs.thijs', 'dkafjerin4', 'm', 'Thijs', 'Lammerts', 'Thorbeckestraat', '5301NH', 66, NULL, 0687654321, true, 'Specialist');

INSERT INTO `accounts` (`Email`, `Wachtwoord`, `Sekse`, `Voornaam`, `Achternaam`, `Straatnaam`, `Postcode`, `Huisnummer`, `Toevoeging`, `Telefoon`, `Nieuwsbrief`, `Accounttype`)
VALUES ('omar@omar.omar', 'oeiwrmgn24', 'm', 'Omar', 'Omar', 'Lammenschansweg', '2313DR', 118, NULL, 0691827364, false, 'Aanbieder');

INSERT INTO `aanbieders` (`Account_AccountID`, `Bedrijfsnaam`, `Rolrecruitment`, `Aantalmdw`, `Accountinfo`, `BedrijfslogoUrl`, `Bedrijfsomschrijving`)
SELECT `AccountID`, 'BillionDollarIdea', 'Eigenaar', 5, 'Dit is een account van een bedrijf', 'http://www.google.com/images', 'Dit bedrijf specialiseerd zich in net doen of het echt bestaat' FROM `accounts`
WHERE `Email` = 'omar@omar.omar';

INSERT INTO `specialisten` (`Account_AccountID`, `Expertise`, `Werkervaring`, `Opleidingen`, `Talen`, `Vaardigheden`, `Biografie`, `ProfielfotoUrl`)
SELECT `AccountID`, 'Mx, BettyBlocks, Javascript, HTML', 'Business Engineer, Support Engineer', 'VWO', 'Nederlands, Engels', 'Mx, BettyBlocks, Javascript, HTML', NULL, 'www.google.com/images' FROM `accounts`
WHERE `Email` = 'oskar@oskar.oskar';

INSERT INTO `specialisten` (`Account_AccountID`, `Expertise`, `Werkervaring`, `Opleidingen`, `Talen`, `Vaardigheden`, `Biografie`, `ProfielfotoUrl`)
SELECT `AccountID`, 'Mx, Sales', 'Sales', 'MBO iets', 'Nederlands, Engels', 'Mx, Sales', NULL, 'www.google.com/images' FROM `accounts`
WHERE `Email` = 'thijs@thijs.thijs';

INSERT INTO `advertenties` (`CreatorID`, `Advertentietitel`, `Inhoud`, `Opleverdatum`, `Bedrag`, `Valuta`)
SELECT `AccountID`, 'Maak een miljard winst!', 'De bedoeling is dat je een stuk code upload naar ons waar we een miljard winst mee maken. Het maakt niet echt uit hoe of wat, maar een miljard winst is wel een harde eis.',
'2022-11-11', 1000000, 'EUR' FROM `accounts`
WHERE `Email` = 'omar@omar.omar';

INSERT INTO `reacties` (`Inhoud`, `CreatorID`)
SELECT 'Ik wil dit wel doen, je kan me bereiken onder het emailadres van mijn account', `AccountID` FROM `accounts`
WHERE `Email` = 'oskar@oskar.oskar';

INSERT INTO `reacties` (`Inhoud`, `CreatorID`, `Advertentie_AdvertentieID`)
SELECT 'Ik kan dit fixen, maar kost je wel 2 miljoen ipv 1', `ac`.`AccountID`, `ad`.`AdvertentieID` FROM `accounts` as `ac`, `advertenties` as `ad` 
WHERE `ac`.`Email` = 'thijs@thijs.thijs' AND `ad`.`Advertentietitel` = 'Maak een miljard winst!';

INSERT INTO `opdrachten` (`inhoud`, `Specialist_AccountID`, `Advertentie_AdvertentieID`)
SELECT 'De uiteindelijke opdracht is onveranderd. Gaarne opleveren op het emailadres op mijn account.', `ac`.`AccountID`, `ad`.`AdvertentieID` FROM `accounts` as `ac`, `advertenties` as `ad` 
WHERE `ac`.`Email` = 'oskar@oskar.oskar' AND `ad`.`Advertentietitel` = 'Maak een miljard winst!';

INSERT INTO `beoordelingen` (`inhoud`, `cijfer`, `richting`, `Aanbieder_AccountID`, `Specialist_AccountID`)
SELECT 'Deze opdrachtgever is mij te veeleisend', 4, 'StA', `AA`.`AccountID`, `AS`.`AccountID` FROM `accounts` as `AA`, `accounts` as `AS` WHERE 
`AA`.`Email` = 'omar@omar.omar' AND `AS`.`Email` = 'oskar@oskar.oskar';

INSERT INTO `beoordelingen` (`inhoud`, `cijfer`, `richting`, `Aanbieder_AccountID`, `Specialist_AccountID`)
SELECT
'Deze opdrachtgever is fantastisch, net een miljoen verdiend met een simpel recursief algoritme met Lorentz aantrekker', 8, 'StA',  `AA`.`AccountID`, `AS`.`AccountID` FROM `accounts` as `AA`, `accounts` as `AS` WHERE 
`AA`.`Email` = 'omar@omar.omar' AND `AS`.`Email` = 'thijs@thijs.thijs';

INSERT INTO `beoordelingen` (`inhoud`, `cijfer`, `richting`, `Aanbieder_AccountID`, `Specialist_AccountID`)
SELECT
'Deze specialist weet wat hij doet en levert ruim op tijd', 9, 'AtS',  `AA`.`AccountID`, `AS`.`AccountID` FROM `accounts` as `AA`, `accounts` as `AS` WHERE 
`AA`.`Email` = 'omar@omar.omar' AND `AS`.`Email` = 'thijs@thijs.thijs';