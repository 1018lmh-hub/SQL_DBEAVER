/*
	< SELECT > 
	데이터를 조회하거나 검색할 때 사용하는 명령어
	
	SELECT 
		   조회하고자 하는 컬럼 
		 , 조회하고자 하는 컬럼 
	  FROM 
		   테이블명;
		   
	이렇게 깔끔하게 삭 맞추기
		   
	- RsultSet : SELECT 문을 통해 조회된 데이터 결과물
				 조회된 행들의 집합
	
*/

--ANIMAL 테이블에서 모든 컬럼을 전부 다 조회 new String("abc")
SELECT  * FROM ANIMAL; -- * 은 모든을 의미 , 성능에 영향을 끼치므로 사용하지 말 것

-- 필요한 컬럼만 명시해서 조회
SELECT 
	   ANIMAL_NAME
	 , WEIGHT_KG
  FROM 
	   ANIMAL;

SELECT animal_name, weight_kG FROM animal;
-- 소문자보다 대문자로 쓰자 권장

--실습문제

--1. SPECIES 테이블에서 SPECIES_ID, SEPCIES_NAME 컬럼을 조회

SELECT 
	   SPECIES_ID
	 , SPECIES_NAME -- 이거 없다네요
  FROM 
  	   SPECIES;

--2. ZONE 테이블에서 ZONE_ID, ZONE_NAME 컬럼을 조회

SELECT 
	   ZONE_ID 
	 , ZONE_NAME 
  FROM 
  	   ZONE;

-- 3. KEEPER 테이블에서 KEEP_NAME, HIRE_DATE 컬럼을 ㅈ회

SELECT 
	   KEEPER_NAME
	 , HIRE_DATE
  FROM
  	   KEEPER;

-- 4. ANIMAL 테이블에서 ANIMAL_NAME, GENDER 컬럼을 조회

SELECT 
	   ANIMAL_NAME
	 , GENDER
  FROM 
  	   ANIMAL;

-- 5. ANIMAL 테이블에서 BIRTH_DATE, ANIMAL_NAME, ZONE_ID 컬럼을 조회

SELECT 
	   BIRTH_DATE
	 , ANIMAL_NAME
	 , ZONE_ID
  FROM 
  	   ANIMAL;


------------------------------------------------------------------

/*
 * <컬럼에서 조회된 값을 가지고 산술연살>
 * SELECT절에 산술연산을 기술해서 결과를 조회할 수 있다!
 * 
 */

-- ANIMAL 테이블로부터 동물이름, 체중을 조회

SELECT 
	   ANIMAL_NAME
	 , WEIGHT_KG
	 -- Gram 단위도 추가로 조회하고 싶은데??
	 , WEIGHT_KG * 1000
  FROM
       ANIMAL;
-- FOOTBALLPLAYER, 몸값 13000000000, 130억


-- 현재 시점의 날짜값 : SYSDATE
SELECT
       ANIMAL_NAME
     , ARRIVAL_DATE
     , (SYSDATE - ARRIVAL_DATE)
  FROM
       ANIMAL;
 --> 산술연산 과정에서 NULL 값이 존재할 경우 산술연산 결과도 NULL
-----------------------------------------------------------------------

/*
 * < 컬럼명에 별칭 달기 >
 * 
 * 컬럼명 AS 별칭, 컬럼명 AS "별칭", 컬럼명 "별칭", 컬럼명 별칭
 */

SELECT 
	   ANIMAL_NAME AS 동물이름
	 , WEIGHT_KG "체중(kg)"
	 , WEIGHT_KG * 1000 "체중(g)"
  FROM 
	   ANIMAL;

-- 별칭에 특수문자 또는 공백이 포함될 경우 반드시 " " 로 묶어줘야함

---------------------------------------------------------------------

/*
 * < 리터럴 > 
 * 
 */

SELECT 
       ANIMAL_NAME
     , WEIGHT_KG || ' kg' 단위
     , 'kg' 단위
  FROM 
  	   ANIMAL;
----------------------------------------------------------------------

/*
 * <DISTINCT>
 * 조회하려고 하는 컬럼 앞에 작성해서 중복된 값을 한번만 조회
 */

SELECT
       DISTINCT SPECIES_ID
     , ANIMAL_NAME
  FROM 
       ANIMAL;

----------------------------------------------------------------------
/*
 * <WHERE 절>
 * 
 * SELECT 절에서 조회를 할 때 조건을 제시하는 문법
 * 조건에 만족하는 행만 조회할 수 있음
 * 
 * SELECT
 * 		  컬럼명
 *   FROM 
 *        테이블명
 *  WHERE 
 *        조건식;
 * 
 * < 비교연산자 >
 * 동등비교 : =, !=
 * 대소비교 : <, >, <= , >=
 * 
 * 
 */

-- ANIMAL 테이블에서 100KG 이상인 동물들의 이름 조회

SELECT 
       ANIMAL_NAME
     , WEIGHT_KG 
  FROM 
       ANIMAL
 WHERE 
       WEIGHT_KG > 100;

-- ANIMAL 테이블에서 성별이 'F'인 동물들의 이름, 성별 조회
SELECT 
	   ANIMAL_NAME
	 , GENDER
  FROM 
       ANIMAL
 WHERE 
       GENDER = 'F';

--ANIMAL 테이블 구역코드 'Z1' 이 아닌 동물들의 이름, 구역코드 조회

