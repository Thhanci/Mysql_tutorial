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

UPDATE `student`
SET  `major` = "生物"
WHERE `student_id`=3;

UPDATE `student`
SET  `major` = "生化"
WHERE `major`='生物' OR `major`='化学';

UPDATE `student`
SET  `major` = "生化"
WHERE `major` IN ('生物','化学');

UPDATE `student`
SET  `name`='小灰',`major`='物理'
WHERE `student_id`=1;

UPDATE `student`
SET  `major`='物理';

DELETE FROM `student`
WHERE `student_id` =4;

DELETE FROM `student`
WHERE `name`='小灰' AND `major`='物理';

DELETE FROM `student`
WHERE `name`='小灰' AND `major`='物理';

DELETE FROM `student`
WHERE `score`<60;  --   <>不等于  >=大于等于

DELETE FROM `student`;

SELECT * FROM `student`;

-- 取得资料

DROP TABLE `student`;
DESCRIBE `student`;
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE `student`(
	`student_id` INT PRIMARY KEY,
    `name` VARCHAR(20),
    `major` VARCHAR(20),
    `score` INT
);

INSERT INTO `student` (`student_id`,`name`,`major`,`score`) VALUES
	(1,'小白','英语',20),
    (2,'小黑','历史',60),
    (3,'小绿','生物',20),
    (4,'小蓝','英语',90),
    (5,'小黄','化学',70);

SELECT * FROM `student`;
SELECT `name` FROM `student`;
SELECT `name`,`major` FROM `student`;  # `反括号

SELECT *
FROM `student`
ORDER BY `score` DESC;#descend  ascend 默认ascend

SELECT *
FROM `student`
ORDER BY `score` ASC;

SELECT *
FROM `student`
ORDER BY `score`,`student_id`;

SELECT *
FROM `student`
ORDER BY `score`,`student_id`
LIMIT 2;

SELECT *
FROM `student`
ORDER BY `score` DESC
LIMIT 3;

SELECT *
FROM `student`
WHERE `major`='英语' AND `student_id`=1;

SELECT *
FROM `student`
WHERE `major`='英语' OR `score`>20;

SELECT *
FROM `student`
WHERE `major`='英语' OR `score`<>70;

SELECT *
FROM `student`
WHERE `major` in ('英语','历史','生物');

SELECT *
FROM `student`
WHERE `major`='英语' OR `major`='历史' OR `major`='生物';

-- 创建公司资料库表格


#review
DROP TABLE `student`;
DESCRIBE `student`;
CREATE TABLE `student`(
	`student_id` INT PRIMARY KEY,
    `name` VARCHAR(20),
    `major` VARCHAR(20),
    `score` INT UNIQUE NOT NULL
);
SELECT * FROM `student`;
SHOW DATABASES;

#Tip
USE `sql_tutorial`;
SHOW VARIABLES LIKE 'auto_increment_increment';
SET auto_increment_increment =3;
SET auto_increment_increment =1;
CREATE TABLE `students`(
	`student_id` INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(50)
)AUTO_INCREMENT=200;
INSERT INTO `students`(`student_id`,`name`) VALUES(001,'张三');
INSERT INTO `students`(`name`) VALUES('张三');
INSERT INTO `students`(`name`) VALUES('张三');
INSERT INTO `students`(`name`) VALUES('张三');
DESCRIBE `students`;
SELECT * FROM `students`;
DROP TABLE `students`;
-- 创建公司资料库表格
DROP TABLE `student`;
CREATE TABLE `employee`(
	`emp_id` INT PRIMARY KEY,
    `name` VARCHAR(20),
    `birth_date` DATE,
    `sex` VARCHAR(1),
    `salary` INT,
    `branch_id` INT,
    `sup_id` INT
);
CREATE TABLE `branch`(
	`branch_id` INT PRIMARY KEY,
    `branch_name` VARCHAR(20),
    `manager_id` INT,
    FOREIGN KEY(`manager_id`) REFERENCES `employee`(`emp_id`) ON DELETE SET NULL
);

ALTER TABLE `employee` 
ADD FOREIGN KEY (`branch_id`)
REFERENCES `branch`(`branch_id`)
ON DELETE SET  NULL;

ALTER TABLE `employee`
ADD FOREIGN KEY (`sup_id`)
REFERENCES `employee`(`emp_id`)
ON DELETE SET NULL;

CREATE TABLE `client`(
	`client_id` INT PRIMARY KEY,
    `client_name` VARCHAR(20),
    `phone` VARCHAR(20)
);

CREATE TABLE `Works_With`(
	`emp_id` INT,
    `client_id` INT,
    `total_sales`INT,  
     PRIMARY KEY (`emp_id`,`client_id`),
     FOREIGN KEY (`emp_id`) REFERENCES `employee`(`emp_Id`) ON DELETE CASCADE,
     FOREIGN KEY (`client_id`) REFERENCES `client`(`client_Id`) ON DELETE CASCADE
);

