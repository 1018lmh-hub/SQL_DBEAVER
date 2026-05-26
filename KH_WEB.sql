
-- 여기에 들어갈 값이 어떤 값인가 생각

-- 회원번호 -- 1, 2, 3 ...

-- 사용자에게 입력받는 값
-- 아이디 -- USER01, USER02, USER03 ...
-- 비밀번호 -- PASS01, PASS01, PASS01 ...
-- 이름 -- 홍길동, 고길동, 둘리
-- 이메일 -- KH@kh.com, kh@naver.com, kh@daum.com
-- 사용자에게 입력받는 값
 
-- 가입일 -- SYSDATE
-- 회원정보수정일 -- SYSDATE
-- 삭제여부 -- 'Y' / 'N'

CREATE TABLE WEB_MEMBER(
	USER_NO NUMBER PRIMARY KEY,
	USER_ID VARCHAR2(30) UNIQUE NOT NULL,
	USER_PWD VARCHAR2(30) NOT NULL,
	USER_NAME NVARCHAR2(20) NOT NULL,
	EMAIL VARCHAR2(30) NOT NULL,
	ENROLL_DATE DATE DEFAULT SYSDATE,
	MODIFY_DATE DATE DEFAULT SYSDATE,
	STATUS CHAR(1) DEFAULT 'N' CHECK(STATUS IN('Y', 'N'))
);


CREATE SEQUENCE SEQ_MEM_NO NOCACHE;

SELECT * FROM WEB_MEMBER;
INSERT INTO WEB_MEMBER
VALUES (SEQ_MEMBER_NO.NEXTVAL,
		'admin',
		'1234',
		'관리자',
		'admin@kh.com',
		SYSDATE,
		SYSDATE,
		'N');
----------------------------------------------------------------

CREATE TABLE WEB_BOARD(
	BOARD_NO NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	USER_NO NUMBER REFERENCES WEB_MEMBER,
	BOARD_TITLE NVARCHAR2(50) NOT NULL,
	BOARD_CONTENT NVARCHAR2(2000) NOT NULL,
	CREATE_DATE DATE DEFAULT SYSDATE,
	MODIFY_DATE DATE DEFAULT SYSDATE,
	COUNT NUMBER DEFAULT 0,
	STATUS CHAR(1) DEFAULT 'N' CHECK(STATUS IN ('Y', 'N'))	
);

SELECT * FROM WEB_BOARD;


SELECT 
       BOARD_NO, 
       BOARD_TITLE,
       ROWNUM
  FROM (SELECT 
		       BOARD_NO, 
		       BOARD_TITLE,
		       ROWNUM
		  FROM 
		       WEB_BOARD
		 ORDER 
		    BY
		       CREATE_DATE DESC)
 WHERE 
       ROWNUM BETWEEN 1 AND 3;

SELECT BOARD_NO, BOARD_TITLE, RNUM
FROM (
	SELECT 
	       BOARD_NO, 
	       BOARD_TITLE,
	       ROWNUM RNUM
	  FROM (SELECT 
			       BOARD_NO, 
			       BOARD_TITLE,
			       ROWNUM
			  FROM 
			       WEB_BOARD
			 ORDER 
			    BY
			       CREATE_DATE DESC))
 WHERE 
       RNUM BETWEEN 4 AND 6;

SELECT 
       BOARD_NO
     , BOARD_TITLE
  FROM
       WEB_BOARD
 ORDER 
    BY  
       CREATE_DATE DESC
OFFSET 
       3 ROWS FETCH NEXT 3 ROWS ONLY;
-- 12버전 이상에서는 OFFSET문법 사용 가능, 위 숫자는 INDEX랑 거기서부터 수





INSERT 
  INTO
       WEB_BOARD
       (
       USER_NO, 
       BOARD_TITLE, 
       BOARD_CONTENT
       )
VALUES
  	   (22, '첫 글입니다.', '안녕하세요~');

INSERT 
  INTO
       WEB_BOARD
       (
       USER_NO, 
       BOARD_TITLE, 
       BOARD_CONTENT
       )
VALUES
	   (3, '야호 글입니다.', '안녕하세요~');

INSERT 
  INTO
       WEB_BOARD
       (
       USER_NO, 
       BOARD_TITLE, 
       BOARD_CONTENT
       )
VALUES
	   (1, ' 으하하 글입니다.', '반갑습니다~');

INSERT 
  INTO
       WEB_BOARD
       (
       USER_NO, 
       BOARD_TITLE, 
       BOARD_CONTENT
       )
