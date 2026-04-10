/*
	< 함수 FUNCTION >
	자바로 따지면 자바 API 메소드들 같은 개념
	함수 호출 시 전달된 값을 받아서 계산된 결과를 반환
	
	-단일행함수(이런게 있구나~~) : N개의 값을 읽어서 N개의 결과를 반환
	(매 행마다 함수 실행)
	-그룹함수(외우세용) : N개의 값을 읽어서 1개의 결과를 반환
	(하나의 그룹별로 함수 실행)
	
	단일행 함수 / 그룹함수는 일반적으로 함께 사용하지 않음
	=ResultSet의 행 수가 다르기 때문에
	
	




*/

--SELECT SUM(WEIGHT_KG) FROM ANIMAL;
--SELECT AVG(WEIGHT_KG) FROM ANIMAL;
--SELECT MAX(WEIGHT_KG) FROM ANIMAL;
--SELECT MIN(WEIGHT_KG) FROM ANIMAL;
--SELECT COUNT(WEIGHT_KG) FROM ANIMAL;

-- =====================================================
-- ================= 단일행함수 (문자관련) ===================

/*
 * LENGTH(컬럼|문자열) : 해당 문자열의 글자 수를  반환
 * LENGTHB(컬럼|문자열) : 해당 문자열의 바이트 수 반환
 * - 한글 3Byte(UTF-8), 영문/숫자/특수문자 1Byte
 * 
 */

SELECT 
       ANIMAL_NAME
     , LENGTH(ANIMAL_NAME)
  FROM
       ANIMAL
 WHERE 
       LENGTH(ANIMAL_NAME) = 2;

/*
 * INSTR(문자열, 특정문자, 찾을 위치 시작값, 순번)
 * 지정한 위치부터 특정 문자열을 검색해서 가장 먼저 찾을 위치 반환
 * 
 * 
 */
								-- DUAL(DUMMY테이블)
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL; --3 B가 세번째 자바 인덱스랑 다름

SELECT INSTR('AABAACAABBAA', 'B', 1) FROM DUAL; --3

SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL; --10
SELECT INSTR('AABAACAABBAA', 'B', -1, 2) FROM DUAL; --9

/*
 * SUBSTR(문자열, 시작위치, 추출할 문자수)
 * 문자열에서 특정 문자열을 추출해서 반환
 * 
 * 
 * 
 */

SELECT * FROM KEEPER;
SELECT 
       KEEPER_NAME
     , SUBSTR(KEEPER_NAME, 1, 1) AS "이름 첫 글자"
  FROM
       KEEPER;

/*
 * LPAD / RPAD(문자열, 최종길이, 덧붙일문자)
 * 문자열에 덧붙일 문자를 왼쪽/오른쪽에 붙여서 최종길이만큼 반환
 * 
 * 
 *
 *
 */

SELECT 
       ANIMAL_NAME
     , LPAD(ANIMAL_NAME, 10, '*')
     , RPAD(ANIMAL_NAME, 10, '*')
  FROM 
       ANIMAL;

SELECT 
       KEEPER_NAME
     , RPAD(SUBSTR(KEEPER_NAME, 1, 1), LENGTH(KEEPER_NAME)+1, '*')
  FROM 
       KEEPER;

---------------------------------------------------------------------------------
/*
 * TRIM(문자열)	: 양쪽 공백문자 제거
 * LTRIM(문자열, 제거할문자)
 * RTRIM(문자열, 제거할문자)

 */

SELECT TRIM('   동 물 원    ') FROM DUAL;

/*
 * LOWER / UPPER / INITCAP
 *  
 */

SELECT 
       LOWER('HELLO WORLD')
     , UPPER('HELLO WORLD')
     , INITCAP('HELLO WORLD')
  FROM
       DUAL;

/*
 * REPLACE(문자열, 찾을문자,바꿀문자)
 */
SELECT 
       ZONE_NAME
     , REPLACE(ZONE_NAME, '관', '파크') 
  FROM
       ZONE;

SELECT 
       CONCAT(ANIMAL_NAME, '은(는) 귀엽다.')
     , ANIMAL_NAME || '은(는) 귀엽다.'
  FROM 
       ANIMAL;
-------------------------------------------------
-- < 숫자 관련 함수 >
/*
 * ABS(숫자) : 절대값
 * MOD(숫자 1, 숫자 2) : 나머지
 * TRUNC(숫자, 소숫점위치) : 버림(절삭)
 * 
 */

