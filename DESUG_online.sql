create database DESUG;

use DESUG;

CREATE TABLE student (
    roll_number CHAR(8) PRIMARY KEY,
    name VARCHAR(100),
    department ENUM('SLS', 'SEST', 'SoMS', 'SMS', 'SSS', 'SE', 'SH', 'SM&S', 'SCIS', 'SP.SC', 'SNS', 'CIS'),
    student_type ENUM('PG', 'Research')
);

INSERT INTO student (roll_number, name, department, student_type) VALUES
('20MCME01', 'stu1', 'SCIS', 'PG'),
('20MCME02', 'stu2', 'SCIS', 'PG'),
('20MCME03', 'stu3', 'SCIS', 'PG'),
('20MCME04', 'stu4', 'SCIS', 'PG'),
('20MCME05', 'stu5', 'SCIS', 'PG'),
('20MCME06', 'stu6', 'SCIS', 'PG'),
('20MCME07', 'stu7', 'SCIS', 'PG'),
('20MCME08', 'stu8', 'SCIS', 'PG'),
('20MCME09', 'stu9', 'SCIS', 'PG'),
('20MCME10', 'stu10', 'SCIS', 'PG'),
('20MCME11', 'stu11', 'SCIS', 'PG'),
('20MCME12', 'stu12', 'SCIS', 'PG'),
('20MCME13', 'stu13', 'SCIS', 'PG'),
('20MCME14', 'stu14', 'SCIS', 'PG'),
('20MCME15', 'stu15', 'SCIS', 'PG'),
('20MCME16', 'stu16', 'SCIS', 'PG'),
('20MCME17', 'stu17', 'SCIS', 'PG'),
('20MCME18', 'stu18', 'SCIS', 'PG'),
('20MCME19', 'stu19', 'SCIS', 'PG'),
('20MCME20', 'stu20', 'SCIS', 'PG');

INSERT INTO student (roll_number, name, department, student_type) VALUES
('21MCME01', 'stu1', 'SCIS', 'PG'),
('21MCME02', 'stu2', 'SCIS', 'PG'),
('21MCME03', 'stu3', 'SCIS', 'PG'),
('21MCME04', 'stu4', 'SCIS', 'PG'),
('21MCME05', 'stu5', 'SCIS', 'PG'),
('21MCME06', 'stu6', 'SCIS', 'PG'),
('21MCME07', 'stu7', 'SCIS', 'PG'),
('21MCME08', 'stu8', 'SCIS', 'PG'),
('21MCME09', 'stu9', 'SCIS', 'PG'),
('21MCME10', 'stu10', 'SCIS', 'PG'),
('21MCME11', 'stu11', 'SCIS', 'PG'),
('21MCME12', 'stu12', 'SCIS', 'PG'),
('21MCME13', 'stu13', 'SCIS', 'PG'),
('21MCME14', 'stu14', 'SCIS', 'PG'),
('21MCME15', 'stu15', 'SCIS', 'PG'),
('21MCME16', 'stu16', 'SCIS', 'PG'),
('21MCME17', 'stu17', 'SCIS', 'PG'),
('21MCME18', 'stu18', 'SCIS', 'PG'),
('21MCME19', 'stu19', 'SCIS', 'PG'),
('21MCME20', 'stu20', 'SCIS', 'PG');

INSERT INTO student (roll_number, name, department, student_type) VALUES
('19MCME01', 'stu1', 'SCIS', 'PG'),
('19MCME02', 'stu2', 'SCIS', 'PG'),
('19MCME03', 'stu3', 'SCIS', 'PG'),
('19MCME04', 'stu4', 'SCIS', 'PG'),
('19MCME05', 'stu5', 'SCIS', 'PG'),
('19MCME06', 'stu6', 'SCIS', 'PG'),
('19MCME07', 'stu7', 'SCIS', 'PG'),
('19MCME08', 'stu8', 'SCIS', 'PG'),
('19MCME09', 'stu9', 'SCIS', 'PG'),
('19MCME10', 'stu10', 'SCIS', 'PG'),
('19MCME11', 'stu11', 'SCIS', 'PG'),
('19MCME12', 'stu12', 'SCIS', 'PG'),
('19MCME13', 'stu13', 'SCIS', 'PG'),
('19MCME14', 'stu14', 'SCIS', 'PG'),
('19MCME15', 'stu15', 'SCIS', 'PG'),
('19MCME16', 'stu16', 'SCIS', 'PG'),
('19MCME17', 'stu17', 'SCIS', 'PG'),
('19MCME18', 'stu18', 'SCIS', 'PG'),
('19MCME19', 'stu19', 'SCIS', 'PG'),
('19MCME20', 'stu20', 'SCIS', 'PG');

