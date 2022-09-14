/* Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale*/

DROP VIEW IF EXISTS SALE_FULLNAME ;
CREATE OR REPLACE VIEW SALE_FULL_NAME AS 
SELECT A.Fullname , D.DepartmentName
FROM `Account` A
JOIN  `Department` D
ON A.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Sale'
;

/* Question 2: Tạo /* view có chứa thông tin các account tham gia vào nhiều group nhất
 */
DROP VIEW IF EXISTS ACCOUNT_INFOR ;
CREATE OR REPLACE VIEW ACCOUNT_INFOR AS

SELECT A.* , COUNT(G. AccountID) AS COUNT
FROM  `Account` A
JOIN `GroupAccount` G
ON A.AccountID = G.AccountID

GROUP BY G.AccountID
HAVING COUNT(G. AccountID) = (SELECT MAX(COUNT_A) FROM 
(SELECT COUNT(GRO.AccountID) AS COUNT_A FROM `GroupAccount` GRO GROUP BY GRO.AccountID) AS ACCO)
;

/* Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ
được coi là quá dài) và xóa nó đi*/

DROP VIEW IF EXISTS LONG_CONTENT ;
CREATE OR REPLACE VIEW LONG_CONTENT AS
SELECT Q.Content, LENGTH(Q.Content) AS LENGHT FROM `Question` AS Q
WHERE LENGTH(Q.Content) >= 20 ;

 DELETE FROM  `Question` AS Q
 WHERE LENGTH(Q.Content) >= 20 ;

/* Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất */

DROP VIEW IF EXISTS MAX_COUNT_NAME;

CREATE OR REPLACE VIEW MAX_COUNT_NAME AS
SELECT D.DepartmentName , COUNT(D.DepartmentID) AS COUNT
FROM `Department` D
JOIN `Account` A
ON A.DepartmentID = D.DepartmentID

GROUP BY A.DepartmentID
HAVING COUNT(D.DepartmentID) = (SELECT MAX(COUNT_ID) FROM 
(SELECT COUNT(AC.DepartmentID) AS COUNT_ID FROM `Account` AC GROUP BY AC.DepartmentID) AS ACC)

ORDER BY D.DepartmentID;


/* Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo */

DROP VIEW IF EXISTS V_NGUYEN;

CREATE OR REPLACE VIEW V_NGUYEN AS
SELECT  A.Fullname , Q.Content
FROM `Account` A
JOIN  `Question` Q
ON A.AccountId = Q.CreatorID

WHERE lower(LEFT(TRIM(A.Fullname),6)) = 'nguyen'
; 



