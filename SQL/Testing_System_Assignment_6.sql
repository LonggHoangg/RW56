DROP DATABASE IF EXISTS `Testing_System_Assignment_1`;
CREATE DATABASE `Testing_System_Assignment_1`;
USE `Testing_System_Assignment_1`;


DROP TABLE IF EXISTS `Department`;
CREATE TABLE `Department`(
	DepartmentID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	DepartmentName NVARCHAR(50) NOT NULL UNIQUE KEY
);

DROP TABLE IF EXISTS `Position`;
CREATE TABLE `Position`(
	PositionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	PositionName  ENUM('Dev','Test','Scrum Master','PM') NOT NULL UNIQUE KEY
    );
 
 
 DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
    AccountID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email NVARCHAR(50) NOT NULL UNIQUE KEY,
    Username NVARCHAR(100) NOT NULL UNIQUE KEY,
    Fullname NVARCHAR(50) NOT NULL,
    DepartmentID TINYINT UNSIGNED NOT NULL,
    PositionID TINYINT UNSIGNED NOT NULL,
	CreateDate DATETIME DEFAULT NOW(),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
	FOREIGN KEY (PositionID) REFERENCES `Position`(PositionID)
    );
    
DROP TABLE IF EXISTS  `Group`; 
CREATE TABLE `Group`(
		GroupID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		GroupName NVARCHAR(50) NOT NULL UNIQUE KEY,
		CreatorID TINYINT UNSIGNED NOT NULL,
		CreateDate DATETIME DEFAULT NOW(),
       FOREIGN KEY(CreatorID) REFERENCES `Account`(AccountID)
	);
    
DROP TABLE IF EXISTS `GroupAccount`;   
CREATE TABLE `GroupAccount`(
		GroupID TINYINT UNSIGNED NOT NULL,
        AccountID TINYINT UNSIGNED NOT NULL,
		JoinDate DATETIME DEFAULT NOW(),
        PRIMARY KEY(GroupID,AccountID),
        FOREIGN KEY(GroupID) REFERENCES `Group`(GroupID),
        FOREIGN KEY(AccountID) REFERENCES `Account`(AccountID)
	);
    
DROP TABLE IF EXISTS `TypeQuestion`;   
CREATE TABLE `TypeQuestion`(
		TypeID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		TypeName ENUM('Essay','Multiple-Choice')
		);
        
DROP TABLE IF EXISTS `CategoryQuestion`;           
CREATE TABLE `CategoryQuestion`(
		CategoryID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		CategoryName NVARCHAR(50) NOT NULL UNIQUE KEY
   );
   
DROP TABLE IF EXISTS `Question`;  
CREATE TABLE `Question`(
		QuestionID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
		Content  NVARCHAR(50) NOT NULL UNIQUE KEY,
		CategoryID TINYINT UNSIGNED NOT NULL,
		TypeID TINYINT UNSIGNED NOT NULL,
		CreatorID TINYINT UNSIGNED NOT NULL,
		CreateDate DATETIME DEFAULT NOW(),
        FOREIGN KEY(CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
        FOREIGN KEY (TypeID) REFERENCES `TypeQuestion`(TypeID),
        FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
        );
        
DROP TABLE IF EXISTS `Answer`;      
CREATE TABLE `Answer`(
	  AnswerID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	  Content  NVARCHAR(50) NOT NULL ,
	  QuestionID TINYINT UNSIGNED NOT NULL,
	  isCorrect BIT DEFAULT 1,
      FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID)
);

DROP TABLE IF EXISTS `Exam`;
CREATE TABLE `Exam`(
	ExamID  TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`Code`  CHAR(10) NOT NULL,
	Title NVARCHAR(50) NOT NULL ,
	CategoryID TINYINT UNSIGNED NOT NULL,
	Duration TINYINT UNSIGNED NOT NULL,
	CreatorID TINYINT UNSIGNED NOT NULL,
    CreateDate DATETIME DEFAULT NOW(),
	FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
	FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)
);

DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE `ExamQuestion`(
	ExamID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	QuestionID TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (ExamID) REFERENCES `Exam`(ExamID) ON DELETE CASCADE ,
    
    FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID) ON DELETE CASCADE ); 
    
INSERT INTO `Department`
	(DepartmentName)
VALUE
	('San Xuat'),
	('Nhan su'),
	('Bao Tri'),
	('Marketing'),
	('Ke Hoach'),
    ('Quan He Cong Chung'),
    ('Hanh Chinh'),
    ('Sale'),
    ('Thu Mua'),
    ('R&D');
    

INSERT INTO `Position`
	(PositionName)
VALUES
	('Dev'),
	('Test'),
	('Scrum Master'),
	('PM');

INSERT INTO `Account`
	(Email,Username,FullName,DepartmentID,PositionID,CreateDate)