VALUES
 	   (3, '깔깔쓰 글입니다.', '안녕하세요~');

INSERT 
  INTO
       WEB_BOARD
       (
       USER_NO, 
       BOARD_TITLE, 
       BOARD_CONTENT
       )
VALUES 
       (3, '몇번째 글입니다.', '반갑습니다~');

INSERT 
  INTO
       WEB_BOARD
       (
       USER_NO, 
       BOARD_TITLE, 
       BOARD_CONTENT
       )
VALUES
       (22, '글입니다.', '안녕하세요~');

INSERT 
  INTO
       WEB_BOARD
       (
       USER_NO, 
       BOARD_TITLE, 
       BOARD_CONTENT
       )
VALUES
	   (3, '오잉 글입니다.', '안녕하세요~');

INSERT 
  INTO
       WEB_BOARD
       (
       USER_NO, 
       BOARD_TITLE, 
       BOARD_CONTENT
       )
VALUES
	   (3, '므이? 글입니다.', '안녕하세요~');

INSERT 
  INTO
       WEB_BOARD
       (
       USER_NO, 
       BOARD_TITLE, 
       BOARD_CONTENT
       )
VALUES
	   (1, '싫어 글입니다.', '안녕하세요~');

INSERT 
  INTO
       WEB_BOARD
       (
       USER_NO, 
       BOARD_TITLE, 
       BOARD_CONTENT
       )
VALUES
	   (1, '뭐지 글입니다.', '안녕하세요~');

INSERT 
  INTO
       WEB_BOARD
       (
       USER_NO, 
       BOARD_TITLE, 
       BOARD_CONTENT
       )
VALUES
	   (1, '그정돈가 글입니다.', '안녕하세요~');




--------------------------------------------------

CREATE TABLE WEB_ATTACHMENT(
	FILE_NO NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	REF_BNO NUMBER NOT NULL,
	ORIGIN_NAME VARCHAR2(100) NOT NULL,
	CHANGE_NAME VARCHAR2(50) NOT NULL,
	FILE_PATH VARCHAR2(100) NOT NULL,
	BOARD_TYPE CHAR(1) NOT NULL,
	FILE_LEVEL NUMBER NOT NULL,
	CREATE_DATE DATE DEFAULT SYSDATE);

SELECT * FROM WEB_ATTACHMENT;


SELECT MAX(BOARD_NO) FROM WEB_BOARD;


SELECT  
       BOARD_NO
  FROM 
       (SELECT 
       		   BOARD_NO
          FROM  
               WEB_BOARD
         ORDER
            BY
               BOARD_NO DESC)
WHERE 
      ROWNUM = 1;
              
-----------------------------------------

CREATE TABLE WEB_IMAGE_BOARD(
	BOARD_NO NUMBER PRIMARY KEY,
	BOARD_TITLE NVARCHAR2(100) NOT NULL,
	BOARD_CONTENT NVARCHAR2(2000) NOT NULL,
	BOARD_WRITER NUMBER REFERENCES WEB_MEMBER, 
	CREATE_DATE DATE DEFAULT SYSDATE,
	STATUS CHAR(1) DEFAULT 'N' CHECK(STATUS IN('Y', 'N'))
);

CREATE SEQUENCE SEQ_IMAGE NOCACHE;

SELECT * FROM WEB_IMAGE_BOARD;

 		SELECT
 		       BOARD_NO
 		     , BOARD_TITLE
 		     , WEB_IMAGE_BOARD.CREATE_DATE
 		     , FILE_PATH
 		     , CHANGE_NAME
 		 FROM
 		       WEB_IMAGE_BOARD
 		  JOIN
 		       WEB_ATTACHMENT ON (BOARD_NO = REF_BNO)
 		WHERE
 		      BOARD_TYPE ='I'
 		  AND 
 		      STATUS='N'
 		ORDER
 		   BY
 		      BOARD_NO DESC
	
-----------------------------------------------------------
 		      
 	CREATE TABLE WEB_REPLY(
 		REPLY_NO NUMBER PRIMARY KEY,
 		REF_BNO NUMBER NOT NULL REFERENCES WEB_BOARD,
 		REPLY_WRITER NUMBER NOT NULL REFERENCES WEB_MEMBER,
 		REPLY_CONTENT NVARCHAR2(1000) NOT NULL,
 		CREATE_DATE DATE DEFAULT SYSDATE,
 		STATUS CHAR(1) DEFAULT 'N' CHECK(STATUS IN ('Y', 'N'))
 	);
 	
 	CREATE SEQUENCE SEQ_REPLY NOCACHE;

 	

