SELECT 
       ANIMAL_NAME
     , WEIGHT_KG
     , ROUND(WEIGHT_KG, 0) AS "반올림"
     , CEIL(WEIGHT_KG) AS "올림"
     , FLOOR(WEIGHT_KG) AS "내림"
  FROM
       ANIMAL;

-----------------------------------------------------
-- <날짜 관련 함수>

/*
 * SYSDATE : 현재 시스템 날짜
 * MONTHS_BETWEEN(날짜 1, 날짜 2) 두 날짜 사이의 개월 수
 * EXTRACT(YEAR|MONTH|DAY FROM 날짜) : 날짜에서 년/월/일 추출
 * ADD_MONTHS(날짜, 숫자) : 특정 날짜에 개월 수를 더한 날짜
 * 
 * 
 */

-- 각 동물의 나이 조회

SELECT 
       ANIMAL_NAME
     , ARRIVAL_DATE
     , FLOOR(MONTHS_BETWEEN(SYSDATE, ARRIVAL_DATE)) AS "개월 수"
     , FLOOR(MONTHS_BETWEEN(SYSDATE, ARRIVAL_DATE) / 12) AS "나이 (년)"
     , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM ARRIVAL_DATE) "햇수계산"
  FROM 
       ANIMAL;


-------------------------------------------------------------------------------------

------------------< 형변환 함수 >-----------------------------

/*
 * TO_CHAR(날짜|숫자, 포메팅형식) : 문자타입으로 변환
 * TO_DATE(문자, 포메팅형식) : 날짜타입으로 변환
 * TO_NUMBER(문자) : 숫자타입으로 변환
 */

SELECT 
       KEEPER_NAME
     , HIRE_DATE
     , TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') "입사일"
  FROM 
       KEEPER;

SELECT 
       ANIMAL_NAME
     , WEIGHT_KG
  FROM 
       ANIMAL;

SELECT 
       TO_CHAR(12345678, '999,999,999')
  FROM
       DUAL;
-------------------------------------------------

/*
 * NULL 처리함수
 * 
 * NVL(컬럼, NULL 일 때 반환할 값)
 * NVL2(컬럼, NULL이 아닐 때 반환할 값, NULL일 때 반환할 값 )
 * 
 */

SELECT 
       ANIMAL_NAME
     , NVL(TO_CHAR(ARRIVAL_DATE, 'YYYY-MM-DD'), '동물원에서 태어남')
  FROM 
       ANIMAL;

--SELECT  FROM ANIMAL;

SELECT 
       ANIMAL_NAME
     , NVL2(KEEPER_ID, '배정완료', '미배정') "사육사 배정여부"
  FROM 
       ANIMAL;

---------------------------------------------------------------------
----------------< 선택 함수 >-----------------
/*
 * DECODE(비교대상, 조건1, 결과1, 조건2, 결과2, ..., 기본값)
 * CASE WHEN 조건 THEN 결과 ... ELSE 기본값 END
 */

SELECT 
       ANIMAL_NAME
     , DECODE(GENDER, 'M' , '수컷', 'F', '암컷') AS "GENDER"
  FROM 
       ANIMAL;

SELECT 
       ANIMAL_NAME
	 , WEIGHT_KG
	 , CASE
	    WHEN WEIGHT_KG >= 1000 THEN '초대형'
	    WHEN WEIGHT_KG >= 100  THEN '대형'
	    WHEN WEIGHT_KG >= 10   THEN '중형'
	    ELSE '소형'
	   END "크기"
  FROM 
       ANIMAL;


----------------------------------------------------------------------------
--<그룹함수>
/*
 * SUM(숫자컬럼) : 합계
 * AVG(숫자컬럼) : 평균
 * COUNT(*|컬럼) : 행 수
 * MAX(컬럼) : 최대값
 * MIN(컬럼) : 최소값
 * 
 * COUNT SUM 자주 사용
 */

--전체 동물 수

SELECT COUNT(*) FROM ANIMAL;
SELECT LENGTH(ANIMAL_NAME) FROM ANIMAL;


--평균 체중
SELECT ROUND(AVG(WEIGHT_KG)) FROM ANIMAL;

--무거운 동물, 가벼운 동물

SELECT  
       MAX(WEIGHT_KG) AS "무거운동물"
     , MIN(WEIGHT_KG) AS "가벼운동물"
  FROM
       ANIMAL;

--COUNT(컬럼) : NULL 값을 제외하고 카운트
SELECT 
       COUNT(KEEPER_ID)
  FROM
       ANIMAL;

SELECT 
       KEEPER_ID
  FROM
       ANIMAL;





