SELECT 
	   ANIMAL_NAME
	 , ZONE_ID
  FROM 
       ANIMAL
 WHERE 
       ZONE_ID != 'Z1';
	 --ZONE_ID <> 'Z1'; != 이랑 같은거임

-- 실행순서
-- 1. SELECT, 2. FROM, 3. WHERE
-- FROM(테이블을 찾음) -> WHERE(컬럼에 있는 값을 비교) -> SELECT(해당하는 컬럼들)

--1. ANIMAL 테이블에서 체중이 50KG 이상인 동물들ㄹ의 이름 체중 조회

--2. ANIMAL 테이블에서 구역코드가 'Z2' 인 동물들의 이름, 체중 조회

--3. ANIMAL 테이블에서 수컷(GENDER = 'M')인 동물들의 이름, 성별, 체중 조회

SELECT 
	   ANIMAL_NAME
	 , ZONE_ID
	 , WEIGHT_KG
  FROM
       ANIMAL
 WHERE 
       ZONE_ID = 'Z2'
   AND 
       WEIGHT_KG >= 50;

SELECT 
       ANIMAL_NAME
     , WEIGHT_KG
  FROM 
       ANIMAL
 WHERE
       ZONE_ID = 'Z2';

SELECT 
       ANIMAL_NAME
     , GENDER
     , WEIGHT_KG
  FROM 
       ANIMAL
 WHERE
       GENDER = 'M';

---------------------------------------------
/*
 * <논리 연산자>
 * AND(이면서, 그리고) / OR(또는, 이거나)
 */
-- 구역 코드가 'Z2' 이면서 체중이 50kg 이상인 동물들의 이름, 구역코드, 체중 조회

SELECT 
	   ANIMAL_NAME
	 , ZONE_ID
	 , WEIGHT_KG
  FROM
       ANIMAL
 WHERE 
       ZONE_ID = 'Z2'
   AND 
       WEIGHT_KG >= 50;

-- 구역 코드가 'Z4'이거나 체중이 10KG 이하인 동물들의 이름, 구역코드, 체중 조회

SELECT 
	   ANIMAL_NAME
	 , ZONE_ID
	 , WEIGHT_KG
  FROM
       ANIMAL
 WHERE 
       ZONE_ID = 'Z4'
   	OR 
       WEIGHT_KG <= 10;

-- 1 자바, SELECT 중요
-- 체중이 100KG 이상이고 500KG 이하인 동물들의 이름, 체중 조회

SELECT 
	   ANIMAL_NAME
	 , WEIGHT_KG
  FROM
       ANIMAL
 WHERE 
	   WEIGHT_KG > 100
   AND 
       WEIGHT_KG <= 500;
/*
< BETWEEN AND>
몇 이상 몇 이하인 범위에 조건을 제시할 때 사용

*/

-- 체중이 100KG 이상 500KG 이하인 동물들의 이름, 체중
SELECT 
	   ANIMAL_NAME
	 , WEIGHT_KG
  FROM
       ANIMAL
 WHERE 
	   WEIGHT_KG BETWEEN 100 AND 500;

-- 체중이 100KG 미민이거나 500KG 초과하는 동물
   
SELECT 
	   ANIMAL_NAME
	 , WEIGHT_KG
  FROM
       ANIMAL
 WHERE 
	   WEIGHT_KG NOT BETWEEN 100 AND 500;   

SELECT 
       ANIMAL_NAME
     , ARRIVAL_DATE
  FROM 
       ANIMAL
 WHERE 
       ARRIVAL_DATE BETWEEN '18/01/01' AND '22/12/31';

-----------------------------------------------------------
/*
 * < LIKE '특정패턴' >
 * 컬럼의 값이 지정한 특정 패턴을 만족할 경우 조회
 * 
 * '%' : 0 글자 이상
 *  LIKE '푸%' : '푸' 로 시작하는 데이터
 *  LIKE '%바%' : '바' 가 포함되는 데이터
 * 	LIKE '%이' : '이' 로 끝나는 데이터
 * 
 * '_' : 딱 1글자
 * LIKE '_리' : 앞에 1글자 + '리' 인 데이터
 * LIKE 
 * 
 * 
 * 
 */

SELECT 
	   ANIMAL_NAME
	 , WEIGHT_KG
  FROM 
       ANIMAL
 WHERE 
       ANIMAL_NAME LIKE '%바오';

-- 이름이 두 글자인 동물들의 이름
SELECT 
	   ANIMAL_NAME
	 , WEIGHT_KG
  FROM 
       ANIMAL
 WHERE 
       ANIMAL_NAME LIKE '_리';

/*
 * List<Animal> animals = new ArrayList();
 * 
 * 
 */

SELECT * FROM ANIMAL;

/*
 * public class Animal{
 * 	private String animalId;
 *  private String animalName;
 *  private String speciesId;
 * ...}
 * 자바에서 어떻게 써야 이렇게 구현할 수 있었나 생각해보기
 */

-----------------------------------------------------------
/*
 * <IS NULL>
 * 
 * 컬럼값이 NULL / NULL 이 아닐 때 비교할 때 사용
 * 
 */

-- 담당 사육사가 배정되지 않은 동물들 조회
SELECT 
	   ANIMAL_NAME
	 , KEEPER_ID
  FROM 
       ANIMAL
 WHERE 
     --KEEPER_ID IS NULL;
       KEEPER_ID IS NOT NULL;
     --NOT KEEPER_ID IS NULL; 되긴하는데 IS 랑 NULL 사이에 쓰면 좋음 
     
-------------------------------------------------------------------














