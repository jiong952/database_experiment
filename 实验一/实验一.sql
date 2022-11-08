-- 创建数据库
CREATE DATABASE SC;
USE SC;

-- 创建表
CREATE TABLE student (
  s_no char(10) PRIMARY KEY,-- 学号
  sname char(8) NOT NULL,-- 姓名
  sex char(2),-- 性别
  sbirthday datetime,-- 出生日期
  dno char(6),-- 学生所在院系编号
  spno char(8),-- 专业代码
  class_no char(4)-- 班级编号
);

CREATE TABLE Course (
  cno char(10) PRIMARY KEY,-- 课程编号
  cname char(20) NOT NULL,-- 课程名称
  spno char(8),-- 专业代码
  ctno tinyint,-- 课程类型编号
  lecture tinyint,-- 理论学时
  experiment tinyint,-- 理论学时
  semester tinyint,-- 理论学时
  credit tinyint-- 理论学时
);

CREATE TABLE student_course (
  s_no char(10),-- 学号
  tcid smallint,-- 上课编号
  score tinyint,-- 学生成绩
	PRIMARY KEY (`s_no`,`tcid`)
);

CREATE TABLE teacher (
  t_no char(8) PRIMARY KEY,-- 教室编号
  t_name char(8) NOT NULL,-- 教师姓名
  t_sex char(2),-- 性别
  t_birthday datetime,-- 出生日期
  dno char(6),-- 教师所在院系编号
  tech_title char(10)-- 职称
);

CREATE TABLE department (
  dno char(6) PRIMARY KEY,-- 院系编号
  dept_name char(20) NOT NULL,-- 院系名称
  header char(8)-- 院系负责人
);

CREATE TABLE speciality (
  spno char(8) PRIMARY KEY,-- 专业代码
  dno char(6) NOT NULL,-- 院系编号
  spname char(20) NOT NULL-- 专业名称
);

CREATE TABLE teacher_course (
  tcid smallint PRIMARY KEY,-- 上课编号
  t_no char(8),-- 教师编号
  spno char(8),-- 专业代码
  class_no char(4),-- 班级编码
  cno char(10) NOT NULL,-- 课程编号
  semester char(6),-- 学期
  schoolyear char(10)-- 学年
);

CREATE TABLE class (
  spno char(8), -- 专业代码
  class_no char(4), -- 班级编码
  header char(8) ,-- 班负责人 
	PRIMARY KEY (`spno`,`class_no`)
);

-- 添加外键
ALTER TABLE class
  ADD CONSTRAINT `class_ibk_1` FOREIGN KEY (`spno`) REFERENCES `speciality` (`spno`);

ALTER TABLE course
  ADD CONSTRAINT `Course_ibk_1` FOREIGN KEY (`spno`) REFERENCES `speciality` (`spno`);
	
ALTER TABLE speciality
  ADD CONSTRAINT `speciality_ibk_1` FOREIGN KEY (`dno`) REFERENCES `department` (`dno`);
	
ALTER TABLE student
  ADD CONSTRAINT `student_ibk_1` FOREIGN KEY (`dno`) REFERENCES `department` (`dno`),
  ADD CONSTRAINT `student_ibk_2` FOREIGN KEY (`spno`) REFERENCES `speciality` (`spno`);
	
ALTER TABLE student_course
  ADD CONSTRAINT `student _course_ibk_1` 
	FOREIGN KEY (`s_no`) 
	REFERENCES `student` (`s_no`) 
	ON DELETE CASCADE;

ALTER TABLE teacher
  ADD CONSTRAINT `teacher_ibk_1` FOREIGN KEY (`dno`) REFERENCES `department` (`dno`);
	
ALTER TABLE teacher_course
  ADD CONSTRAINT `teacher_course_ibk_1` FOREIGN KEY (`t_no`) REFERENCES `teacher` (`t_no`),
  ADD CONSTRAINT `teacher_course_ibk_2` FOREIGN KEY (`spno`) REFERENCES `speciality` (`spno`),
  ADD CONSTRAINT `teacher_course_ibk_3` FOREIGN KEY (`cno`) REFERENCES `course` (`cno`);
	
	
-- 插入数据
INSERT into sc.department VALUES 
			('00001','计算机学院','张三'),
			('00002','自动化学院','李四'),
			('00003','外国语学院','王五'),
			('00004','物理学院','赵四'),
			('00005','土木学院','张五'),
			('00006','光电学院','小刘')

INSERT into sc.teacher VALUES
			('00000001','张老师','男','2002-10-13','00001','教授'),
			('00000002','俊老师','女','2001-10-13','00001','副教授'),
			('00000003','鸿老师','男','2003-10-13','00001','讲师'),
			('00000004','章老师','女','2004-10-13','00001','讲师'),
			('00000005','骏老师','男','2005-10-13','00001','教授'),
			('00000006','红老师','女','2006-10-13','00001','副教授')

INSERT into sc.speciality VALUES
			('11111111','00001','计科'),
			('11111112','00001','网工'),
			('11111113','00001','信安'),
			('11111114','00001','软工'),
			('11111115','00001','人工智能')

INSERT into sc.course VALUES
			('00001','毛概','11111111',1,48,0,1,6),
			('00002','软件工程','11111111',2,40,0,1,3),
			('00003','数据库系统','11111111',3,48,24,1,3),
			('00004','信息安全概论','11111111',4,32,0,1,3),
			('00005','工程管理','11111111',5,24,0,1,1)

INSERT into sc.student VALUES
			('3120005043','张俊鸿','男','2002-10-13','00001','11111111','3'),
			('2120005043','张俊白','女','2003-10-13','00001','11111111','3'),
			('4120005043','张俊红','男','2004-10-13','00001','11111111','3'),
			('5120005043','张俊绿','男','2005-10-13','00001','11111111','3'),
			('6120005043','张俊黑','女','2006-10-13','00001','11111111','3')

INSERT into sc.`student_course` VALUES
			('3120005043',1,98),
			('3120005043',2,99),
			('3120005043',3,97),
			('3120005043',4,96),
			('3120005043',5,95)
			
INSERT into sc.class VALUES
			('11111111','3','张俊鸿'),
			('11111112','4','张俊白'),
			('11111113','6','张俊红'),
			('11111114','7','张俊绿'),
			('11111115','8','张俊黑')

INSERT into sc.teacher_course VALUES
			(1,'00000001','11111111','3','00001','001','0001'),
			(2,'00000002','11111111','3','00002','002','0002'),
			(3,'00000001','11111111','3','00003','003','0003'),
			(4,'00000004','11111111','3','00004','004','0004'),
			(5,'00000001','11111111','3','00005','005','0005')
			
-- 修改数据
UPDATE sc.student SET sname='张俊粉' WHERE s_no = '6120005043';
	
-- 删除数据
DELETE FROM sc.student WHERE s_no = '6120005043';
	