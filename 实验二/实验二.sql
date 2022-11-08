-- 普通查询
SELECT s_no,sname,sex,sbirthday FROM sc.student
SELECT s_no,sname,TIMESTAMPDIFF(YEAR,sc.student.sbirthday,CURDATE())AS 'sage' FROM sc.student
SELECT s_no,sname,sex,sbirthday FROM sc.student WHERE dno = '00001'; -- 注00001即为计算机学院
SELECT s_no,sname,sbirthday FROM sc.student WHERE spno='11111111' AND class_no = '3'
-- 注计科专业编码为11111111 班级为3班

SELECT s_no,sname,sex,sbirthday FROM sc.student WHERE dno = '00001' AND sbirthday >'1983-01-10'
-- 注00001即为计算机学院
SELECT s_no,sname,sex,sbirthday FROM sc.student ORDER BY sbirthday

-- 连接查询
SELECT s_no,sname,sex,dept_name,spname 
FROM student,department,speciality
WHERE student.dno = department.dno AND student.spno = speciality.spno

SELECT student.s_no,sname,spname,score
FROM student,speciality,student_course
WHERE student.spno = speciality.spno AND cno = '00001'

-- 事先修改几个不及格数据
SELECT student.s_no,sname,cname
FROM student,course,student_course
WHERE student_course.cno=course.cno AND student_course.s_no =student.s_no AND score < 60

-- 嵌套查询
SELECT s_no,sname
FROM
	student
WHERE
	NOT EXISTS (
		SELECT *
		FROM
			student_course,course
		WHERE
			student.s_no = student_course.s_no AND student_course.cno = course.cno
		AND course.cname = '毛概'
	)

SELECT s_no,sname
FROM
	student
WHERE
	s_no IN(
	SELECT s_no 
	FROM student_course 
	GROUP BY s_no
	HAVING MIN(score) > 80)

USE northwind;
SELECT * FROM 
SELECT * FROM products WHERE Price < 20;
SELECT MAX(price) FROM products;
--  查询所有被订购过得 Products 的 ProductsID 和 ProductName；

SELECT products.ProductID,ProductName
FROM products,orderdetails
WHERE products.ProductID = orderdetails.ProductID;

SELECT products.ProductID,ProductName
FROM orders,customers,orderdetails,products
WHERE customers.CustomerID = 'AROUT' AND 
			customers.CustomerID = orders.CustomerID
			AND orders.OrderID = orderdetails.OrderID
			AND products.ProductID = orderdetails.ProductID;

SELECT products.ProductID,ProductName
FROM orders,customers,orderdetails,products
WHERE customers.CustomerID = 'AROUT' AND 
			customers.CustomerID = orders.CustomerID
			AND orders.OrderID = orderdetails.OrderID
			AND products.ProductID = orderdetails.ProductID
			AND Price > 20;

SELECT * FROM products 
WHERE Price = (
	SELECT MAX(price) FROM products);


