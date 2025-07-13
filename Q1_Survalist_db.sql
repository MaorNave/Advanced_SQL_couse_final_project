-- Q1
-- 1) Drop & recreate the database
DROP DATABASE IF EXISTS alone_survivalists;
CREATE DATABASE alone_survivalists
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE alone_survivalists;

-- 2) season_data: one row per (version_code, season_number)
CREATE TABLE season_data (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  version_code    VARCHAR(20) NOT NULL,
  season_number   INT        NOT NULL,
  UNIQUE KEY ux_version_season (version_code, season_number)
);

-- 3) survivalist_data: static personal info
CREATE TABLE survivalist_data (
  id         VARCHAR(20) PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name  VARCHAR(100) NOT NULL
);

-- 4) survivor_season_data: link table carrying demographics per season
CREATE TABLE survivor_season_data (
  survivalist_id   VARCHAR(20) NOT NULL,
  season_data_id   INT         NOT NULL,
  age              INT,
  gender           ENUM('Male','Female','Other') DEFAULT 'Other',
  city             VARCHAR(100),
  state            VARCHAR(100),
  country          VARCHAR(100),
  profession       VARCHAR(100),

  PRIMARY KEY (survivalist_id, season_data_id),
  FOREIGN KEY (survivalist_id)
    REFERENCES survivalist_data(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (season_data_id)
    REFERENCES season_data(id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

-- 5) appearance_data: one row per survivalist+season carrying game results
CREATE TABLE appearance_data (
  survivalist_id   VARCHAR(20) NOT NULL,
  season_data_id   INT         NOT NULL,
  result           INT,
  days_lasted      INT,
  medically_evacuated BOOLEAN,
  reason_tapped_out   TEXT,
  reason_category     VARCHAR(100),
  episode_tapped      INT,
  team               VARCHAR(100),
  day_linked_up      INT,

  PRIMARY KEY (survivalist_id, season_data_id),
  FOREIGN KEY (survivalist_id, season_data_id)
    REFERENCES survivor_season_data(survivalist_id, season_data_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);
-- 6) insert data to season_data table
INSERT INTO season_data (id, version_code, season_number) VALUES (1, 'AU', 1);
INSERT INTO season_data (id, version_code, season_number) VALUES (2, 'AU', 2);
INSERT INTO season_data (id, version_code, season_number) VALUES (3, 'US', 1);
INSERT INTO season_data (id, version_code, season_number) VALUES (4, 'US', 2);
INSERT INTO season_data (id, version_code, season_number) VALUES (5, 'US', 3);
INSERT INTO season_data (id, version_code, season_number) VALUES (6, 'US', 4);
INSERT INTO season_data (id, version_code, season_number) VALUES (7, 'US', 5);
INSERT INTO season_data (id, version_code, season_number) VALUES (8, 'US', 6);
INSERT INTO season_data (id, version_code, season_number) VALUES (9, 'US', 7);
INSERT INTO season_data (id, version_code, season_number) VALUES (10, 'US', 8);
INSERT INTO season_data (id, version_code, season_number) VALUES (11, 'US', 9);
INSERT INTO season_data (id, version_code, season_number) VALUES (12, 'US', 10);
INSERT INTO season_data (id, version_code, season_number) VALUES (13, 'US Frozen', 1);
INSERT INTO season_data (id, version_code, season_number) VALUES (14, 'US', 11);
-- 7) insert data to survivalist_data table
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU004', 'Gina', 'Chick');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU008', 'Mike', 'Atkinson');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU007', 'Michael', 'Wallace');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU006', 'Kate', 'Grarock');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU002', 'Chris', 'Bakon');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU003', 'Duane', 'Byrnes');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU009', 'Peter', 'Athanassiou');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU005', 'Jimmy', 'Lassaline');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU001', 'Beck', 'Henog');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU010', 'Rob', 'Kelly');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU016', 'Krzysztof', '');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU015', 'Suzan', '');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU014', 'Andreas', '');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU012', 'Tamika', '');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU017', 'Rick', '');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU018', 'Jack', '');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU020', 'Chace', '');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU011', 'Jason', '');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU013', 'Leanne', '');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('AU019', 'Mike', '');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US010', 'Alan', 'Kay');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US009', 'Sam', 'Larson');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US008', 'Mitch', 'Mitchell');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US007', 'Lucas', 'Miller');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US006', 'Dustin', 'Feher');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US005', 'Brant', 'McGee');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US004', 'Wayne', 'Russell');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US003', 'Joe', 'Robinet');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US002', 'Chris', 'Weatherman');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US001', 'Josh', 'Chavez');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US020', 'David', 'McIntyre');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US019', 'Larry', 'Roberts');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US018', 'Jose', 'Martinez Amoedo');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US017', 'Nicole', 'Apelian');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US016', 'Justin', 'Vititoe');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US015', 'Randy', 'Champagne');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US014', 'Mike', 'Lowe');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US013', 'Tracy', 'Wilson');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US012', 'Mary Kate', 'Green');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US011', 'Desmond', 'White');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US030', 'Zachary', 'Fowler');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US029', 'Carleigh', 'Fairchild');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US028', 'Megan', 'Hanacek');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US027', 'Dave', 'Nessia');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US026', 'Callie', 'North');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US025', 'Greg', 'Ovens');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US024', 'Dan', 'Wowak');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US023', 'Britt', 'Ahart');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US022', 'Zachary', 'Gault');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US021', 'Jim', 'Shields');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US044', 'Jim', 'Baird');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US043', 'Ted', 'Baird');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US042', 'Pete', 'Brockdorff');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US041', 'Sam', 'Brockdorff');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US040', 'Brooke', 'Whipple');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US039', 'Dave', 'Whipple');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US038', 'Chris', 'Wilkes');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US037', 'Brody', 'Wilkes');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US036', 'Shannon', 'Bosdell');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US035', 'Jesse', 'Bosdell');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US034', 'Alex', 'Ribar');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US033', 'Logan', 'Ribar');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US032', 'Brad', 'Richardson');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US031', 'Josh', 'Richardson');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US054', 'Jordan', 'Jonas');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US053', 'Woniya', 'Thibeault');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US052', 'Nathan', 'Donnelly');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US051', 'Barry', 'Karcher');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US050', 'Nikki', 'van Schyndel');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US049', 'Michelle', 'Wohlberg');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US048', 'Brady', 'Nicholls');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US047', 'Ray', 'Livingston');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US046', 'Donny', 'Dust');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US045', 'Tim', 'Backus');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US064', 'Roland', 'Welker');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US063', 'Callie', 'Russell');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US062', 'Kielyn', 'Marrone');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US061', 'Amos', 'Rodriguez');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US060', 'Mark', 'D''Ambrosio');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US059', 'Joe', 'Nicholas');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US058', 'Joel', 'Van Der Loon');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US057', 'Keith', 'Syers');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US056', 'Correy', 'Hawk');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US055', 'Shawn', 'Helton');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US074', 'Clay', 'Hayes');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US073', 'Biko', 'Wright');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US072', 'Theresa', 'Emmerich Kamper');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US071', 'Colter', 'Barnes');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US070', 'Rose', 'Anna Moore');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US069', 'Nate', 'Weber');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US068', 'Matt', 'Corradino');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US067', 'Michelle', 'Finn');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US066', 'Jordon', 'Bell');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US065', 'Tim', 'Madsen');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US084', 'Juan Pablo', 'Quinonez');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US083', 'Karie', 'Lee Knoke');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US082', 'Teimojin', 'Tan');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US081', 'Adam', 'Riley');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US080', 'Jessie', 'Krebs');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US079', 'Tom', 'Garstang');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US078', 'Terry', 'Burns');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US077', 'Benji', 'Hill');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US076', 'Igor', 'Limansky');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US075', 'Jacques', 'Turcotte');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US099', 'Alan', 'Tenta');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US098', 'Wyatt', 'Black');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US097', 'Mikey', 'Helton');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US096', 'Melanie', 'Sawyer');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US095', 'Taz', 'Ramos Dos Santos');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US100', 'Cade', 'Cole');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US101', 'Jodi', 'Rose');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US102', 'Luke', 'Joseph Olsen');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US103', 'Ann', 'Rosenquist');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US104', 'Lee Ray', 'DeWilden');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US085', 'Peter', 'Albano');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US086', 'Dusty', 'Blake');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US087', 'Michela', 'Carriere');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US088', 'Timber', 'Cleghorn');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US089', 'Cubby', 'Hoover');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US090', 'William', 'Larkham');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US091', 'Jake', 'Messinger');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US092', 'Dub', 'Paetz');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US093', 'Sarah', 'Poynter');
INSERT INTO survivalist_data (id, first_name, last_name) VALUES ('US094', 'Isaiah', 'Tucker');
-- 8) insert data to survivor_season_data table
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU004', 1, 52, 'Female', '', 'New South Wales', 'Australia', 'Rewilding Facilitator');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU008', 1, 45, 'Male', '', 'New South Wales', 'Australia', 'Solo Adventurist');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU007', 1, 43, 'Male', '', 'New South Wales', 'Australia', 'Vet And Bush Regenerator');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU006', 1, 41, 'Female', '', 'Australian Capital Territory', 'Australia', 'Wildlife Biologist');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU002', 1, 39, 'Male', '', 'Tasmania', 'Australia', 'Army Veteran');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU003', 1, 35, 'Male', '', 'New South Wales', 'Australia', 'Wildlife And Environmental Officer');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU009', 1, 31, 'Male', '', 'New South Wales', 'Australia', 'Hunting Guide');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU005', 1, 22, 'Male', '', 'South Australia', 'Australia', 'Farmhand And Engineering Student');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU001', 1, 42, 'Female', '', 'Victoria', 'Australia', 'School Teacher');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU010', 1, 41, 'Male', '', 'Victoria', 'Australia', 'Planning And Environmental Manager');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU016', 2, 39, 'Male', '', 'Victoria', 'Australia', 'Aquaculturist');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU015', 2, 54, 'Female', '', 'New South Wales', 'Australia', 'Adventure Guide');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU014', 2, 42, 'Male', '', 'New South Wales', 'Australia', 'Personal Trainer/Subsistence Hunter');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU012', 2, 51, 'Female', '', 'Queensland', 'Australia', 'Off-Gridder/Former Police Officer');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU017', 2, 58, 'Male', '', 'Queensland', 'Australia', 'Survival Educator/Former Sas Soldier');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU018', 2, 55, 'Male', '', 'Victoria', 'Australia', 'Tradesman And Wild Game Hunter');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU020', 2, 27, 'Male', '', 'Queensland', 'Australia', 'Defence Force Combat Engineer');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU011', 2, 37, 'Male', '', 'New South Wales', 'Australia', 'Youth Worker');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU013', 2, 41, 'Female', '', 'Victoria', 'Australia', 'World Heritage Aboriginals Program Officer');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('AU019', 2, 60, 'Male', '', 'New South Wales', 'Australia', 'Resilience Coach');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US010', 3, 40, 'Male', 'Blairsville', 'Georgia', 'United States', 'Corrections Officer');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US009', 3, 22, 'Male', 'Lincoln', 'Nebraska', 'United States', 'Outdoor Gear Retailer');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US008', 3, 34, 'Male', 'Bellingham', 'Massachusetts', 'United States', 'Butcher');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US007', 3, 32, 'Male', 'Quasqueton', 'Iowa', 'United States', 'Survivalist And Wildlife Therapist/Natural Healing');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US006', 3, 37, 'Male', 'Pittsburgh', 'Pennsylvania', 'United States', 'Carpenter');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US005', 3, 44, 'Male', 'Albemarle', 'North Carolina', 'United States', 'Us Veteran');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US004', 3, 46, 'Male', 'Saint John', 'New Brunswick', 'Canada', 'Research Assistant');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US003', 3, 24, 'Male', 'Windsor', 'Ontario', 'Canada', 'Carpenter');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US002', 3, 41, 'Male', 'Umatilla', 'Florida', 'United States', 'Author');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US001', 3, 31, 'Male', 'Jackson', 'Ohio', 'United States', 'Law Enforcement');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US020', 4, 50, 'Male', 'Kentwood', 'Michigan', 'United States', 'Writer And Former Missionary');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US019', 4, 44, 'Male', 'Rush City', 'Minnesota', 'United States', 'Electrician');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US018', 4, 45, 'Male', 'Santa Pola', 'Valencia', 'Canada', 'Aboriginal Skills Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US017', 4, 45, 'Female', 'Portland', 'Oregon', 'United States', 'Anthropologist');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US016', 4, 35, 'Male', 'Augusta', 'Georgia', 'United States', 'Us Veteran');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US015', 4, 28, 'Male', 'Boulder', 'Utah', 'United States', 'Survival Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US014', 4, 55, 'Male', 'Lewis', 'Colorado', 'United States', 'Survival Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US013', 4, 44, 'Female', 'Aiken', 'South Carolina', 'United States', 'Law Enforcement And Former Air Force');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US012', 4, 36, 'Female', 'Homer', 'Alaska', 'United States', 'Former Wildland Firefighter');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US011', 4, 37, 'Male', 'Coolidge', 'Arizona', 'United States', 'Us Veteran');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US030', 5, 36, 'Male', 'Appleton', 'Maine', 'United States', 'Boat Builder');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US029', 5, 28, 'Female', 'Edna Bay', 'Alaska', 'United States', 'Homesteader & Carpenter');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US028', 5, 41, 'Female', 'Port McNeill', 'British Columbia', 'Canada', 'Biologist & Forrester');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US027', 5, 49, 'Male', 'Salt Lake City', 'Utah', 'United States', 'Bushcraft Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US026', 5, 27, 'Female', 'Lopez Island', 'Washington', 'United States', 'Herbalist');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US025', 5, 53, 'Male', 'Canal Flats', 'British Columbia', 'Canada', 'Drywaller');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US024', 5, 34, 'Male', 'Mahanoy City', 'Pennsylvania', 'United States', 'Trapper');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US023', 5, 40, 'Male', 'Mantua', 'Ohio', 'United States', 'Accountant');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US022', 5, 22, 'Male', 'Caledon', 'Ontario', 'Canada', 'Wilderness Skills Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US021', 5, 37, 'Male', 'Langhorne', 'Pennsylvania', 'United States', 'High School Teacher');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US044', 6, 35, 'Male', 'Toronto', 'Ontario', 'Canada', 'Freelance Writer');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US043', 6, 32, 'Male', 'Toronto', 'Ontario', 'Canada', 'Adventure Videographer');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US042', 6, 61, 'Male', 'Poolesville', 'Maryland', 'United States', 'Retired Shipping Driver');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US041', 6, 26, 'Male', 'Poolesville', 'Maryland', 'United States', 'Environmental Scientist');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US040', 6, 45, 'Female', 'Fox', 'Alaska', 'United States', 'Outdoor Educator');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US039', 6, 40, 'Male', 'Fox', 'Alaska', 'United States', 'Builder');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US038', 6, 44, 'Male', 'Hattiesburg', 'Mississippi', 'United States', 'Psychotherapist');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US037', 6, 33, 'Male', 'Kentwood', 'Louisiana', 'United States', 'Industrial Project Manager');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US036', 6, 44, 'Male', 'Wrangell', 'Alaska', 'United States', 'Fisherman');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US035', 6, 31, 'Male', 'Skowhegan', 'Maine', 'United States', 'Us Veteran');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US034', 6, 48, 'Male', 'Montville', 'Maine', 'United States', 'Construction Foreman');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US033', 6, 19, 'Male', 'Liberty', 'Maine', 'United States', 'Equipment Operator');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US032', 6, 23, 'Male', 'Fox Lake', 'Illinois', 'United States', 'Blacksmith');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US031', 6, 19, 'Male', 'Fox Lake', 'Illinois', 'United States', 'Blacksmith');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US009', 7, 24, 'Male', 'Lincoln', 'Nebraska', 'United States', 'Wilderness Skills Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US023', 7, 41, 'Male', 'Mantua', 'Ohio', 'United States', 'Accountant');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US019', 7, 46, 'Male', 'Rush City', 'Minnesota', 'United States', 'Electrician');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US027', 7, 50, 'Male', 'Salt Lake City', 'Utah', 'United States', 'Bushcraft Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US015', 7, 31, 'Male', 'Boulder', 'Utah', 'United States', 'Wilderness Skills Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US040', 7, 45, 'Female', 'Fox', 'Alaska', 'United States', 'Outdoor Educator');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US035', 7, 32, 'Male', 'Skowhegan', 'Maine', 'United States', 'Us Veteran');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US017', 7, 47, 'Female', 'Raymond', 'Washington', 'United States', 'Wilderness Living Skills Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US032', 7, 24, 'Male', 'Fox Lake', 'Illinois', 'United States', 'Blacksmith');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US029', 7, 30, 'Female', 'Anchorage', 'Alaska', 'United States', 'Carpenter');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US054', 8, 35, 'Male', 'Lynchburg', 'Virginia', 'United States', 'Construction');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US053', 8, 42, 'Female', 'Grass Valley', 'California', 'United States', 'Ancestral Skills Teacher');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US052', 8, 39, 'Male', 'Lopez Island', 'Washington', 'United States', 'Disaster Preparedness Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US051', 8, 39, 'Male', 'Fort Collins', 'Colorado', 'United States', 'Self Defense Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US050', 8, 44, 'Female', 'Echo Bay', 'British Columbia', 'Canada', 'Wilderness Guide');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US049', 8, 31, 'Female', 'Mullingar', 'Saskatchewan', 'Canada', 'Homesteader');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US048', 8, 36, 'Male', 'San Antonio', 'Texas', 'United States', 'Sere Specialist');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US047', 8, 43, 'Male', 'Vancouver', 'Washington', 'United States', 'Search And Rescue K9 Handler');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US046', 8, 38, 'Male', 'Monument', 'Colorado', 'United States', 'Primitive Technology Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US045', 8, 55, 'Male', 'Lubbock', 'Texas', 'United States', 'Hunting Guide');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US064', 9, 47, 'Male', 'Red Devil', 'Alaska', 'United States', 'Hunting Guide');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US063', 9, 31, 'Female', 'Flathead Valley', 'Montana', 'United States', 'Ancestral Living Skills Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US062', 9, 33, 'Female', 'Espanola', 'Ontario', 'Canada', 'Winter Wilderness Expedition Operator');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US061', 9, 40, 'Male', 'Indianapolis', 'Indiana', 'United States', 'Primitive Skills Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US060', 9, 33, 'Male', 'Vancouver', 'Washington', 'United States', 'Sniper & Survival Skills Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US059', 9, 31, 'Male', 'Redding', 'California', 'United States', 'Biologist');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US058', 9, 34, 'Male', 'Sisters', 'Oregon', 'United States', 'Primitive Skills School Owner');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US057', 9, 45, 'Male', 'Sturgis', 'Kentucky', 'United States', 'Homesteader');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US056', 9, 30, 'Male', 'Plattsmouth', 'Nebraska', 'United States', 'Traditional Bowyer');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US055', 9, 43, 'Male', 'Henry', 'Tennessee', 'United States', 'Tool Maker');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US074', 10, 40, 'Male', 'Kendrick', 'Idaho', 'United States', 'Professional Bowyer & Hunter');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US073', 10, 29, 'Male', 'Otis', 'Oregon', 'United States', 'Construction Laborer/Lead Singer');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US072', 10, 40, 'Female', 'Exeter', 'England', 'United Kingdom', 'Prehistoric Leather Specialist');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US071', 10, 36, 'Male', 'Inian Islands', 'Alaska', 'United States', 'Homesteader & Educator');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US070', 10, 43, 'Female', 'Wellsboro', 'Pennsylvania', 'United States', 'Retail Sporting Goods Owner');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US069', 10, 47, 'Male', 'East Jordan', 'Michigan', 'United States', 'Retired Military/Homesteader');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US068', 10, 42, 'Male', 'St. Croix', '', 'U.S. Virgin Islands', 'Survival Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US067', 10, 46, 'Female', 'Cherryfield', 'Maine', 'United States', 'Educational Consultant');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US066', 10, 43, 'Male', 'Oak Ridge', 'Tennessee', 'United States', 'Carpenter');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US065', 10, 48, 'Male', 'Laramie', 'Wyoming', 'United States', 'Oil Rig Roughneck');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US084', 11, 30, 'Male', 'Pinawa', 'Manitoba', 'Canada', 'Outdoor Professional');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US083', 11, 57, 'Female', 'Sandpoint', 'Idaho', 'United States', 'Wilderness/Primitive Skills Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US082', 11, 31, 'Male', 'Montreal', 'Quebec', 'Canada', 'Physician');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US081', 11, 36, 'Male', 'Fayetteville', 'Arkansas', 'United States', 'Alpaca Shearer, Treehouse Builder');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US080', 11, 49, 'Female', 'Pagosa Springs', 'Colorado', 'United States', 'Survival Instructor');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US079', 11, 35, 'Male', 'Earlysville', 'Virginia', 'United States', 'Prescribed Fire Practitioner, Regenerative Agriculturalist, Leatherworker');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US078', 11, 30, 'Male', 'Homer', 'Alaska', 'United States', 'Fisherman');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US077', 11, 46, 'Male', 'Bellevue', 'Idaho', 'United States', 'Hunting And Packgoat Guide');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US076', 11, 39, 'Male', 'Salt Lake City', 'Utah', 'United States', 'Community Leadership');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US075', 11, 23, 'Male', 'Juneau', 'Alaska', 'United States', 'Wilderness Expedition Guide');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US099', 12, 52, 'Male', 'Columbia Valley', 'British Columbia', 'Canada', 'High School Teacher');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US098', 12, 50, 'Male', 'Bracebridge', 'Ontario', 'Canada', 'Usiness Owner');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US097', 12, 31, 'Male', 'Rome', 'Georgia', 'United States', 'Carpenter');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US096', 12, 54, 'Female', 'Moriah', 'New York', 'United States', 'Living History Teacher And Founder Of Wild Foods');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US095', 12, 35, 'Male', 'Becket', 'Massachusetts', 'United States', 'Direct Support Professional/ Musician/ Homesteader');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US100', 12, 28, 'Male', 'Crowheart', 'Wyoming', 'United States', 'Hunting Guide');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US101', 12, 45, 'Female', 'Worland', 'Wyoming', 'United States', 'Owner Of Wild River Tables');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US102', 12, 39, 'Male', 'Maui', 'Hawaii', 'United States', 'Entrepreneur And Glass Artist');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US103', 12, 56, 'Female', 'Bayfield', 'Wisconsin', 'United States', 'Off-Grid Organic Farmer');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US104', 12, 59, 'Male', 'Huslia', 'Alaska', 'United States', 'Pilot');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US053', 13, 45, 'Female', '', 'California', 'United States', '');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US067', 13, 47, 'Female', '', 'Maine', 'United States', '');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US063', 13, 34, 'Female', '', 'Montana', 'United States', '');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US061', 13, 41, 'Male', '', 'Indiana', 'United States', '');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US025', 13, 58, 'Male', '', 'British Columbia', 'Canada', '');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US060', 13, 36, 'Male', '', 'Washington', 'United States', '');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US085', 14, 42, 'Male', 'Castelgar', 'British Columbia', 'Canada', 'Librarian');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US086', 14, 36, 'Male', 'Fifty-Six', 'Arkansas', 'United States', 'Welder');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US087', 14, 34, 'Female', 'Cumberland House', 'Saskatchewan', 'Canada', 'Adventure Guide');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US088', 14, 35, 'Male', 'Salem', 'Indiana', 'United States', 'Humanitarian Aid Worker');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US089', 14, 33, 'Male', 'Seligman', 'Missouri', 'United States', 'Bowyer And Homesteader');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US090', 14, 49, 'Male', 'Happy Valley Goose Bay', 'Labrador', 'Canada', 'Fisherman');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US091', 14, 42, 'Male', 'Fremont County', 'Idaho', 'United States', 'Professional Falconer');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US092', 14, 44, 'Male', 'Frederic', 'Michigan', 'United States', 'Wilderness Skills Practitioner');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US093', 14, 48, 'Female', 'Skwentna', 'Alaska', 'United States', 'Fisherman');
INSERT INTO survivor_season_data (survivalist_id, season_data_id, age, gender, city, state, country, profession) VALUES ('US094', 14, 36, 'Male', 'Ghent', 'West Virginia', 'United States', 'Game Warden');
-- 9) insert data to appearance_data table
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU004', 1, 1, 67, 0, '', '', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU008', 1, 2, 64, 1, 'Blood pressure too low', 'Health', 10, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU007', 1, 3, 30, 0, 'Missed his family', 'Personal', 10, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU006', 1, 4, 23, 0, 'Missed her family', 'Personal', 8, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU002', 1, 5, 12, 0, 'Just felt right', 'Personal', 7, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU003', 1, 6, 10, 0, 'Missed his family', 'Personal', 5, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU009', 1, 7, 3, 0, 'Injured Knee, had enough', 'Personal', 3, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU005', 1, 8, 2, 1, 'Tested positive for COVID-19', 'Health', 2, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU001', 1, 9, 2, 0, 'Couldn''t start fire, lost the mental game', 'Personal', 2, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU010', 1, 10, 2, 0, 'Missed his family', 'Personal', 2, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU016', 2, 1, 64, 0, '', '', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU015', 2, 2, 63, 0, 'At physical limit', 'Health', 10, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU014', 2, 3, 57, 0, 'At physical limit; unable to sustain himself further', 'Health', 10, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU012', 2, 4, 53, 0, 'Felt like she was at her physical limit; worried about her safety given her weakness; didn''t think she could get more food', 'Health', 9, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU017', 2, 5, 38, 0, 'Accomplished what he wanted to accomplish', 'Personal', 8, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU018', 2, 6, 16, 0, 'Wanted to finish strong', 'Personal', 5, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU020', 2, 7, 10, 0, 'Missed pregnant wife', 'Personal', 4, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU011', 2, 8, 8, 0, 'No longer trusted himself; dizzy spells', 'Personal', 4, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU013', 2, 9, 4, 0, 'Missed her family', 'Personal', 2, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('AU019', 2, 10, 2, 1, 'Heart palpitations', 'Health', 2, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US010', 3, 1, 56, 0, '', '', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US009', 3, 2, 55, 0, 'Lost the mind game', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US008', 3, 3, 43, 0, 'Realized he should actually be around for his mother''s cancer', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US007', 3, 4, 39, 0, 'Felt content with what he had done', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US006', 3, 5, 8, 0, 'Fear of storm', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US005', 3, 6, 6, 0, 'Consuming salt water', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US004', 3, 7, 4, 0, 'Fear of bears', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US003', 3, 8, 4, 0, 'Loss of ferro rod', 'Loss of inventory', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US002', 3, 9, 1, 0, 'Fear of wolves', 'Personal', 2, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US001', 3, 10, 0, 0, 'Fear of bears', 'Personal', 1, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US020', 4, 1, 66, 0, '', '', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US019', 4, 2, 64, 0, 'Hunger and mental breakdown', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US018', 4, 3, 59, 0, 'Fell off kayak into river', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US017', 4, 4, 57, 0, 'Missed her kids', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US016', 4, 5, 35, 0, 'Had nothing left to accomplish', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US015', 4, 6, 21, 0, 'Didn''t like being alone', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US014', 4, 7, 21, 0, 'Missed his wife', 'Personal', 7, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US013', 4, 8, 8, 0, 'Afraid of bears', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US012', 4, 9, 7, 1, 'Split tendon with axe', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US011', 4, 10, 0, 0, 'Bear scare', 'Personal', 1, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US030', 5, 1, 87, 0, '', '', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US029', 5, 2, 86, 1, 'BMI too low', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US028', 5, 3, 78, 0, '2 broken teeth (molars), jaw pain', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US027', 5, 4, 73, 1, 'Systolic pressure too low', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US026', 5, 5, 72, 0, 'Felt like journey was complete', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US025', 5, 6, 51, 0, 'Hypothermia', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US024', 5, 7, 51, 0, 'Missed family', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US023', 5, 8, 35, 0, 'Missed family', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US022', 5, 9, 8, 1, 'Cut arm with axe', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US021', 5, 10, 2, 0, 'Regretted leaving family', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US044', 6, 1, 75, 0, '', '', NULL, 'Ted and Jim Baird (brothers)', 10);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US043', 6, 1, 75, 0, '', '', NULL, 'Ted and Jim Baird (brothers)', 10);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US042', 6, 2, 74, 0, 'Starvation, Jointly decided the cost of the game wasn''t worth it', 'Health', NULL, 'Pete and Sam Brockdorff (father/son)', 9);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US041', 6, 2, 74, 0, 'Starvation, Jointly decided the cost of the game wasn''t worth it', 'Health', NULL, 'Pete and Sam Brockdorff (father/son)', 9);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US040', 6, 3, 49, 0, 'Felt too exhausted and drained to go on', 'Personal', NULL, 'Dave and Brooke Whipple (husband/wife)', 9);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US039', 6, 3, 49, 0, 'Felt too exhausted and drained to go on', 'Personal', NULL, 'Dave and Brooke Whipple (husband/wife)', 9);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US038', 6, 4, 14, 0, 'Missed family and felt guilty for having left them behind', 'Personal', NULL, 'Chris and Brody Wilkes (brothers)', 8);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US037', 6, 4, 14, 0, 'Missed family and felt guilty for having left them behind', 'Personal', NULL, 'Chris and Brody Wilkes (brothers)', 8);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US036', 6, 5, 5, 1, 'Lower back injury', 'Health', NULL, 'Jesse and Shannon Bosdell (brothers)', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US035', 6, 5, 5, 0, 'Shannon obtained lower back injury', 'Health', NULL, 'Jesse and Shannon Bosdell (brothers)', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US034', 6, 6, 2, 0, 'Were not mentally prepared', 'Personal', NULL, 'Alex and Logan Ribar (father/son)', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US033', 6, 6, 2, 0, 'Were not mentally prepared', 'Personal', NULL, 'Alex and Logan Ribar (father/son)', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US032', 6, 7, 1, 0, 'Josh injured ankle', 'Health', NULL, 'Brad and Josh Richardson (brothers)', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US031', 6, 7, 1, 1, 'Injured ankle', 'Health', NULL, 'Brad and Josh Richardson (brothers)', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US009', 7, 1, 60, 0, '', '', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US023', 7, 2, 56, 0, 'Missed his family', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US019', 7, 3, 41, 0, 'Missed his family', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US027', 7, 4, 36, 0, 'Just felt right', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US015', 7, 5, 35, 0, 'Lonely', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US040', 7, 6, 28, 0, 'Lonely', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US035', 7, 7, 24, 1, 'Constipation, possible fecal impaction', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US017', 7, 8, 9, 1, 'MS attack', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US032', 7, 9, 7, 0, 'Had no food the whole time', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US029', 7, 10, 5, 1, 'Fish hook in hand', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US054', 8, 1, 77, 0, '', '', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US053', 8, 2, 73, 0, 'Starvation', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US052', 8, 3, 72, 0, 'Shelter fire', 'Loss of inventory', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US051', 8, 4, 69, 1, 'Lost too much weight', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US050', 8, 5, 52, 1, 'Low BMI, lost too much weight', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US049', 8, 6, 48, 1, 'Constipation, possible impacted bowel', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US048', 8, 7, 32, 0, 'Missed his family', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US047', 8, 8, 19, 0, 'Nothing left to give', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US046', 8, 9, 8, 1, 'Food poisoning', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US045', 8, 10, 4, 1, 'Broken ankle', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US064', 9, 1, 100, 0, '', '', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US063', 9, 2, 89, 1, 'Frostbite of the toes', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US062', 9, 3, 80, 0, 'Starvation', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US061', 9, 4, 58, 0, 'Starvation', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US060', 9, 5, 44, 0, 'Trichinosis', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US059', 9, 6, 44, 0, 'Starvation', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US058', 9, 7, 40, 0, 'Starvation', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US057', 9, 8, 22, 1, 'Food poisoning, infection', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US056', 9, 9, 12, 1, 'Torn Meniscus, partially torn MCL', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US055', 9, 10, 10, 0, 'Lost fire starter', 'Loss of inventory', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US074', 10, 1, 74, 0, '', '', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US073', 10, 2, 73, 0, 'Starvation, heart palpitations', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US072', 10, 3, 69, 1, 'Low BMI, lost too much weight', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US071', 10, 4, 67, 1, 'Low BMI, lost too much weight', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US070', 10, 5, 37, 1, 'Frostbite, malnutrition', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US069', 10, 6, 24, 0, 'Food poisoning', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US068', 10, 7, 22, 0, 'Missed his family, starvation', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US067', 10, 8, 21, 0, 'Starvation', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US066', 10, 9, 19, 0, 'Missed his family', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US065', 10, 10, 6, 0, 'Anxiety attack, chest pains', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US084', 11, 1, 78, 0, '', '', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US083', 11, 2, 75, 0, 'Starvation, Exhaustion', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US082', 11, 3, 63, 0, 'Missed his family', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US081', 11, 4, 52, 0, 'Starvation', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US080', 11, 5, 46, 1, 'Stomach inflammation', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US079', 11, 6, 43, 0, 'Fell, injured back and knee', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US078', 11, 7, 42, 1, 'Low BMI (lost too much weight), parastic infection', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US077', 11, 8, 27, 1, 'Gardia infection', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US076', 11, 9, 20, 0, 'Heart palpitations', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US075', 11, 10, 15, 0, 'Missed his family', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US099', 12, 1, 66, 0, '', '', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US098', 12, 2, 64, 0, 'Felt journey was complete', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US097', 12, 3, 55, 0, 'Effects of being cold. (Chose to tap rather than med evac.)', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US096', 12, 4, 43, 0, 'Missed her fiance', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US095', 12, 5, 40, 0, 'Starvation', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US100', 12, 6, 23, 0, 'Loss of conciousness', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US101', 12, 7, 22, 0, 'Missed her family', 'Personal', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US102', 12, 8, 20, 0, 'Intestinal problems', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US103', 12, 9, 19, 0, 'Starvation, heart palpitations', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US104', 12, 10, 18, 0, 'Starvation', 'Health', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US053', 13, 1, 40, 0, '', '', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US067', 13, 2, 38, 0, 'Eye injury', 'Health', 8, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US063', 13, 3, 26, 0, 'Lack of food', 'Health', 7, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US061', 13, 4, 19, 0, 'Missed his family, but also health: didn''t want to push his body', 'Personal', 5, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US025', 13, 5, 6, 0, 'Lack of food, anxiety, wet gear', 'Personal', 3, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US060', 13, 6, 5, 0, 'Missed his family', 'Personal', 1, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US085', 14, 9, 8, 0, 'Discovered emotional trauma and needed to leave to address it', 'Personal', 3, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US086', 14, 8, 10, 0, 'Gastrointestinal issues', 'Health', 4, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US087', 14, 7, 18, 0, 'Needed community', 'Personal', 5, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US088', 14, 2, 83, 0, 'Achieved personal goals and the money would be a burden', 'Personal', 12, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US089', 14, 10, 4, 1, 'Arrow 4 inches into his thigh', 'Health', 1, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US090', 14, 1, 84, 0, '', '', NULL, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US091', 14, 6, 21, 1, 'Medically evacuated due to obstructed digestive system', 'Health', 7, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US092', 14, 3, 80, 0, 'MIssed his family and decided it was no longer worth it', 'Personal', 12, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US093', 14, 4, 42, 0, 'Kidneys hurt', 'Health', 9, '', NULL);
INSERT INTO appearance_data (survivalist_id, season_data_id, result, days_lasted, medically_evacuated, reason_tapped_out, reason_category, episode_tapped, team, day_linked_up) VALUES ('US094', 14, 5, 23, 0, 'Worried about his heart', 'Health', 6, '', NULL);