INSERT INTO student (roll_number, name, department, student_type) VALUES
('22MCMT01', 'student1', 'SCIS', 'Research'),
('22MCMT02', 'student2', 'SCIS', 'Research'),
('22MCMT03', 'student3', 'SCIS', 'Research'),
('22MCMT04', 'student4', 'SCIS', 'Research'),
('22MCMT05', 'student5', 'SCIS', 'Research'),
('22MCMT06', 'student6', 'SCIS', 'Research'),
('22MCMT07', 'student7', 'SCIS', 'Research'),
('22MCMT08', 'student8', 'SCIS', 'Research'),
('22MCMT09', 'student9', 'SCIS', 'Research'),
('22MCMT10', 'student10', 'SCIS', 'Research');

INSERT INTO student (roll_number, name, department, student_type) VALUES
('23MCMT01', 'student1', 'SCIS', 'Research'),
('23MCMT02', 'student2', 'SCIS', 'Research'),
('23MCMT03', 'student3', 'SCIS', 'Research'),
('23MCMT04', 'student4', 'SCIS', 'Research'),
('23MCMT05', 'student5', 'SCIS', 'Research'),
('23MCMT06', 'student6', 'SCIS', 'Research'),
('23MCMT07', 'student7', 'SCIS', 'Research'),
('23MCMT08', 'student8', 'SCIS', 'Research'),
('23MCMT09', 'student9', 'SCIS', 'Research'),
('23MCMT10', 'student10', 'SCIS', 'Research');


select * from student;

show create table student;

ALTER TABLE student ADD COLUMN subject VARCHAR(100) DEFAULT 'CS';

ALTER TABLE student ADD COLUMN course VARCHAR(100);

UPDATE student
SET course = CASE 
                WHEN student_type = 'PG' THEN 'IMTECH'
                WHEN student_type = 'Research' THEN 'MTECH'
            END;
            
SET SQL_SAFE_UPDATES = 0;


CREATE TABLE student (
    roll_number CHAR(8) PRIMARY KEY,
    name VARCHAR(100),
    department ENUM('SLS', 'SEST', 'SoMS', 'SMS', 'SSS', 'SE', 'SH', 'SM&S', 'SCIS', 'SP.SC', 'SNS', 'CIS'),
    student_type ENUM('PG', 'Research')
);

CREATE TABLE nominations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_roll_number CHAR(8) NOT NULL,
    position_id INT,
    proposer_roll_number CHAR(8) NOT NULL,
    seconder_roll_number CHAR(8) NOT NULL,
    name_on_ballot_paper VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    age INT,
    category VARCHAR(50),
    fathers_name VARCHAR(255),
    mobile_number VARCHAR(10),
    email VARCHAR(255),
    residential_address TEXT,
    FOREIGN KEY (candidate_roll_number) REFERENCES student(roll_number),
    FOREIGN KEY (position_id) REFERENCES positions(id),
    FOREIGN KEY (proposer_roll_number) 
    REFERENCES student(roll_number),
    FOREIGN KEY (seconder_roll_number) REFERENCES student(roll_number)
);

CREATE TABLE positions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    position_name VARCHAR(255) NOT NULL
);

CREATE TABLE age_rule (
    academic_programme VARCHAR(20),
    min_age INT,
    max_age INT,
    PRIMARY KEY (academic_programme)
);

INSERT INTO age_rule (academic_programme, min_age, max_age)
VALUES ('UG', 17, 22),
       ('PG', NULL, 25),
       ('PhD', NULL, 28);


select * from student;

INSERT INTO positions (position_name) VALUES ('President');
INSERT INTO positions (position_name) VALUES ('Vice-President');
INSERT INTO positions (position_name) VALUES ('General Secretary');
INSERT INTO positions (position_name) VALUES ('Joint Secretary');
INSERT INTO positions (position_name) VALUES ('Cultural Secretary');
INSERT INTO positions (position_name) VALUES ('Sports Secretary');
INSERT INTO positions (position_name) VALUES ('School Board Member');
INSERT INTO positions (position_name) VALUES ('Councillor');

show tables;

use DESUG;
select * from student;

ALTER TABLE student
ADD COLUMN DOB DATE NOT NULL DEFAULT '2000-01-01';

update student set name = 'T Bharath Simha Reddy' Where roll_number = '21MCME05';

ALTER TABLE student
ADD COLUMN semester int NOT NULL DEFAULT 1;


