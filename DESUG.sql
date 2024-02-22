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

INSERT INTO Student (roll_number, name, department, student_type) VALUES
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

INSERT INTO Student (roll_number, name, department, student_type) VALUES
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

CREATE TABLE candidate (
    roll_number CHAR(8) PRIMARY KEY,
    election_position VARCHAR(100),
    manifesto TEXT,
    election_status ENUM('Nominee', 'Won', 'Lost', 'Former'),
    proposer char(8),
    seconder char(8),
    UNIQUE (roll_number),
    UNIQUE (proposer),
    UNIQUE (seconder),
    FOREIGN KEY (roll_number) REFERENCES student(roll_number),
    FOREIGN KEY (proposer) REFERENCES student(roll_number),
    FOREIGN KEY (seconder) REFERENCES student(roll_number),
    CHECK (roll_number <> proposer AND roll_number <> seconder AND proposer <> seconder)
);

INSERT INTO candidate (roll_number, election_position, manifesto, election_status, proposer, seconder) VALUES
('21MCME01', 'President', 'I promise to improve student facilities on campus.', 'Nominee', '21MCME05','21MCME06'),
('21MCME02', 'Vice President', 'I will focus on promoting student welfare initiatives.', 'Nominee', '21MCME07','21MCME08'),
('21MCME03', 'Sports Secretary', 'I pledge to manage funds transparently for the benefit of all.', 'Nominee', '21MCME09','21MCME10'),
('21MCME04', 'General Secretary', 'I aim to enhance communication channels between students and faculty.', 'Nominee', '21MCME11','21MCME12');

INSERT INTO candidate (roll_number, election_position, manifesto, election_status, proposer, seconder) VALUES
('20MCME01', 'Cultural Secretary', 'I promise to improve student facilities on campus.', 'Nominee', '20MCME05','20MCME06'),
('20MCME02', 'Vice President', 'I will focus on promoting student welfare initiatives.', 'Nominee', '20MCME07','20MCME08'),
('20MCME03', 'Sports Secretary', 'I pledge to manage funds transparently for the benefit of all.', 'Nominee', '20MCME09','20MCME10'),
('20MCME04', 'Joint Secretary', 'I aim to enhance communication channels between students and faculty.', 'Nominee', '20MCME11','20MCME12');

INSERT INTO candidate (roll_number, election_position, manifesto, election_status, proposer, seconder) VALUES
('19MCME01', 'President', 'I promise to improve student facilities on campus.', 'Nominee', '19MCME05','19MCME06'),
('19MCME02', 'Vice President', 'I will focus on promoting student welfare initiatives.', 'Nominee', '19MCME07','19MCME08'),
('19MCME03', 'Sports Secretary', 'I pledge to manage funds transparently for the benefit of all.', 'Nominee', '19MCME09','19MCME10'),
('19MCME04', 'Joint Secretary', 'I aim to enhance communication channels between students and faculty.', 'Nominee', '19MCME11','19MCME12');

INSERT INTO candidate (roll_number, election_position, manifesto, election_status, proposer, seconder) VALUES
('22MCMT01', 'Cultural Secretary', 'I promise to improve student facilities on campus.', 'Nominee', '22MCMT05','22MCMT06'),
('22MCMT02', 'General Secretary', 'I will focus on promoting student welfare initiatives.', 'Nominee', '22MCMT07','22MCMT08'),
('22MCMT03', 'Cultural Secretary', 'I pledge to manage funds transparently for the benefit of all.', 'Nominee', '22MCMT09','22MCMT10');

INSERT INTO candidate (roll_number, election_position, manifesto, election_status, proposer, seconder) VALUES
('23MCMT01', 'General Secretary', 'I promise to improve student facilities on campus.', 'Nominee', '23MCMT05','23MCMT06'),
('23MCMT02', 'Cultural Secretary', 'I will focus on promoting student welfare initiatives.', 'Nominee', '23MCMT07','23MCMT08'),
('23MCMT03', 'General Secretary', 'I pledge to manage funds transparently for the benefit of all.', 'Nominee', '23MCMT09','23MCMT10');

CREATE TABLE token (
	token_id CHAR(12) PRIMARY KEY,
    created_time DATETIME NOT NULL,
    status ENUM('Active', 'Used', 'Expired') DEFAULT 'Active'
);

SELECT * FROM token;

CREATE TABLE vote (
	token_id VARCHAR(50) PRIMARY KEY
);