INSERT INTO `branch` VALUES(1,'研发',NULL);
INSERT INTO `branch` VALUES(2,'行政',NULL);
INSERT INTO `branch` VALUES(3,'资讯',NULL);

INSERT INTO `employee` VALUES(206,'小黄','1998-10-08','F',50000,1,NULL);
INSERT INTO `employee` VALUES(207,'小绿','1995-09-08','M',29000,2,206);
INSERT INTO `employee` VALUES(208,'小黑','2000-12-19','M',35000,3,206);
INSERT INTO `employee` VALUES(209,'小白','1997-01-22','F',39000,3,207);
INSERT INTO `employee` VALUES(210,'小兰','1925-11-10','F',84000,1,207);

UPDATE `branch`
SET `manager_id`=206
WHERE `branch_id`=1;

UPDATE `branch`
SET `manager_id`=207
WHERE `branch_id`=2;

UPDATE `branch`
SET `manager_id`=208
WHERE `branch_id`=3;

INSERT INTO `client` VALUES(400,'阿狗','254354335');
INSERT INTO `client` VALUES(401,'阿猫','25633899');
INSERT INTO `client` VALUES(402,'旺财','45354345');
INSERT INTO `client` VALUES(403,'露西','54354365');
INSERT INTO `client` VALUES(404,'艾瑞克','18783783');

INSERT INTO `works_with` VALUES(206, 400, '70000');
INSERT INTO `works_with` VALUES(207, 401, '24000');
INSERT INTO `works_with` VALUES(208, 402, '9800');
INSERT INTO `works_with` VALUES(208, 403, '24000');
INSERT INTO `works_with` VALUES(210, 404, '87940');

#test
SHOW DATABASES;
USE `sql_tutorial`;
SHOW TABLES;
SELECT * FROM `employee`;
SELECT * FROM `branch`;
SELECT * FROM `client`;
SELECT * FROM `works_with`;

-- 练习

-- 1. 取得所有员工资料
SELECT * FROM `employee`;
-- 2. 取得所有客户资料
SELECT * FROM `client`;
-- 3. 按薪水低到高取得员工资料
SELECT * FROM `employee` ORDER BY `salary`;
SELECT * FROM `employee` ORDER BY `salary` DESC;
SELECT * FROM `employee` ORDER BY `salary` ASC;
SELECT * FROM `employee` ORDER BY `sex`;
#TIP:
# INSERT INTO VALUES		DELETE FROM WHERE 	DROP TABLE DATABASE			ALTER TABLE ADD DECIMAL  
# ALTER TABLE DROP COLUMN		UPDATE SET WHERE		SELECT * FROM  ORDER BY LIMIT
#SHOW DATABASES; DESCRIBE `TABLE`;  SHOW TABLES; USE `DATABASE`;SHOW VARIABLES LIKE ''; SET  = ;
-- 4. 取得薪水前3高的员工
SELECT *
FROM `employee`
ORDER BY `salary` DESC
LIMIT 3;

-- 5. 取得所有员工的名称
SELECT `name` FROM `employee`;
SELECT `sex` FROM `employee`;
SELECT DISTINCT `sex` FROM `employee`;
SELECT DISTINCT `branch_id` FROM `employee`;

/*
#test:
SELECT * FROM `employee`;
SELECT * FROM `client`;
SELECT * FROM `employee` ORDER BY `salary` ASC;
SELECT * FROM `employee` ORDER BY `salary` DESC LIMIT 3;
SELECT DISTINCT `name` FROM `employee`;
*/

-- aggregate functions 聚合函数

-- 1. 取得员工人数
SELECT COUNT(*) FROM `employee`;
SELECT COUNT(`sup_id`) FROM `employee`;
-- 2. 取得所有出生于 1970-01-01 之后的女性员工人数
SELECT COUNT(*)
FROM `employee`
WHERE `birth_date`>'1970-01-01' AND `sex` ='F';
-- 3. 取得所有员工的平均薪水
SELECT AVG (`salary`) FROM `employee`;
-- 4. 取得所有员工薪水的总和
SELECT SUM(`salary`) FROM `employee`;
-- 5. 取得薪水最高的员工
SELECT MAX(`salary`) FROM `employee`;

SELECT `name` FROM `employee`
WHERE `salary` = (SELECT MAX(`salary`) FROM `employee`);

SELECT `name` FROM `employee`
ORDER BY `salary` DESC
LIMIT 1;
-- 6. 取得薪水最低的员工
SELECT MIN(`salary`) FROM `employee`;

SELECT * FROM `client`;

-- wildcards 万用字元    % 代表多个字元，    _ 代表一个字符
-- 1. 取得电话号码尾数是335的客户
SELECT *
FROM `client`
WHERE `phone` LIKE '%335';

SELECT *
FROM `client`
WHERE `phone` LIKE '254%';

SELECT *
FROM `client`
WHERE `phone` LIKE '%354%';
-- 2. 取得姓艾的客户
SELECT *
FROM `client`
WHERE `client_name` LIKE '艾%';
-- 3. 取得生日在12月的员工
SELECT *
FROM `employee`
WHERE `birth_date` LIKE '_____12%';

