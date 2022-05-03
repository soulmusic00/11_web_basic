/*


	# 제약 조건
	
		- NOT NULL : NULL 금지
		- UNIQUE : 중복값입력 금지(NULL은가능)
		- PRIMARY KEY(PK) : 
							테이블에 유일하게 구분되는 키로 주 식별자, 주키 등으로 불린다.
							PRIMARY KEY는 유일한 값이기 때문에 중복된 값을 가질 수 없다.
							기본 키에 입력되는 값은 중복될 수 없으며, NULL 값이 입력될 수 없다.
							PRIMARY KEY 제약 조건을 설정하면, 해당 필드는 NOT NULL과 UNIQUE 제약 조건의 특징을 모두 가진다.
							
		 - FOREIGN KEY(FK)  :
							한 테이블과 참조되는 다른 테이블 간의 연결되는 Primary Key Column을 Foreign Key라 한다.	
							테이블들을 연결해주는 역할을 한다.
							FOREIGN KEY 는 참조관계의 기본 키와 같은 속성을 가진다.
							FOREIGN KEY 는 외부 테이블에서 참고하려는 주 키 (primary key) 를 의미한다.
							외부키, 참조키, 외부 식별자 등으로 불린다.
							'외래 키 테이블'에 데이터를 입력할 때는 꼭 '기준 테이블'을 참조해서 입력하므로 반드시 '기준 테이블'에 존재하는 데이터만 입력이 가능하다.
							'외래 키 테이블'이 참조하는 '기준 테이블'의 열은 반드시 PK이거나 UNIQUE 제약 조건이 설정되어 있어야 한다.
		
        [ 형식 ]
	
		  (CONSTRAINT [CONSTRAINT_NAME]생략가능) FOREIGN KEY (자식 테이블 컬럼 명) REFERENCES 참조테이블(부모 테이블 기본키명) 
		  ON UPDATE 옵션 ON DELETE 옵션
		  
            - 옵션 상세
          
			 CASCADE     : 참조되는 테이블에서 데이터를 삭제하거나 수정하면 참조하는 테이블에서도 삭제와 수정이 같이 이루어짐
			 SET NULL    : 참조되는 테이블에서 데이터를 삭제하거나 수정하면 참조하는 테이블의 데이터는 NULL로 변경됨
			 NO ACTION   : 참조되는 테이블에서 데이터를 삭제하거나 수정하면 참조하는 테이블의 데이터는 변경되지 않음
			 SET DEFAULT : 참조되는 테이블에서 데이터를 삭제하거나 수정하면 참조하는 테이블의 데이터는  필드의 기본값으로 설정
			 RESTRICT    : 참조하는 테이블에 데이터가 남아 있으면 참조되는 테이블의 데이터를 삭제하거나 수정할 수 없음

*/

# 제약사항 예시
CREATE TABLE T_SHOPPING_GOODS (
	GOODS_ID 	 INT 			AUTO_INCREMENT PRIMARY KEY,
    GOODS_TITLE  VARCHAR(50)	UNIQUE,
    GOODS_WRITER VARCHAR(50),
    GOODS_PRICE  INT			NOT NULL	
);

INSERT INTO
		T_SHOPPING_GOODS
VALUES
		(1 , '쉽게배우는 데이터통신' , '박기현' , 19000); # OK


INSERT INTO
		T_SHOPPING_GOODS 
VALUES
		('컴퓨터 활용 능력' , '이주희' , 30000); # ERROR (컬럼 개수 불일치)


INSERT INTO
		T_SHOPPING_GOODS (GOODS_TITLE , GOODS_WRITER , GOODS_PRICE)
VALUES
		('컴퓨터 활용 능력' , '이주희' , 30000); # OK


INSERT INTO
		T_SHOPPING_GOODS (GOODS_TITLE , GOODS_WRITER , GOODS_PRICE)
VALUES
		('컴퓨터 활용 능력' , '이주희친구' , 25000); # ERROR (UNIQUE 제약 위반)
        

INSERT INTO
		T_SHOPPING_GOODS (GOODS_TITLE , GOODS_PRICE)
VALUES
		('아무튼 외국어1' , 22000);   # OK
 
 
INSERT INTO
		T_SHOPPING_GOODS (GOODS_TITLE , GOODS_WRITER)
VALUES
		('아무튼 외국어2' , '조지영');   # ERROR (NOT NULL 제약 위반)
 
SELECT * FROM T_SHOPPING_GOODS;


# 메인키와 참조키를 사용하지 않았을 경우의 예시
CREATE TABLE T_CLASS1 (
	CLASS_ID VARCHAR(10),
    CLASS_NAME VARCHAR(10)
);
CREATE TABLE T_STUDENT1 (
	STUDENT_ID   INT,
    STUDENT_NAME VARCHAR(10),
    CLASS_ID 	 VARCHAR(10)
);

