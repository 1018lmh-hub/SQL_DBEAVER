/*
 * < DQL(Data Query Languager) > => SELECT
 * 데이터 질의 언어 => 데이터를 질의를 날려서 조회하는 구문
 * 
 * 
 * 
 * < DML (Data Mainpulation Language) >
 * 데이터 조작 언어
 * 테이블에 데이터를 삽입(INSERT), 수정(UPDATE), 삭제(DELETE) 하는 구문
 * 
 * ※ 주의) DML 수행 후 반드시 TCL(COMMIT/ ROLLBACK) 처리 필요 
 */
--========================< INSERT > =============================
/*
 * 테이블에 새로운 행을 추가하는 구문
 * 
 * [ 표현법 1 ] 모든 컬럼에 값을 넣는 경우
 * 
 * INSERT INTO 테이블명 VALUES(값, 값, 값, ...);
 * 
 * [ 표현법 2 ] 특정 컬럼만 값을 지정하는 경우
 * INSERT INTO 테이블명(컬럼명, 컬럼명, ...) VALUES(값, 값, 값, ...);
 * 
 * 
 */

SELECT * FROM SPECIES;

INSERT 
  INTO
       SPECIES
VALUES
       (
       'S13',
       '검독수리',
       '조류'
       );

-- INSERT 는 이게 끝이요~~

SELECT * FROM ZONE;

INSERT 
  INTO  
       ZONE
VALUES
       (
       'Z6',
       'KH관',
       '실내'
       );

SELECT * FROM KEEPER;

INSERT 
  INTO 
       KEEPER
VALUES
       (
       'K09',
       '이명훈',
       SYSDATE,
       NULL
       );

INSERT 
  INTO 
       KEEPER
       (
       KEEPER_ID,
       KEEPER_NAME,
       HIRE_DATE
       )
VALUES
       (
       'K09',
       '이명훈',
       SYSDATE
       );

-- ANIMAL 테이블에 새로운 동물을 한 마리 추가해보세요~ 시작

SELECT * FROM ANIMAL ORDER BY ANIMAL_ID;

INSERT 
  INTO 
       ANIMAL
VALUES
       (
       'A36',
       '달기',
       'S13',
       'Z6',
       'K09',
       'F',
       '50', --50 이렇게 쓰는 게 더 좋음
       TO_DATE('2012-07-07', 'YYYY-MM-DD'), --'2012-07-07' 이렇게 써도 됨
       SYSDATE
       );
  
SELECT * FROM ANIMAL;
SELECT * FROM SPECIES;

SELECT * FROM ZONE;

INSERT ALL
  INTO ZONE VALUES('Z7', '북극관', '실내')
  INTO ZONE VALUES('Z8', '아마존관', '실외')
  INTO ZONE VALUES('Z9', '땅굴관', '실내')
SELECT * FROM DUAL;

CREATE TABLE ANIMAL_BACKUP
AS SELECT * FROM ANIMAL WHERE 1 = 0; -- 구조만 복사

SELECT * FROM ANIMAL WHERE 1 = 0;
SELECT * FROM ANIMAL_BACKUP;

INSERT INTO ANIMAL_BACKUP
(SELECT * FROM ANIMAL WHERE ZONE_ID = 'Z1');

--=======================< UPDATE >===========================

/*
 * 기존 데이터를 수정하는 구문
 * 
 * [ 표현법 ]
 * UPDATE
 *        테이블명
 *    SET
 *        컬럼명 = 바꿀값
 *      , 컬럼명 = 바꿀값
 *      , ...
 *  WHERE
 *        조건식;
 */

SELECT * FROM ANIMAL ORDER BY ANIMAL_ID DESC;

-- WHERE절을 생략하면 모든 행이 수정됨!
ROLLBACK;-- AUTOCOMMIT 하면 롤백 못함 그냥 그렇게 살아야함
--UPDATE 
--       ANIMAL
--   SET
--       KEEPER_ID = 'K09';

UPDATE 
       ANIMAL
   SET
       KEEPER_ID = 'K09'
 WHERE 
       ANIMAL_ID = 'A35';


-- 서브쿼리를 활용한 UPDATE

-- 러바오와 같은 구역에 있는 판다들의 사육사를 K02로 통일
SELECT * FROM KEEPER;
SELECT * FROM ANIMAL WHERE ZONE_ID =;
SELECT * FROM ZONE;



UPDATE 
       ANIMAL
   SET
       KEEPER_ID = 'K02'
 WHERE
       (SPECIES_ID, ZONE_ID) = SELECT  
       								  SPECIES_ID
						     		, ZONE_ID
								 FROM
								      ANIMAL
 								WHERE
      								  ANIMAL_ID = (SELECT 
						   								  ANIMAL_ID 
					  								 FROM 
						  								  ANIMAL 
                     								WHERE 
                         								  ANIMAL_NAME = '러바오');

AND ANIMAL_NAME != '러바오';

--여러 컬럼 동시 수정
UPDATE 
       ANIMAL
   SET
       WEIGHT_KG = 5.2
     , KEEPER_ID = 'K07'
 WHERE
       ANIMAL_ID = 'A35';

--------------------------------------------------------------------------

-- < DELETE > --
/*
 * 테이블의 행을 삭제하는 구문
 * 
 * DELETE FROM 테이블명 WHERE 조건;
 * 
 * 주의 ) WHERE절은 안쓰면 전체 행이 삭제됨
 * 
 * 
 */
SELECT * FROM ANIMAL_BACKUP;

DELETE FROM ANIMAL_BACKUP
WHERE ANIMAL_NAME = '리카';

ROLLBACK;

/*
 * TRUNCATE VS DELETE
 * 
 * TRUNCATE TABLE 테이블명 -> 전체 삭제(DDL, 살릴 수가 없음)-> 절삭
 * DELETE FROM 테이블명 -> 전체 삭제(DML, WHERE, 살릴 수 있음)
 */

DELETE FROM ANIMAL_BACKUP; -- 0.002

TRUNCATE TABLE ANIMAL_BACKUP; -- 0.033

-- 테이블을 삭제

DROP TABLE ANIMAL_BACKUP;