CREATE TABLE login (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(8) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    FOREIGN KEY (username) REFERENCES student(roll_number)
);

select * from login;


CREATE TABLE elections (
    election_id INT AUTO_INCREMENT PRIMARY KEY,
    election_name VARCHAR(255) NOT NULL,
    nomination_start_datetime DATETIME NOT NULL,
    nomination_end_datetime DATETIME NOT NULL,
    scrutiny_list_datetime DATETIME NOT NULL,
    withdrawal_start_datetime DATETIME NOT NULL,
    withdrawal_end_datetime DATETIME NOT NULL,
    final_list_datetime DATETIME NOT NULL,
    campaign_start_date DATE NOT NULL,
    campaign_end_date DATE NOT NULL,
    polling_agents_datetime DATETIME NOT NULL,
    no_campaign_datetime DATETIME NOT NULL,
    polling_date DATE NOT NULL,
    polling_start_time TIME NOT NULL,
    polling_end_time TIME NOT NULL,
    results_datetime DATETIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE office_bearers (
    election_id INT NOT NULL,
    position VARCHAR(255) NOT NULL,
    PRIMARY KEY (election_id, position),
    FOREIGN KEY (election_id) REFERENCES elections(election_id)
);

CREATE TABLE school_boards_councillors (
    election_id INT NOT NULL,
    school_name VARCHAR(255) NOT NULL,
    num_board_members INT NOT NULL,
    num_councillors INT NOT NULL,
    PRIMARY KEY (election_id, school_name),
    FOREIGN KEY (election_id) REFERENCES elections(election_id)
);


use DESUG;
SELECT * FROM elections;
SELECT * FROM office_bearers;

drop table positions;
SELECT * FROM school_boards_councillors;

show tables;
select * from candidate_nomination;
show create table candidate_nomination;

select * from nomination_status;
show create table nomination_status;

show create table login;
select * from login;
ALTER TABLE "login"
DROP FOREIGN KEY "login_ibfk_1";

ALTER TABLE "login"
ADD COLUMN "type" ENUM('Student', 'Dean', 'Hod', 'ElectionChair') NOT NULL DEFAULT 'Student';

desc uploaded_files;

use DESUG;
select * from nomination_status;
select * from student;
select * from candidate_nomination;
select * from certification_data;
select * from uploaded_files;
show create table nomination_status;
show create table candidate_nomination;

update nomination_status set status = '4' where nomination_id = 32;

CREATE TABLE certification_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    registrationNumber VARCHAR(20),
    attendance ENUM('yes', 'no'),
    academicArrears ENUM('yes', 'no'),
    registeredPhd ENUM('yes', 'no'),
    courseRequirements ENUM('yes', 'no'),
    researchProgress ENUM('yes', 'no'),
    DRCReport ENUM('yes', 'no'),
    comments TEXT,
    dateCertification DATETIME,
    nominationId INT,
    FOREIGN KEY (registrationNumber) REFERENCES student(roll_number),
    FOREIGN KEY (nominationId) REFERENCES candidate_nomination(id)
);

update nomination_status set seconder_status = 'yes' where nomination_id = 39;

ALTER TABLE nomination_status
MODIFY status ENUM('1', '2', '3','3.5', '4','4.5', '5','5.5');

ALTER TABLE nomination_status
MODIFY proposer_status ENUM('yes', 'no') DEFAULT NULL,
MODIFY seconder_status ENUM('yes', 'no') DEFAULT NULL;

show tables;
select * from certification_data;
show create table certification_data;
ALTER TABLE certification_data CHANGE registeredPhd registeredStudent ENUM('yes', 'no') DEFAULT NULL;
update certification_data set registeredStudent = 'no' where id = 11;

delete from certification_data where id = 10;
delete from uploaded_files where nomination_id = 42;

use DESUG;
SELECT * FROM age_rule;
DROP TABLE age_rule;

SET SESSION sql_require_primary_key = OFF;
SET SESSION sql_require_primary_key = ON;

CREATE TABLE age_rule (
	election_id INT NOT NULL,
	academic_programme ENUM('UG', 'PG', 'Research') NOT NULL,
    minimum_age INT NOT NULL,
    maximum_age INT NOT NULL,
    FOREIGN KEY (election_id) REFERENCES elections (election_id)
);

INSERT INTO age_rule VALUES
(3, 'UG', 17, 22),
(3, 'PG', 17, 24),
(3, 'Research', 17, 28);

SELECT *  FROM candidate_nomination cn JOIN nomination_status ns ON cn.id = ns.nomination_id JOIN student s ON cn.registration_number = s.roll_number;