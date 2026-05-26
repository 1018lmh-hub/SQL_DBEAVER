SELECT 
    a.table_name AS "외래키를_쓰는_테이블(자식)", 
    a.constraint_name AS "찾아낸_외래키_이름" -- 외래키 이름은 여기서 확인하세요!
FROM 
    user_constraints a
JOIN 
    user_constraints b ON a.r_constraint_name = b.constraint_name
WHERE 
    b.constraint_type IN ('P', 'U') 
    AND b.table_name = 'MEMBER'; -- 대문자로 입력해주세요!
    
SELECT * FROM SAVE;

DROP TABLE SAVE;

SELECT * FROM MEMBER;
SELECT * FROM BOARD;

-- 나중에 만들 때는 테이블 관계를 좀 더 잘 생각해보자
-- 관계를 잘 생각하면 좋을듯, 1:1, N:M, 1:N
-- 나무 생각하면 좀 편한듯 
-- 부모의 PK를 참조해서 자식이 외래키로 사용
--(일반 컬럼에 외래키 넣으면 1:N, 
--PK컬럼에 외래키 넣으면 1:1-> 근데 PK컬럼 말고 따로 유니크 제약 조건 넣어서 외래키로 넣으면 유지보수에 좋음 같은 걸 굳이 왜 2개나 넣나 했는데 
--PK는 수정이 굉장히 어려워서 나중에 1:1에서 1:N으로 바꾸고 싶으면 쉽지 않아짐
--두 부모의 PK를 자식테이블의 두 컬럼에 외래키로 넣고 본인의 PK를 따로 만듦 N:M)

-- 식별 관계는 자제하도록 비식별 관계가 좋음
-- 복합키도 쓸 수는 있는데 그렇게 자주 나오진 않을듯?
-- 그러면 1:1에서는 식별관계일 때 단일키이고 1:N이나 N:M에서는 식별관계면 복합키가 되겠네

-- 반드시 가져야하고 부모테이블에서 존재하지 않으면 자식 테이블에서 만들 수 없음
-- 부모 PK를 외래키로 사용하고 이를 본인의 PK로 사용함
-- 이거시 식별관계 끈끈하다잉



CREATE TABLE GALLERY(
  GALLERY_NO NUMBER PRIMARY KEY,
  GALLERY_TITLE VARCHAR2(100) NOT NULL,
  GALLERY_WRITER VARCHAR2(30) NOT NULL,
  GALLERY_CONTENT VARCHAR2(4000) NOT NULL,
  COUNT NUMBER DEFAULT 0,
  CREATE_DATE DATE DEFAULT SYSDATE,
  STATUS VARCHAR2(1) DEFAULT 'Y' CHECK (STATUS IN ('Y', 'N')),
  FOREIGN KEY (GALLERY_WRITER) REFERENCES MEMBER(USER_ID) ON DELETE CASCADE
);

CREATE TABLE GAL_FILE(
  FILE_NO NUMBER PRIMARY KEY,
  GALLERY_NO NUMBER NOT NULL,
  ORIGIN_NAME VARCHAR2(100) NOT NULL,
  CHANGE_NAME VARCHAR2(100) NOT NULL,
  FOREIGN KEY (GALLERY_NO) REFERENCES GALLERY(GALLERY_NO) ON DELETE CASCADE
);

CREATE SEQUENCE SEQ_GNO NOCACHE;
CREATE SEQUENCE SEQ_FNO NOCACHE;

SELECT * FROM GALLERY;
SELECT * FROM GAL_FILE;

		SELECT
 		       GALLERY_NO
 		     , GALLERY_TITLE
 		     , GALLERY_WRITER
 		     , COUNT
 		     , TO_CHAR(CREATE_DATE, 'YYYY-MM-DD') as createDate
 		     , CHANGE_NAME     
   		  FROM
 		       GALLERY
		  LEFT
 		  JOIN
 		       GAL_FILE USING (GALLERY_NO)
 		 WHERE
 		       STATUS='Y'
 		 ORDER
 		    BY
 		       GALLERY_NO DESC;