VALUES 
	('email1@gmail.com','Username1','Duong Hao',1,3,'2022-07-12'),
	('email2@gmail.com','Username2','Nguyen Van',1,4,'2012-08-11'),
	('email3@gmail.com','Username3','Hoang Duc',4,1,'2018-07-17'),
	('email4@gmail.com','Username4','Tran Duc Nguyen',5,2,'2019-07-19'),
	('email5@gmail.com','Username5','Phan Minh Duc',3,4,'2017-07-10'),
    ('email6@gmail.com','Username8','Nguyen Minh',2,3,'2017-07-10'),
    ('email7@gmail.com','Username7','Pham Tuan',7,1,'2017-07-10'),
    ('email8@gmail.com','Username6','Duan No',10,2,'2017-07-10'),
    ('email9@gmail.com','Username10','Hoa Van',1,4,'2017-07-10'),
    ('email10@gmail.com','Username9','Trinh Nguyen',1,1,'2017-07-10');

INSERT INTO `Group`
	(GroupName,CreatorID,CreateDate)
VALUES
	('GroupName1',2,'2011-07-04'),
	('GroupName2',1,'2021-06-04'),
	('GroupName3',3,'2018-02-12'),
	('GroupName4',5,'2021-07-15'),
	('GroupName5',4,'2019-05-19'),
    ('GroupName7',7,'2019-12-22'),
    ('GroupName8',6,'2013-07-15'),
    ('GroupName10',8,'2015-07-15'),
    ('GroupName6',10,'2020-07-15'),
    ('GroupName9',9,'2022-07-15');

INSERT INTO `GroupAccount`
	(GroupID,AccountID,JoinDate)
VALUES
	(4,1,'2012-11-15'),
	(5,2,'2021-01-10'),
	(1,5,'2018-11-11'),
	(2,4,'2015-11-08'),
	(3,3,'2010-12-05'),
    (6,9,'2019-11-08'),
    (8,3,'2016-11-08'),
    (7,10,'2021-11-08'),
    (10,6,'2011-11-08'),
    (9,7,'2022-11-08');

INSERT INTO `TypeQuestion`
	(TypeName)
VALUES
	('Essay'),
	('Multiple-Choice');

INSERT INTO `CategoryQuestion`
	(CategoryName)
VALUES
	('Java'),
	('.NET'),
	('SQL'),
	('Postman'),
	('Ruby');

INSERT INTO `Question`
	(Content,CategoryID,TypeID,CreatorID,CreateDate)
VALUES
	('Câu Hỏi 1',2,1,3,'2012-07-12'),
	('Content 2',2,2,2,'2015-05-10'),
	('Content 1',4,1,4,'2011-08-17'),
	('Content 4',1,2,5,'2008-06-12'),
	('Câu Hỏi 2',5,2,1,'2019-02-17'),
	('Content 7',1,1,10,'2021-06-12'),
    ('Content 8',3,2,9,'2016-06-12'),
    ('Content 3',4,1,8,'2011-06-12'),
    ('Content 10',5,1,7,'2022-09-22'),
    ('Câu Hỏi 11',2,2,6,'2022-09-12');
   

    
INSERT INTO `Answer`
	(Content,QuestionID,isCorrect)
VALUES
	('Content1',2,1),
	('Content2',3,0),
	('Content3',2,0),
	('Content4',4,1),
	('Content5',5,1),
    ('Content6',7,1),
    ('Content7',8,0),
    ('Content8',6,1),
    ('Content9',10,0),
    ('Content10',9,1);

INSERT INTO `Exam`
	(`Code`,Title,CategoryID,Duration,CreatorID,CreateDate)
VALUES
	('1A','Title1',5,75,5,'2015-08-09'),
	('1B','Title2',3,50,4,'2022-08-09'),
	('1C','Title3',1,90,3,'2021-08-10'),
	('1D','Title4',2,30,1,'2022-08-15'),
	('1E','Title5',4,60,2,'2022-07-09'),
    ('1F','Title6',5,100,7,'2022-09-21'),
    ('1G','Title7',1,45,8,'2011-08-15'),
    ('1H','Title8',1,100,9,'2012-08-15'),
    ('1I','Title9',3,15,10,'2017-08-15'),
    ('1K','Title10',4,60,6,'2022-09-15');

INSERT INTO `ExamQuestion`
	(ExamID,QuestionID)
VALUES
	(2,1),
	(1,2),
	(3,4),
	(4,5),
	(5,1),
    (7,8),
    (8,9),
    (9,5),
    (6,7),
    (10,6);
    
    
   /* Question 1 Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các
account thuộc phòng ban đó */
	
   DROP PROCEDURE IF EXISTS  get_account_name;
   DELIMITER $$
   CREATE PROCEDURE get_account_name (IN in_dep_name NVARCHAR(50))
		BEGIN
			SELECT A.AccountID, A.Fullname, D.DepartmentName
            FROM 	`Department` AS D
            JOIN  	`Account` AS A
            ON  D.DepartmentID = A.DepartmentID 
           WHERE D.DepartmentName = in_dep_name;
        END $$
   DELIMITER ;
 CALL get_account_name ('San Xuat');	
 CALL get_account_name  ('Thu Mua');
        
        
   -- Question 2: Tạo store để in ra số lượng account trong mỗi group
   
