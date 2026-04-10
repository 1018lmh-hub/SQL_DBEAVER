/*
 * DML 값을 수정함
 * DDL 구조를 수정함
 * 
 *  < DDL (Data Definition Language) >
 *  데의터 정의 언어
 *  객체(테이블, 사용자, 함수, 뷰, 시퀀스, 프로시저, 인덱스...)를
 *  생성(CREATE), 변경(ALTER), 삭제(DROP) 하는 구문
 *
 * 주의 DDL은 자동 COMMIT 됨 + ROLLBAKC 불가
 *  
 */

-- < CREATE TABLE> --
/*
 * CREATE TABLE 테이블명 (
 * 	  컬럼명 자료형(크기),
 *    컬럼명 자료형 (크기),
 *    ...
 * );
 * 
 * <자료형>
 * -문자자료형 / 숫자자료형 / 날짜자료형
 * -CHAR(크기) : 고정 길이 문자(최대 2000BYTE)
 * -VARCHAR2(크기) : 가변 길이 문자(최대 4000BYTE)
 * -NVARCHAR2(크기) : 가변 길이 문자 글자수로 체크(최대 4000BYTE)
 * 
 * --CLOB, NCLOB : 대용량 텍스트를 저장해야한다.
 * -NUMBER : 숫자(정수/실수)
 * -DATE : 날짜
 * -TIMESTAMP
 * 
 * 
 * 
 */

-- 진료기록 테이블 만들기
CREATE TABLE MEDICAL_RECORD(
	RECORD_ID CHAR(5),
	ANIMAL_BNO CHAR(3),
	CHECK_DATE DATE,
	DOCTOR_NAME NVARCHAR2(21),
	TREATMENT NVARCHAR2(500)
);

SELECT * FROM MEDICAL_RECORD;

INSERT INTO MEDICAL_RECORD
VALUES('R0001', 'A01', SYSDATE, '홍길동', '영양제투여');

INSERT INTO MEDICAL_RECORD
VALUES(NULL, NULL, SYSDATE, '고길동', '영양제투여');

INSERT INTO MEDICAL_RECORD
VALUES('R0001', NULL, SYSDATE, '홍길동', '영양제투여');

INSERT INTO MEDICAL_RECORD
VALUES('R0002', 'ABC' ,SYSDATE, '홍길동', NULL);

-----------------------------------------------------
--< 제약조건 CONSTRAINT >--

/*
 * 데이터의 무결성을 보장하기 위한 조건
 * 
 * -NOT NULL : NULL값을 허용하지 않음
 * - UNIQUE : 중복값을 허용하지 않음
 * - CHECK : 지정한 조건에 맞는 값만 사용
 * - PRIMARY KEY : 각 행을 식별하기 위한 식별컬럼(NOT NULL, UNIQUE), 
 *   테이블 당 하나만 선언됨 두개의 컬럼을 묶어서 세트로 식별해 사용은 가능
 *   EX) 홍길동 고길동 이렇게 구분하거나 홍길동 1 홍길동 2 고길동 1 고길동 2 <- 다 다른거임, 3개 이상은 되나
 * - FOREIGN KEY : 다른 테이블의 컬럼값만 허용, 
 * - 형태를 제한하는 건 없나 영어 숫자 숫자 이런 식으로라던가 - 되긴하는데 굳이?
 *   FOREIGN KEY 이거도 체크랑 서브쿼리로 안되려나- 안됨 체크로 가능은 한데 새롭게 추가될 수도 있으니까
 * 
 */

--컬럼의 기본값을 지정하는 구문 : DEFAULT

--엔티티 관계도 연결

/*
 * 좋아요 기능을 구현할 때
 * 
 * 누가
 * 무엇을
 */

SELECT ANIMAL_ID FROM ANIMAL;


SELECT * FROM MEDICAL_RECORD;
DROP TABLE MEDICAL_RECORD;

