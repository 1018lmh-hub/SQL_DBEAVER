/*
 *  < VIEW >
 * SELECT 문을 저장하는 가상의 테이블
 * 실제 데이터를 저장하는 것이 아니라, SQL문마 ㄴ저장해두었다가
 * 조회 시점에 저장한 SQL문을 실행해서 결과를 보여줌
 * 
 * CREATE VIEW 뷰 이름
 *     AS 서브쿼리;
 * 
 * -OR REPLACE : 뷰가 이미 존재하면 덮어쓰기 
 * 
 */


GRANT CREATE VIEW TO C##MH;
--< 뷰 만들기 >

SELECT * FROM ANIMAL;
SELECT * FROM KEEPER;

CREATE VIEW VW_ANIMAL_INFO 
AS
SELECT  
       KEEPER_NAME
     , ANIMAL_NAME
     , SPECIES_NAME
     , WEIGHT_KG
     , DECODE(GENDER, 'M', '수컷', 'F', '암컷') "성별"
  FROM
       KEEPER K
  LEFT
  JOIN 
       ANIMAL A USING(KEEPER_ID)
  LEFT
  JOIN
       ZONE Z ON(A.ZONE_ID = Z.ZONE_ID)
  LEFT
  JOIN
       SPECIES S USING(SPECIES_ID);

SELECT * FROM VW_ANIMAL_INFO 
 WHERE 
       KEEPER_NAME ='제인구달'
 ORDER 
    BY 
       WEIGHT_KG;

--데이터 딕셔너리 DICT
SELECT * FROM USER_VIEWS;
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_TAB_COLUMNS;
SELECT * FROM USER_TABLES;
SELECT * FROM USER_CATALOG;
SELECT * FROM USER_OBJECTS;
SELECT * FROM DICTIONARY;
-------------------------------------

/*
 * 단순 뷰 (1개 테이블, 함수/그룹핑 없음) 는 DML 가능
 * 복합 뷰(JOIN, GROUP BY 등) DML 불가
 * 보통 만들 때 WITH READ ONLY 옵션을 줘서 DML 자체를 차단
 */

-- 구역별 통계 SELECT
CREATE VIEW VW_ZONE_STATS
AS
SELECT
       ZONE_NAME
     , COUNT(*) "COUNT"--ORA-00998: 이 식은 열의 별명과 함께 지정해야 합니다
  FROM
       ANIMAL A
  JOIN
       ZONE Z USING(ZONE_ID)
 GROUP
    BY
       ZONE_NAME
 WITH READ ONLY;

SELECT * FROM VW_ZONE_STATS;
SELECT ZONE_NAME FROM VW_ZONE_STATS;


CREATE OR REPLACE VIEW VW_ZONE_STATS
AS
SELECT
       ZONE_NAME
     , COUNT(*) "COUNT"
     , MAX(WEIGHT_KG) "MAX_WEIGHT"
     , MIN(WEIGHT_KG) "MIN_WEIGHT"
  FROM
       ANIMAL A
  JOIN
       ZONE Z USING(ZONE_ID)
 GROUP
    BY
       ZONE_NAME
 WITH READ ONLY;

SELECT * FROM VW_ZONE_STATS;

--뷰의 장점
--1. 재사용성 : 자주쓰는 쿼리를 저장 -> 복잡한 쿼리를 간단하게 사용 가능
--2. 보안성 : 원하는 컬럼만 노출 가능

--- 좋다~~

-- < 뷰 삭제 >

--DROP VIEW 뷰이름;


 









