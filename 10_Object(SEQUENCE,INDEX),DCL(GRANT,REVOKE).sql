/*
< SEQUENCE ( 시퀀스 ) >
자동으로 번호를 만들어주는 객체 -> 채번
주로 PRIMARY KEY 값을 자동으로 생성할 때 사용

CREATE SEQUENCE 시퀀스명
START WITH 시작번호		-- 기본값 1
INCREMENT BY 증가값		-- 기본값 1
MAXVALUE	최대값
MINVALUE	최소값
CYCLE | NOCYCLE
CACHE 크기 | NONCACHE;	-- 캐시 사용 여부(기본값 20)			(기억해두면 굿)



*/
SELECT * FROM ZONE;

CREATE TABLE CREATE_NUMBER(
	ID NUMBER GENERATED ALWAYS AS IDENTITY,
	NAME CHAR(10)
);

INSERT INTO CREATE_NUMBER(NAME)
VALUES('하하~');
SELECT * FROM CREATE_NUMBER;

-- SEQUENCE 만들기

SELECT * FROM ZONE;
/*
 * 접두사
 * 테이블 : TB_테이블명
 * 뷰 : VW_뷰명
 * 시퀀스 : SEQ_시퀀스명
 * 인덱스 : IDX_인덱스명
 * 
 * 
 * 
 */
CREATE SEQUENCE SEQ_ZONE_ID
START WITH 9
NOCACHE;

/*
 * 시퀀스 사용 방법
 * 시퀀스명.NEXTVAL : 다음 번호 발행 NEXT
 * 시퀀스명.CURRVAL : 현재 번호 확인 CURRENT(NEXTVAL 한번 이상 호출 후 사용가능)
 */

SELECT SEQ_ZONE_ID.NEXTVAL FROM DUAL;
SELECT SEQ_ZONE_ID.CURRVAL FROM DUAL;

INSERT
  INTO
       ZONE
VALUES
       (
       SEQ_ZONE_ID.NEXTVAL
     , '테스'
     , '테스트'--'테스트타입'"C##MH"."ZONE"."ZONE_TYPE" 열에 대한 값이 너무 큼(실제: 15, 최대값: 10)
       );
--뒤에서 제한이 걸려도 NEXTVAL은 실행돼서 크기가 차이날 수 있음 근데 상관없으
-- 개발할 때 꼼꼼/ 대인배적 기질 

SELECT * FROM ZONE;

-- 변경 삭제

ALTER SEQUENCE SEQ_ZONE_ID
 INCREMENT BY 2;

SELECT SEQ_ZONE_ID.NEXTVAL FROM DUAL;

DROP SEQUENCE SEQ_ZONE_ID;

--< INDEX >--

/*
 * 데이터 검색 속도를 향상시키기 위한 객체(책의 차례 목차 색인 이거랑 똑같음), 너무 많이 쓰면 오히려 저하를 일으킬 수 있음,
 * 
 * -PRIMARY KEY, UNIQUE 제약조건을 달아주는 컬럼은 자동으로 인덱스 생성됨, 이걸로 충분함 개념만 알고 쓰진 말자
 * 
 * - 데이터 변경(INSERT, UPDATE, DELETE)이 빈번한 컬럼은 인덱스 비추천
 * 
 * 13:35
 */

CREATE INDEX IDX_ANIMAL_NAME ON ANIMAL(ANIMAL_NAME); -- 동물이름으로 속도 향상
DROP INDEX IDX_ANIMAL_NAME;


--=================< DCL (Data Control Language ) > ===============

/*
 * 데이터 제어 언어
 * 권한을 부여(GRANT) 하거나 회수(REVOKE)하는 구문
 * 
 * < 시스템 권한 >
 * CREATE SESSION : DB 접속 권한
 * CREATE TABLE : 테이블 생성 권한
 * CREATE VIEW : 뷰 생성 권한
 * CREATE SEQUENCE : 시퀀스 생성 권한
 * ...
 * 
 * 
 * < 객체 권한 >
 * SELECT, INSERT, UPDATE, DELETE ON 테이블명
 * 
 * [ 표현법 ]
 * GRANT 권한 TO 사용자명;
 * REVOKE 권한 FROM 사용자명;
 * 
 */

--< 권한 줫다뺏기 (관리자계정으로 작업 수행) >

--사용자 생성
CREATE USER C##STUDENT IDENTIFIED BY 1234;

--접속 권한 부여
GRANT CREATE SESSION TO C##STUDENT;

--테이블 생성 권한 부여
GRANT CREATE TABLE TO C##STUDENT;

-- 특정 테이블 조회 권한 부여
GRANT SELECT ON C##SC.ANIMAL TO C##STUDENT;

--ROLE(역할) 부여 : 여러 권한을 묶어놓은 것
GRANT CONNECT, RESUOURCES TO C##STUDNET;
/*
 * ROLE
 * 
 * CONNECT : CREATE SESSION
 * RESOURCE : CREATE TABLE, CREATE SEQUENCE, CREATE INDEX ...
 * DBA		: 관리자 권한
 * 
 * 
 */

--권한 회수
REVOKE CREATE SESSION FROM C##STUDENT;

--사용자 삭제
DROP USER C##STUDENT CASCADE;

