CREATE TABLE MEDICAL_RECORD(
	RECORD_ID CHAR(5) PRIMARY KEY,
	ANIMAL_ID CHAR(3) NOT NULL,
	CHECK_DATE DATE DEFAULT SYSDATE NOT NULL,
	SEVERITY CHAR(1),
--	CONSTRAINT RECORD_UNIQUE UNIQUE(RECORD_ID),
	CONSTRAINT SEV_CK CHECK (SEVERITY IN ('H', 'M', 'L')),
--	PRIMARY KEY(RECORD_ID)
--	PRIMARY KEY(RECORD_ID, ANIMAL_ID)
	FOREIGN KEY (ANIMAL_ID) REFERENCES ANIMAL(ANIMAL_ID)
);

--RECORD_ID CHAR(5) NOT NULL UNIQUE (컬럼레벨에서 제약조건)
--UNIQUE(RECORD_ID) (뭐라고 설명하더라)
-- 두개가 같은거임

-- 심각하다 H, 걍 M, 별로 안심각함 L

--ORA-01400: NULL을 ("C##MH"."MEDICAL_RECORD"."RECORD_ID") 안에 삽입할 수 없습니다
INSERT INTO MEDICAL_RECORD
VALUES (NULL, NULL, NULL);

--NULL을 ("C##MH"."MEDICAL_RECORD"."CHECK_DATE") 안에 삽입할 수 없습니다
INSERT INTO MEDICAL_RECORD
VALUES ('R0001', 'A01', NULL);

-- 2번째 INSERT 부터 무결성 제약 조건(C##MH.SYS_C008436)에 위배됩니다 
INSERT INTO MEDICAL_RECORD
VALUES ('R0001', 'A01', SYSDATE, 'M');

INSERT INTO MEDICAL_RECORD(RECORD_ID, ANIMAL_ID)
VALUES ('R0001', 'A01');

-- 무결성 제약조건(C##MH.SYS_C008463)이 위배되었습니다- 부모 키가 없습니다
INSERT INTO MEDICAL_RECORD(RECORD_ID, ANIMAL_ID)
VALUES ('R0002', 'A99');

--ORA-02290: 체크 제약조건(C##MH.SEV_CK)이 위배되었습니다
INSERT INTO MEDICAL_RECORD
VALUES ('R0001', 'A02', SYSDATE, 'U');

SELECT 
       RECORD_ID
     , ANIMAL_NAME
  FROM 
       MEDICAL_RECORD 
  JOIN
       ANIMAL USING(ANIMAL_ID);


DELETE FROM MEDICAL_RECORD
WHERE (RECORD_ID = 'R0001');

UPDATE MEDICAL_RECORD SET DOCTOR_NAME = '이명훈'
WHERE DOCTOR_NAME = '홍길동';

----------------------------------------------------

--< ALTER TABLE >

/*
 * 구조를 변경하는 구문
 * 
 * -컬럼 추가 : ALTER TABLE 테이블명 ADD 컬럼명 자료형;
 * -컬럼 수정 : ALTER TABLE 테이블명 MODIFY 컬럼명 자료형;
 * -컬럼 삭제 : ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
 * -컬럼명변경 : ALTER TABLE 테이블명 RENAME COLUMN 원래이름 TO 새이름;
 */

SELECT * FROM MEDICAL_RECORD;
ALTER TABLE MEDICAL_RECORD ADD COST NUMBER;
ALTER TABLE MEDICAL_RECORD MODIFY RECORD_ID CHAR(2);
-- 값이 들어있지 않으면 상관ㅇ벗는데 값이 들어있으면 그 값과 다른 자료형이나 그 값보다 작은 자료형으로 못바꿈
ALTER TABLE MEDICAL_RECORD RENAME COLUMN CHECK_DATE TO CK_DATE;
ALTER TABLE MEDICAL_RECORD DROP COLUMN COST;

--제약조건 삭제
ALTER TABLE MEDICAL_RECORD DROP CONSTRAINT SEV_CK;

--제약조건 추가 ★
ALTER TABLE MEDICAL_RECORD 
ADD CONSTRAINT SEV_CK 
CHECK(SEVERITY IN ('H', 'M'));
-- 자주 쓰면 좋겠다~ 추천 수정사항을 남겨야하고 다른 사람들이 사용할 때 혼선을 빚을 수 있음
----------------------------------------
-- < DROP TABLE >

DROP TABLE MEDICAL_RECORD;






/*



 */