SELECT *
FROM `employee`
WHERE `birth_date` LIKE '_____09%';

-- union 联集 并集
-- 1. 员工名字 union 客户名字
SELECT `name`
FROM `employee`
UNION
SELECT `client_name`
FROM `client`;

SELECT `name`
FROM `employee`
UNION
SELECT `client_name`
FROM `client`
UNION
SELECT `branch_name`
FROM `branch`;

SELECT `emp_id`,`name`
FROM `employee`
UNION
SELECT `client_id`,`Client_name`
FROM `Client`
ORDER BY `emp_id`
LIMIT 9;

-- 2. 员工id + 员工名字 union 客户id + 客户名字
SELECT `emp_id` AS `total_id`,`name` AS `total_name`
FROM `employee`
UNION
SELECT `client_id`,`client_name`
FROM `client`;

-- 3. 员工薪水 union 销售金额
SELECT `salary` AS `total_money`
FROM `employee`
UNION
SELECT `total_sales`
FROM `works_with`;

-- 左右并排（加列）
#JOIN   两张表有共同字段 emp_id，所以可以左右拼接：
SELECT `salary`, `total_sales`
FROM `employee` JOIN `works_with` 
ON     `employee`.`emp_id`    =    `works_with`.`emp_id`   ;

SELECT `salary`, `total_sales`
FROM `employee` JOIN `works_with` 
ON     `employee`.`emp_id`    =    `works_with`.`emp_id`   ;
#把 employee 表和 works_with 表通过 emp_id 这个字段"粘"在一起，形成左右并排的一张新表。
-- 强行左右拼，没有任何关联条件 CROSS JOIN（笛卡尔积）
SELECT `salary`, `phone`
FROM `employee`
CROSS JOIN client;


EXPLAIN

SELECT NOW() FROM DUAL;
/*
 * ============================================================
 * MySQL DUAL 虚拟表
 * ============================================================
 * 
 * DUAL 是什么？
 *   一个虚拟表，用于在不查询任何真实表时占位。
 *
 * 为什么需要 DUAL？
 *   SELECT 语句必须有 FROM 子句
 *   不想查表时，用 DUAL 占位
 *
 * 正确用法：
 *   -- 查表
 *   SELECT * FROM employee;
 *
 *   -- 不查表（用 DUAL 占位）
 *   SELECT 1 + 1 FROM DUAL;        -- 结果：2
 *   SELECT NOW() FROM DUAL;        -- 当前时间
 *   SELECT 'Hello' FROM DUAL;      -- 字符串
 *
 * MySQL 特性：
 *   MySQL 中可以直接省略 FROM DUAL
 *   但 Oracle 等数据库必须写
 *
 * 一句话：DUAL 就是一个假表，让你可以执行不查表的 SELECT 语句。
 * ============================================================
 */
 
 
 -- join 连接
 INSERT INTO `branch` VALUES(4,'偷懒',NULL);
 -- 取得所有部门经理的名字
SELECT *
FROM `employee`
JOIN `branch`
ON `emp_id` = `manager_id`;
 
SELECT *
FROM `employee` JOIN `branch`
ON `emp_id` = `manager_id`;
 
SELECT `employee`.`emp_id`,`employee`.`name`,`branch`.`branch_name`
FROM `employee` JOIN `branch`
ON `employee`.`emp_id` =`branch`.`manager_id`;

SELECT `employee`.`emp_id`,`employee`.`name`,`branch`.`branch_name`
FROM `employee` LEFT JOIN `branch`
ON `employee`.`emp_id` =`branch`.`manager_id`;

SELECT `employee`.`emp_id`,`employee`.`name`,`branch`.`branch_name`
FROM `employee` RIGHT JOIN `branch`
ON `employee`.`emp_id` =`branch`.`manager_id`;

-- subquery 子查询
-- 1. 找出研发部门的经理名字
SELECT `name`
FROM `employee`
WHERE `emp_id`=(
	SELECT `manager_id`
	FROM `branch`
	WHERE `branch_name`='研发'
);
-- 2. 找出对单一位客户销售金额超过50000的员工名字

SELECT  `name`
FROM `employee`
WHERE `emp_id`=(
	SELECT `emp_id`
	FROM `works_with`
	WHERE `total_sales`> 50000
    LIMIT 1
);

SELECT  `name`
FROM `employee`
WHERE `emp_id` IN(
	SELECT `emp_id`
	FROM `works_with`
	WHERE `total_sales`> 50000
    LIMIT 1
);


#外键 FOREIGN KEY不能SET NULL
#ON DELETE CASCADE 删除时，把整条删掉
#ON DELETE SET NULL 删除时，只把该值设置为NULL

DELETE FROM `employee`
WHERE `emp_id`=207;

SELECT *
FROM `branch`;

SELECT *
FROM `works_with`;


 
 