DROP PROCEDURE IF EXISTS get_count_account;
DELIMITER $$
CREATE PROCEDURE get_count_account( IN TEN_GROUP NVARCHAR(50))
	BEGIN 
		SELECT G.GroupName, COUNT(GroupName) AS SO_LUONG
        FROM  `Group` G
        JOIN  `Account` A
        ON  G.CreatorID = A.AccountID
		WHERE G.GroupName = TEN_GROUP
        GROUP BY GroupName
        ORDER BY GroupName;
	END $$
 DELIMITER ; 
CALL get_count_account('GroupName5');
CALL get_count_account('GroupName7');


/*Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
trong tháng hiện tại */

DROP PROCEDURE IF EXISTS count_question;
DELIMITER $$
CREATE PROCEDURE count_question()
	BEGIN
		SELECT T.TypeName , COUNT(T.TypeName) AS COUNT 
        FROM `TypeQuestion` T
		JOIN  `Question` Q
        ON T.TypeID = Q.TypeID
        WHERE Month(Q.CreateDate) = month(now()) AND YEAR(Q.CreateDate) = YEAR(NOW())
        
        GROUP BY Q.TypeID;
        
	END $$
DELIMITER ; 
CALL count_question();


/*Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất */
DROP PROCEDURE IF EXISTS max_type_question;
DELIMITER $$
CREATE PROCEDURE max_type_question()
	BEGIN
		SELECT T.TypeID, COUNT(T.TypeID) AS COUNT
        FROM `TypeQuestion` T
		JOIN `Question` Q
        ON T.TypeID = Q.TypeID        
        GROUP BY T.TypeName
        HAVING COUNT(T.TypeID) = (SELECT MAX(COUNTTYPE) FROM  
        (SELECT COUNT(QUES.TypeID) AS COUNTTYPE FROM `Question` AS QUES
        GROUP BY QUES.TypeID) AS COUNT_MAX)        
        ORDER BY T.TypeName ;                
	END $$
DELIMITER ;
CALL max_type_question();

		
  /* Question 5: Sử dụng store ở question 4 để tìm ra tên của type question CHUA XONG */  
  
DROP PROCEDURE IF EXISTS type_question_name;
DELIMITER $$
CREATE PROCEDURE type_question_name()
	BEGIN
    SELECT MTQ.TypeID, TY.TypeName
    FROM max_type_question AS TMQ
    JOIN `TypeQuestion` AS TY
    ON TMQ.TypeID = TY.TypeID
    ;
    END $$
DELIMITER ;
CALL type_question_name();



 /* Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
chuỗi của người dùng nhập vào*/



/* Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
trong store sẽ tự động gán:
	- username sẽ giống email nhưng bỏ phần @..mail đi
	- positionID: sẽ có default là developer
	- departmentID: sẽ được cho vào 1 phòng chờ
Sau đó in ra kết quả tạo thành công   CHUA XONG */


DROP PROCEDURE IF  EXISTS FULLNAME_MAIL ;
DELIMITER $$
CREATE PROCEDURE FULLNAME_MAIL (IN NHAP_FULLNAME NVARCHAR(50)
 IN NHAP_EMAIL NVARCHAR(50))
	BEGIN
		SELECT A. Fullname, A. Username , A.PositionID , A.DepartmentID
        FROM `Account` A ;
        WHERE A. Fullname = NHAP_FULLNAME
        
	END;
DELIMITER ;
CALL FULLNAME_MAIL('Fullname1','Email1@gmail.com');
        


/* Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất CHUA XONG*/

DROP PROCEDURE IF EXISTS THONG_KE ;
DELIMITER $$
CREATE PROCEDURE THONG_KE(IN TYPE_NAME NVARCHAR(50))
	BEGIN 
		SELECT T.TypeName , LENGTH(Q.Content) AS MAX_LENGHT
        FROM `TypeQuestion` T
        JOIN `Question` Q
        ON T.TypeID = Q.TypeID
        WHERE T.TypeName = TYPE_NAME 
        GROUP BY T.TypeName
        HAVING LENGTH(Q.Content) = (SELECT MAX(LENGTH(Content)) FROM `Question`)
       ;
	END $$
DELIMITER ;
CALL THONG_KE('Essay');
                

/* Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID */ 

DROP PROCEDURE IF EXISTS DELETE_EXAM ;
DELIMITER $$
CREATE PROCEDURE DELETE_EXAM( IN EXAM_ID  TINYINT UNSIGNED)
	BEGIN
    	DELETE FROM `Exam`
        WHERE ExamID = EXAM_ID ;
        
	END $$
DELIMITER ;
CALL DELETE_EXAM ('1');







        
        
        
    
    