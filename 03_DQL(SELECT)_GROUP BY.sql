--=====================< GROUP BY >=======================

-- 종별로 동물들이 몇마리씩 있는 지 조회하고 싶다.
SELECT 
	   ANIMAL_NAME 
     , SPECIES_ID
  FROM
       ANIMAL;

SELECT * FROM SPECIES;

SELECT 
       COUNT(SPECIES_ID)
  FROM 
       ANIMAL 
 WHERE
       SPECIES_ID = 'S03';

SELECT 
       COUNT(*)
  FROM
       ANIMAL 
 
     


SELECT 
       COUNT(*)
  FROM 
       ANIMAL 
 WHERE
       SPECIES_ID = 'S03';


--S01 == 3마리
--S02 == 3마리
--S03 == 3마리


SELECT 
       SPECIES_ID
     , COUNT(*)
  FROM 
       ANIMAL 
 GROUP 
    BY 
       SPECIES_ID;

--성별 동물 수
SELECT 
       GENDER
     , COUNT(*)
  FROM 
       ANIMAL
 GROUP
    BY 
       GENDER;

--종별 최대 체주ㅗㅇ, 최소 체중

SELECT 
       SPECIES_ID 
     , MAX(WEIGHT_KG)
     , MIN(WEIGHT_KG)
     , COUNT(*)
  FROM 
       ANIMAL
 GROUP
    BY 
       SPECIES_ID ;

-- 구역별(ZONE_ID) 동물 수, 평균 체중 조회

SELECT 
       ZONE_ID
     , COUNT(*)  
     , AVG(WEIGHT_KG)
  FROM
       ANIMAL
 GROUP 
    BY 
       ZONE_ID;

SELECT 
       ZONE_ID,
       GENDER,
       COUNT(*)
  FROM 
       ANIMAL 
 GROUP
    BY  
       ZONE_ID, 
       GENDER
 ORDER
    BY
       ZONE_ID,
       GENDER DESC;

SELECT 
       GENDER
  FROM
       ANIMAL
HAVING
       GENDER

-------------------------------------------

/*
 * HAVING 절
 * 그룹에 대한 조건을 제시할 때 사용하는 문법
 * WHERE 절은 그룹함수를 사용할 수 없음 -> HAVING
 */

-- 종별 동물 수가 4마리 이상인 종만 조회

SELECT 				--4
       SPECIES_ID
     , COUNT(*)
  FROM
       ANIMAL		--1
 WHERE
       COUNT(*) >= 4--2
       GENDER = 'M'
 GROUP
    BY 
       SPECIES_ID;	--3
       
       --그래서 안됨
       

   
       
       

SELECT 				
       SPECIES_ID
     , COUNT(*)     --4
  FROM
       ANIMAL		--1
 GROUP
    BY 
       SPECIES_ID	--2
HAVING 
       COUNT(*) >= 4--3
 ORDER
    BY
       SPECIES_ID;  --5

-- 그룹함수를 조건에 쓰고 싶으면 HAVING 을 쓰는 거 단일행 함수는 WHERE
-- FROM으로 시작해서 SELECT 다음에 ORDER BY
      
-----------------------------------------------------
       
 /*
  * HAI 
  */

SELECT 
       ZONE_ID, 
       AVG(WEIGHT_KG) "평균체중"
  FROM 
       ANIMAL
 GROUP     
    BY 
       ZONE_ID
HAVING
       AVG(WEIGHT_KG) >= 100
 ORDER
    BY
       ZONE_ID;

---------------------------------------

/*
 * SELECT : 컬럼, 연산식, 함수, 리터럴
 *   FROM : 테이블명
 *  WHERE : 조건식
 *  GROUP
 *     BY : 그룹기준컬럼
 * HAVING : 그룹에 대한 조건식
 *  ORDER
 *     BY : 정렬기준;
 * 
 * 실행 순서
 * 1. FROM -> 2. WHERE -> 3. GROUP BY -> 4. HAVING -> 5. SELECT -> 6. ORDER BY
 */
  

















