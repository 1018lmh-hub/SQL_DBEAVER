-- 한 줄 주석
/*
	여러줄
	주석
	92 QUERIES
	60 
	나오면 잘 된거
*/
-- 일반 사용자 계정(수업시간에 사용할 각자 계정)
CREATE USER C##MH IDENTIFIED BY MH;

-- 접속 권한 부여, 데이터를 다룰 수 있는 권한 부여
GRANT CONNECT, RESOURCE TO C##MH;
--테이블 스페이스 사용 권한 부여
GRANT UNLIMITED TABLESPACE TO C##MH;


