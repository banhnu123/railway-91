DROP DATABASE IF EXISTS assignment_01;
CREATE DATABASE assignment_01;
USE assignment_01;

-- Tạo bảng department
DROP TABLE IF EXISTS department;
CREATE TABLE department(
	department_id INT AUTO_INCREMENT,
    department_name VARCHAR(50),
    PRIMARY KEY(department_id)
);
-- Tạo bảng position
DROP TABLE IF EXISTS position;
CREATE TABLE `position`(
	position_id INT AUTO_INCREMENT,
	position_name ENUM('DEV', 'TEST', 'Scrum master', 'PM') UNIQUE NOT NULL,
    PRIMARY KEY(position_id)
	
);

CREATE TABLE account (
	account_id INT AUTO_INCREMENT,
    email VARCHAR(50) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    full_name VARCHAR(50) NOT NULL,
    department_id INT,
    position_id INT,
    create_date DATE NOT NULL DEFAULT(CURRENT_DATE),
    PRIMARY KEY (account_id),
    FOREIGN KEY (department_id) REFERENCES department (department_id),
    FOREIGN KEY (position_id) REFERENCES position (position_id)
);
CREATE TABLE `group` (
    group_id INT PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(50) UNIQUE NOT NULL,
    creator_id INT,
    create_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    FOREIGN KEY (creator_id) REFERENCES account (account_id) 
    ON DELETE CASCADE
);

CREATE TABLE group_account (
    group_id INT,
    account_id INT,
    join_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (group_id, account_id),
    FOREIGN KEY (group_id) REFERENCES `group` (group_id)
    ON DELETE CASCADE,
    FOREIGN KEY (account_id) REFERENCES account (account_id)
    ON DELETE CASCADE
);
CREATE TABLE type_question(
type_id INT AUTO_INCREMENT,
type_name ENUM("Essay", "Multiple-Choice") UNIQUE NOT NULL,
PRIMARY KEY (type_id)
);

CREATE TABLE category_question(
category_id INT AUTO_INCREMENT,
category_name VARCHAR(50) UNIQUE NOT NULL,
PRIMARY KEY (category_id)
);

CREATE TABLE question(
question_id INT AUTO_INCREMENT,
content VARCHAR(50) UNIQUE NOT NULL,
category_id INT,
type_id INT,
creator_id INT,
create_date DATE NOT NULL DEFAULT(CURRENT_DATE),
PRIMARY KEY (question_id),
	FOREIGN KEY (creator_id) REFERENCES account (account_id),
	FOREIGN KEY (type_id) REFERENCES type_question (type_id),
	FOREIGN KEY (category_id) REFERENCES category_question (category_id)
);

CREATE TABLE answer(
answer_id INT AUTO_INCREMENT,
content VARCHAR(50) NOT NULL,
question_id INT,
is_correct BOOLEAN NOT NULL,
PRIMARY KEY (answer_id),
 FOREIGN KEY (question_id) REFERENCES question (question_id)
);
	
CREATE TABLE exam(
exam_id INT AUTO_INCREMENT,
code CHAR(10) UNIQUE NOT NULL,
title VARCHAR(50) UNIQUE NOT NULL,
category_id INT,
duration INT NOT NULL,
creator_id INT,
create_date DATE NOT NULL DEFAULT(CURRENT_DATE),
PRIMARY KEY (EXAM_ID),
FOREIGN KEY (category_id) REFERENCES category_question (account_id),
FOREIGN KEY (creator_id) REFERENCES account (account_id)
);

CREATE TABLE exam_question(
exam_id INT,
question_id INT,
PRIMARY KEY(exam_id, question_id),
FOREIGN KEY (exam_id) REFERENCES exam (exam_id),
FOREIGN KEY (question_id) REFERENCES question (question_id)
);
