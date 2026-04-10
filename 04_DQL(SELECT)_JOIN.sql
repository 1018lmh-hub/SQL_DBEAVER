/*
 * < JOIN ☆ >
 *  두 개 이상의 테이블을 연결하여 하나의 결과로 조회하는 것
 *  연결고리가 되는 컬럼을 통해 관계를 맺어줌
 * 
 * -오라클전용문법 / ANSI (표준)문법이 있음 
 * 
 * 
 */

-- 조회, 동물의 이름, 종 이름을 동시에 조회하고 싶음

-- ANIMAL -> ANIMAL_NAME
-- SPECIES -> SPECIES_NAME

SELECT ANIMAL_NAME, SPECIES_ID FROM ANIMAL;
SELECT SPECIES_NAME, SPECIES_ID FROM SPECIES;

--> 오라클 전용 JOIN 구문
SELECT 
       ANIMAL_NAME,
     --A.SPECIES_ID,
     --S.SPECIES_ID, 
       SPECIES_NAME
  FROM
       ANIMAL A,
       SPECIES S
 WHERE 
       A.SPECIES_ID = S.SPECIES_ID;

-- ANSI 구문
SELECT  
       ANIMAL_NAME
     , SPECIES_NAME
  FROM 
       ANIMAL
  JOIN
       SPECIES USING(SPECIES_ID)
  -- FROM, JOIN 
       
-- EQUAL JOIN(등가조인) / INNER JOIN(내부조인)
-- 연결되는 컬럼의 값이 일치하는 행들만 조인해서 조회(일치하지 않은 행은 결과에서 제외)

-- CARTESIAN PRODUCT(카테시안곱) => 테이블끼리의 모든 행을 곱한 결과
-- 지구상에서 일어나선 안됨!!
       
SELECT * FROM ZONE;   -- ZONE_ID, ZONE_NAME
SELECT * FROM ANIMAL; -- ZONE_ID, ANIMAL_NAME

-- 동물 이름, 구역명 조회(똑같은 값이 들어있는 컬럼명을 알아야함, 같은 값이 중요 컬럼명은 다를 수도 있음), 출력하기 원하는 컬럼이름


--ANSI 구문 -> 연결고리의 컬럼명이 다르다고 가정
SELECT
       ANIMAL_NAME
     , ZONE_NAME
  FROM
       ANIMAL A
  JOIN
       ZONE Z ON(A.ZONE_ID = Z.ZONE_ID);

-- 동물이름, 종 이름, 구역명 조회
-- SPECIES_ID -> ANIMAL, SPECIES
-- ZONE_ID -> ANIMAL, ZONE
SELECT 
       ANIMAL_NAME,
       ZONE_NAME,
       SPECIES_NAME
  FROM
       ANIMAL 
  JOIN
       ZONE USING(ZONE_ID)
  JOIN
       SPECIES USING(SPECIES_ID);
       
SELECT ANIMAL_NAME, SPECIES_NAME
  FROM ANIMAL NATURAL JOIN SPECIES; -- 두 테이블에 동일한 값을 가지는 컬럼이 하나씩
  
