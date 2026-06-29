#【【数据库】SQL 3小时快速入门 #数据库教程 #SQL教程 #MySQL教程 #database#Python连接数据库】https://www.bilibili.com/video/BV1PT4y1e7UU?vd_source=3424baa0ba17a6687e097f58c68731c5
#
SHOW DATABASES;
CREATE DATABASE `sql_tutorial`;
CREATE DATABASE `database`;
DROP DATABASE `database`;
DROP DATABASE `sql_tutorial`;
USE `sql_tutorial`;

CREATE TABLE `student`(
	`student_id` INT PRIMARY KEY,
    `name` VARCHAR(20),
    `major` VARCHAR(20)
);

CREATE TABLE `student`(
	`student_id` INT ,
    `name` VARCHAR(20) NOT NULL,
    `major` VARCHAR(20) UNIQUE,
    PRIMARY KEY(`student_id`)
);

DESCRIBE `student`;
DROP TABLE `student`;

ALTER TABLE `student` ADD `gpa` DECIMAL(3,2);
ALTER TABLE `student` DROP COLUMN `gpa`;

SELECT * FROM `student`;

INSERT INTO `student` VALUES(1,'小白','历史');
INSERT INTO `student` VALUES(2,'小黑','生物');
INSERT INTO `student` VALUES(3,'小绿',NULL);
INSERT INTO `student` VALUES(3,'小蓝','英语');
INSERT INTO `student` (`name`,`major`,`student_id`) VALUES('小蓝','英语',4);
INSERT INTO `student` (`name`,`major`,`student_id`) VALUES('小蓝','英语',4);
INSERT INTO `student`(`major`,`student_id`) VALUES('英语',5);






DROP TABLE `student`;

CREATE TABLE `student`(
	`student_id` INT ,
    `name` VARCHAR(20) NOT NULL,
    `major` VARCHAR(20) UNIQUE,
    PRIMARY KEY(`student_id`)
);

CREATE TABLE `student`(
	`student_id` INT ,
    `name` VARCHAR(20) NOT NULL,
    `major` VARCHAR(20) UNIQUE DEFAULT '历史',
    PRIMARY KEY(`student_id`)
);

CREATE TABLE `student`(
	`student_id` INT AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL,
    `major` VARCHAR(20) DEFAULT '历史',
    PRIMARY KEY(`student_id`)
);

INSERT INTO `student` VALUES(1,NULL,'英语');
INSERT INTO `student` VALUES(1,'小白','英语');
INSERT INTO `student` VALUES(2,'小黑','英语');
INSERT INTO `student` VALUES(2,'小黑','历史');
INSERT INTO `student` VALUES(4,'小黑','历史');
INSERT INTO `student` VALUES(10,'小黑','历史');
INSERT INTO `student` VALUES(7,'小黑','历史');

INSERT INTO `student` VALUES(1,'小白');
INSERT INTO `student` (`student_id`,`name`) VALUES(1,'小白');

INSERT INTO `student` (`name`,`major`) VALUES('小白','英语');

INSERT INTO `student` (`name`,`major`) VALUES('小黑','英语');
INSERT INTO `student` (`name`,`major`) VALUES('小绿','英语');

INSERT INTO `student` (`student_id`, `name`) VALUES 
    (1, '小白'),
    (2, '小黑'),
    (3, '小红');

SELECT * FROM `student`;

-- 修改、删除资料
# 123
/* 123 */

DROP TABLE `student`;

DESCRIBE `student`;

SET SQL_SAFE_UPDATES=0; #关闭 workbench 预设的更新模式 

CREATE TABLE `student`(
	`student_id` INT PRIMARY KEY,
    `name` VARCHAR(20),
    `major` VARCHAR(20),
    `score` INT
);

INSERT INTO `student` (`student_id`,`name`,`major`,`score`) VALUES
	(1,'小白','英语',50),
    (2,'小黄','生物',90),
    (3,'小绿','历史',70),
    (4,'小蓝','英语',80),
    (5,'小黑','化学',20);

UPDATE `student`
SET  `major` = "英语文学"
WHERE `major` ="英语";

SELECT * FROM `student`;
