create database DESUG;

use DESUG;

CREATE TABLE student (
    roll_number CHAR(8) PRIMARY KEY,
    name VARCHAR(100),
    department ENUM('SLS', 'SEST', 'SoMS', 'SMS', 'SSS', 'SE', 'SH', 'SM&S', 'SCIS', 'SP.SC', 'SNS', 'CIS')
);

INSERT INTO Student (roll_number, name, department) VALUES
('21MCME01', 'stu1', 'SCIS'),
('21MCME02', 'stu2', 'SCIS'),
('21MCME03', 'stu3', 'SCIS'),
('21MCME04', 'stu4', 'SCIS'),
('21MCME05', 'stu5', 'SCIS'),
('21MCME06', 'stu6', 'SCIS'),
('21MCME07', 'stu7', 'SCIS'),
('21MCME08', 'stu8', 'SCIS'),
('21MCME09', 'stu9', 'SCIS'),
('21MCME10', 'stu10', 'SCIS'),
('21MCME11', 'stu11', 'SCIS'),
('21MCME12', 'stu12', 'SCIS'),
('21MCME13', 'stu13', 'SCIS'),
('21MCME14', 'stu14', 'SCIS'),
('21MCME15', 'stu15', 'SCIS'),
('21MCME16', 'stu16', 'SCIS'),
('21MCME17', 'stu17', 'SCIS'),
('21MCME18', 'stu18', 'SCIS'),
('21MCME19', 'stu19', 'SCIS'),
('21MCME20', 'stu20', 'SCIS');

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

-- Inserting nominees
INSERT INTO candidate (roll_number, election_position, manifesto, election_status, proposer, seconder) VALUES
('21MCME01', 'President', 'I promise to improve student facilities on campus.', 'Nominee', '21MCME05','21MCME06'),
('21MCME02', 'Vice President', 'I will focus on promoting student welfare initiatives.', 'Nominee', '21MCME07','21MCME08'),
('21MCME03', 'Treasurer', 'I pledge to manage funds transparently for the benefit of all.', 'Nominee', '21MCME09','21MCME10'),
('21MCME04', 'Secretary', 'I aim to enhance communication channels between students and faculty.', 'Nominee', '21MCME11','21MCME12');

-- Inserting a former candidate
INSERT INTO Candidate (roll_number, election_position, manifesto, election_status) VALUES
('21MCME05', 'Vice Treasurer', 'I will work towards financial transparency and accountability.', 'Former');

CREATE TABLE token (
	token_id VARCHAR(50) PRIMARY KEY,
    created_time DATETIME NOT NULL,
    status ENUM('Active', 'Used', 'Expired')
);

CREATE TABLE vote (

);