-- 동물이름, 종 이름, 구역명, 담당 사육사 이름(KEEPER)
-- ANIMAL, SPECIES, ZONE, KEEPER
  
  SELECT 
         ANIMAL_NAME,
         SPECIES_NAME,
         ZONE_NAME,
         KEEPER_NAME
    FROM
         ANIMAL
    JOIN
         SPECIES USING(SPECIES_ID)
    JOIN
         ZONE USING(ZONE_ID)        
    JOIN
         KEEPER USING(KEEPER_ID);
  
  SELECT 
         ANIMAL_NAME,
         SPECIES_NAME,
         ZONE_NAME,
         KEEPER_NAME
    FROM
         ANIMAL A
    JOIN
         SPECIES S, ZONE Z, KEEPER K ON(A.SPECIES_ID = S.SPECIES_ID AND A.ZONE_ID = Z.ZONE_ID AND A.KEEPER_ID = K.KEEPER_ID);
  -- 왜 안되지
    
         
  
  --ANIMAL테이블에서 KEEPE_ID 컬럼의 값이 NULL인 경우 조회 안됨
  -- INNER JOIN 이므로
  
         
    -----------------------------< 외부 조인(OUTER JOIN) >---------------------------
  
  /*
   * 조인 조건에 만족하지 않는 행도 포함시켜 조회
   * LEFT OUTER JOIN : 왼쪽 테이블의 모든 행 조회
   * RIGHT OUTER JOIN : 오른쪽 테이블의 모든 행 조회
   * FULL OUTER JOIN : 양쪽 테이블의 모든 행 조회
   */
  
  -- LEFT JOIN : ANIMAL_NAME, KEEPER_NAME 조회
			 SELECT 
			        ANIMAL_NAME,
       				KEEPER_NAME
			   FROM 
 			        ANIMAL
    LEFT OUTER JOIN 
       				KEEPER USING(KEEPER_ID);
  -- 보통 OUTER는 생략
  
  --오라클 구문
  SELECT
         ANIMAL_NAME,
         KEEPER_NAME
    FROM
         ANIMAL A,
         KEEPER K
   WHERE  
         A.KEEPER_ID = K.KEEPER_ID(+);
  
  SELECT * FROM KEEPER;
  
  -- RIGHT JOIN
  
  SELECT 
         ANIMAL_NAME,
         KEEPER_NAME
    FROM
         ANIMAL A
   RIGHT
    JOIN
         KEEPER K ON(A.KEEPER_ID = K.KEEPER_ID);
  
  -- 왜 안써도 실행이 되지
        
  -- FULL OUTER JOIN : 양쪽 모두 포함
  SELECT 
         ANIMAL_NAME
       , KEEPER_NAME
    FROM
         ANIMAL 
    FULL
    JOIN 
         KEEPER USING(KEEPER_ID);
  
  -------------------------------------------------------------
  
  --NON EQUAL JOIN(비등가조인) 영어에서 NON은 보통 없는 거 NOT 은 부정
  -- (=) <- 이 아닌 범위 비교
  -- EX) 체중 WEIGHT_KH BETWEEN MIN_WEIGHT AND MAX_WEIGHT
  -- SELF JOIN(자체 조인)
  -- 테이블이 자기 자신과 조인해서 ResultSet을 만드는 경우
  
  SELECT * FROM  KEEPER;
  SELECT * FROM ANIMAL;
  SELECT * FROM SPECIES;
  SELECT * FROM ZONE;
  ---------------------------------------------------------
  --35마리 동물 전체 정보 조회
  -- 동물의 이름, 종 이름, 분류, 구역명, 실내외여부, 사육사명
--                                       (사육사가 배정되지 않은 경우 미배정이라 출력)
  -- 정렬은 ANIMAL_ID 오름차순으로 정렬하시오.
  
  SELECT 
       --ANIMAL_ID
         ANIMAL_NAME,
         SPECIES_NAME,
         SPECIES_CLASS,
         ZONE_NAME,
         ZONE_TYPE,
         NVL(KEEPER_NAME, '미배정')
    FROM 
         ANIMAL A
    JOIN 
         SPECIES S USING(SPECIES_ID)
    JOIN
         ZONE Z USING(ZONE_ID)
    LEFT     
    JOIN 
         KEEPER K USING(KEEPER_ID)
   ORDER
      BY 
         ANIMAL_ID;
  -- USING이랑 NATURAL JOIN 이랑 어차피 같은 거 아닌가 아니구나 컬럼이름이랑 값이 같아도 또 다른 컬럼이 같을 수 있으니까
  -- USING 도 컬럼 이름이 같아야 하는디
  -- ON 을 자주 쓰겠군
   
  
  
  
  
         
         
 
         
       