INSERT INTO T_CLASS1 VALUES("C1" , "DBMS");
INSERT INTO T_CLASS1 VALUES("C2" , "FRONT END");
INSERT INTO T_CLASS1 VALUES("C3" , "BACK END");

INSERT INTO T_STUDENT1 VALUES(1 , "팀버너스리" , "C1");
INSERT INTO T_STUDENT1 VALUES(2 , "제임스고슬링" , "C2");
INSERT INTO T_STUDENT1 VALUES(3 , "데니스리치" , "C3");
INSERT INTO T_STUDENT1 VALUES(4 , "빌게이츠" , "C4");
INSERT INTO T_STUDENT1 VALUES(5 , "스티브잡스" , "C5");

SELECT * FROM T_STUDENT1;
SELECT * FROM T_CLASS1;

UPDATE
		T_CLASS1
SET
		CLASS_ID = 'C100'
WHERE
		CLASS_ID = 'C1'; # 성공

DELETE FROM
		T_CLASS1
WHERE
		CLASS_ID = 'C2'; # 성공


# 메인키와 참조키 설정 예시
CREATE TABLE T_CLASS2 (
	CLASS_ID VARCHAR(10) PRIMARY KEY,					 # 메인키 설정
    CLASS_NAME VARCHAR(10)
);

CREATE TABLE T_STUDENT2 (
	STUDENT_ID   INT PRIMARY KEY,
    STUDENT_NAME VARCHAR(10),
    CLASS_ID 	 VARCHAR(10) ,
    FOREIGN KEY (CLASS_ID) REFERENCES T_CLASS2(CLASS_ID) # 참조키 설정
);

INSERT INTO T_CLASS2 VALUES("C1" , "DBMS");
INSERT INTO T_CLASS2 VALUES("C2" , "FRONT END");
INSERT INTO T_CLASS2 VALUES("C3" , "BACK END");

INSERT INTO T_STUDENT2 VALUES(1 , "팀버너스리" , "C1");
INSERT INTO T_STUDENT2 VALUES(2 , "제임스고슬링" , "C2");
INSERT INTO T_STUDENT2 VALUES(3 , "데니스리치" , "C3");
INSERT INTO T_STUDENT2 VALUES(4 , "빌게이츠" , "C4");   # 키 참조 제약 위반 (메인키에 없는 데이터)
INSERT INTO T_STUDENT2 VALUES(5 , "스티브잡스" , "C5"); # 키 참조 제약 위반 (메인키에 없는 데이터)

SELECT * FROM T_STUDENT2;
SELECT * FROM T_CLASS2;

UPDATE
		T_CLASS2
SET
		CLASS_ID = 'C100'
WHERE
		CLASS_ID = 'C1'; # 참조키가 있을경우 메인키의 데이터만 수정 불가

DELETE FROM
		T_CLASS2
WHERE
		CLASS_ID = 'C2'; # 참조키가 있을경우 메인키의 데이터만 삭제 불가



# 참조키 옵션 적용 예시
CREATE TABLE T_CLASS3 (
	CLASS_ID VARCHAR(10) PRIMARY KEY,					 # 메인키 설정
    CLASS_NAME VARCHAR(10)
);

CREATE TABLE T_STUDENT3 (
	STUDENT_ID   INT PRIMARY KEY,
    STUDENT_NAME VARCHAR(10),
    CLASS_ID 	 VARCHAR(10) ,
    FOREIGN KEY (CLASS_ID) REFERENCES T_CLASS3(CLASS_ID) # 참조키 설정
    ON UPDATE CASCADE # 메인키의 값이 수정될 경우 참조키의 값도 같이 수정
    ON DELETE CASCADE # 메인키의 값이 삭제될 경우 참조키의 값도 같이 삭제
);

INSERT INTO T_CLASS3 VALUES("C1" , "DBMS");
INSERT INTO T_CLASS3 VALUES("C2" , "FRONT END");
INSERT INTO T_CLASS3 VALUES("C3" , "BACK END");

INSERT INTO T_STUDENT3 VALUES(1 , "팀버너스리" , "C1");
INSERT INTO T_STUDENT3 VALUES(2 , "제임스고슬링" , "C2");
INSERT INTO T_STUDENT3 VALUES(3 , "데니스리치" , "C3");
INSERT INTO T_STUDENT3 VALUES(4 , "빌게이츠" , "C4");   # 키 참조 제약 위반 (메인키에 없는 데이터)
INSERT INTO T_STUDENT3 VALUES(5 , "스티브잡스" , "C5"); # 키 참조 제약 위반 (메인키에 없는 데이터)


SELECT * FROM T_STUDENT3;
SELECT * FROM T_CLASS3;

UPDATE
		T_CLASS3
SET
		CLASS_ID = 'C100'
WHERE
		CLASS_ID = 'C1'; # 메인키의 값과 참조키의 값이 동시에 수정

DELETE FROM
		T_CLASS3
WHERE
		CLASS_ID = 'C2'; # 메인키의 값과 참조키의 값이 동시에 삭제













