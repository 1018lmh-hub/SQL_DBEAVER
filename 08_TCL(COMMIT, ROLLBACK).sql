
/*
 *  < TCL (Transaction Control Language) >
 * 			트랜젝션 		제어		언어
 * 
 * < 트랜젝션 >
 * 
 * 데이터베이스의 논리적 작업단위~~~~~~~~~~~~~~~~~~
 * 
 * 한꺼번에 수행되어야 할 DML 명령문들을 하나로 묶은 것
 * ALL OF NOTHING -> 전부 성공하거나 전부 실패하거나
 * 
 * 이승철 -> 계좌이체 -> 메리츠실비보험
 * 		   우리은행
 * 
 * ACID
 * 
 * Atomicity(원자성) : 전부 실행되거나 전혀 실행되지 않음
 * 
 * Consistency(일관성) : 실행 전후로 DB가 일관된 상태를 유지(무결성 제약조건 만족)
 * 
 * Isolation(고립성) : 동시에 실행되는 트랜잭션들이 서로 간섭하면 안됨
 * 
 * Durability(지속성) : 커밋된 결과는 시스템 장애가 나도 영구적으로 반영
 * 
 * COMMIT		: 트랜잭션의 변경사항을 확정 ( 저장 )
 * ROLLBACK		: 트랜잭션의 변경사항을 취소 ( 되돌리기 )
 * SAVEPOINT	: 트랜잭션 내 임시 저장 지점 설정
 * 
 * 
 * 
 */


SELECT * FROM ANIMAL WHERE ANIMAL_ID = 'A36';

-- 데이터 갱신(트랜잭션 생성) UPDATE
UPDATE 
       ANIMAL 
   SET
       WEIGHT_KG = 999
 WHERE
       ANIMAL_ID = 'A36';

-- 변경된 상태 확인
SELECT * FROM ANIMAL WHERE ANIMAL_ID = 'A36';

--ROLLBACK 트랜젝션 전부 날림
ROLLBACK;

UPDATE 
       ANIMAL 
   SET 
       WEIGHT_KG = 400
 WHERE
       ANIMAL_ID = 'A36';

COMMIT; --변경사항 확정짓기
------------------------------------------------------

-- < SAVEPOINT >

/*
 * SAVEPOINT 포인트명;		-저장 시점 설정
 * ROLLBACK TO 포인트명;	- 해당 지점까지만 되돌림
 */

--가정 : 새 동물이 들어옴
--1단계 : 새동물등록

INSERT INTO ANIMAL 
VALUES('A99', '상근이', 'S01', 'Z1', 'K01', 'M', 100, SYSDATE, SYSDATE);

SAVEPOINT SP1;

--2단계 : 체중 수정
UPDATE ANIMAL SET WEIGHT_KG = 15 WHERE ANIMAL_ID = 'A99';

SAVEPOINT SP2;

SELECT * FROM ANIMAL WHERE ANIMAL_ID = 'A99';

SELECT * FROM ANIMAL;

ROLLBACK TO SP2;
ROLLBACK TO SP1;

------------------------------------------------------

/*
 * DDL을 수행하면 DDL수행 전에 COMMIT
 * 
 * DDL 수행 전에 ROLLBACK할거면 미리 해야함
 * 
 * 
 */













--------------------------------------------------------
