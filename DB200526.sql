---------------0526
--인덱스--
--SQL 명령어 조회 처리 속도를 향상시키기 위한 객체

--장점:검색속도 향상
--단점: 인덱스가 존재하는 테이블의 내용이 자주 변경되는 테이블이라면 인덱스를 매번 다시 계산하여 만들어야하기 떄문에
--		오히려 성능이 저하될 수 있다.
--		인덱스를 저장하기 위한 별도의 공간을 할당 

--인덱스 생성방법
-- CREATE [UNIQUE] INDEX 인덱스명
-- ON 테이블명(컬럼[,컬럼명 | 함수식])

--인덱스를 관리하는 데이터사전
SELECT * FROM USER_IND_COLUMNS;

SELECT ROWID, EMP_ID, EMP_NAME
FROM EMPLOYEE;

--ROWID
--데이블 생성 및 데이터 추가시에 오라클에서 해당 객체를 관리하기 위한
--데이터의 순번, 시스템에서 직접 관리하기 떄문에 사용자가 함부로 변경 불가

--인덱스의 종류
--1. 고유인덱스(UNIQUE INDEX)
--2. 비고유인덱스(NOUNIQUE INDEX)
--3. 단일인덱스(SINGLE INDEX)
--4. 결합인덱스(COMPOSITE INDEX)
--5. 함수기반 인덱스(FUNCTION BASE INDEX)

-- 고유 인덱스 --
--인덱스 생성 시 고유값을 기준으로 생성하는 인덱스
--PRIMARY KEY 제약조건을 사용하면 자동으로 생성하는 인덱스

CREATE UNIQUE INDEX IDX_EMP_NO
ON EMPLOYEE(EMP_NO);

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMPLOYEE';

--ORA-01452: cannot CREATE UNIQUE INDEX; duplicate keys found
--컬럼의 값이 중복값 존재할 경우 UNIQUE INDEX 생성할 수 없다.
CREATE UNIQUE INDEX IDX_DEPT_CODE
ON EMPLOYEE(DEPT_CODE);

--NON-UNIQUE INDEX
-- 내가 자주 사용하는 컬럼을 인덱스로 구성하여 검색 속도를 향상 시키기 위한 인덱스
CREATE INDEX IDX_DEPT_CODE
ON EMPLOYEE(DEPT_CODE);

SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6';

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMPLOYEE';

--결합 인덱스
--여러 컬럼을 하나로 묶기 위한 인덱스
CREATE INDEX IDX_DEPT
ON DEPARTMENT(DEPT_ID, DEPT_TITLE);

SELECT * FROM DEPARTMENT;

SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT
WHERE DEPT_ID != 'D1'
	AND DEPT_TITLE != '기술지원부';

--함수기반인덱스
--조회 시 자주 사용하는 함수식이 있다면 해당 함수식을 인덱스 생성시 반영하여 검색을 향상 하는 인덱스

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ((SALARY * NVL(BONUS,0) + SALARY)*12) >1000000;

CREATE INDEX IDX_EMP_SAL_CAL
ON EMPLOYEE ((SALARY * NVL(BONUS,0) + SALARY)*12) ;

--인덱스 새로고침
ALTER INDEX IDX_DEPT REBUILD;

--인덱스 삭제
DROP INDEX IDX_DEPT;





--PL/SQL--
--(PROCEDURAL LANGUAGE EXTENSION TO SQL)

--기능: 변수선언, 비교처리, 반복처리

--PL/SQL의 구조
--선언부, 실행부,예외처리부
-- 선언부 : DECLARE, 변수 선언 하는 부분
-- 실행부: BEGIN, 제어문/반복문 등을 작성하는 부분
-- 예외처리부: EXCEPTION, 예외발생시 처리하는 내용 작성하는 부분

--실행부를 사용해서 간단한 문장 출력
BEGIN
	DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
	--DBMS_OUTPUT패키지의 PUT_LINE이라는 프로시저를 이용하여 호출
END;

--화면에 보이도록 설정
SET SERVEROUTPUT ON;


--변수 선언과 초기화, 출력
DECLARE
	vid NUMBER;
BEGIN
	SELECT EMP_ID
	INTO vid		--변수에 조회한 값을 담음
	FROM EMPLOYEE
	WHERE EMP_NAME = '선동일';
	DBMS_OUTPUT.PUT_LINE('ID='||vid);
EXCEPTION
	WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No Data!!');
END;

--변수선언
--[1]일반변수
DECLARE
	v_empno NUMBER(4);
	v_empname VARCHAR2(10);
	test_num NUMBER(5) := 10 * 20;
BEGIN
	v_empno := 1001;
	v_empname := '한예인';
	DBMS_OUTPUT.PUT_LINE(v_empno || '   '|| v_empname|| '    '|| test_num);
END;

--[2]레퍼런스 변수
--	(1)%TYPE: 한 컬럼의 자료형을 받아 올때 사용하는 자료형 타입
DECLARE
	EMP_ID EMPLOYEE.EMP_ID%TYPE;
	EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
	SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
	SELECT EMP_ID, EMP_NAME, SALARY
	INTO EMP_ID, EMP_NAME, SALARY
	FROM EMPLOYEE
	WHERE EMP_NAME = '송종기';
	DBMS_OUTPUT.PUT_LINE(EMP_ID || '     ' || EMP_NAME|| '     '||SALARY);
END;

--(2) %ROWTYPE : 한테이블의 모든 컬럼의 자료형을 참조할 때 사용하는 타입
DECLARE
	myrow EMPLOYEE%ROWTYPE;
BEGIN
	SELECT EMP_ID, EMP_NAME
	INTO myrow.emp_id, myrow.emp_name
	FROM EMPLOYEE
	WHERE EMP_NAME = '선동일';
	DBMS_OUTPUT.PUT_LINE(myrow.emp_id||',    '||myrow.emp_name);
END;

--IF문--
--IF ~ THEN ~ END IF문
/*
 * IF 조건 THEN 조건을 만족할 경우처리 구문;
 * END IF;
 * 
 * */
BEGIN
	IF '한예인' = '한예인' THEN
		DBMS_OUTPUT.PUT_LINE('한예인이다.');
	END IF;
END;
/

--2. IF ~ THEN ~ ELSE ~ END IF
BEGIN
	IF '한예인' = '한예인1' THEN
		DBMS_OUTPUT.PUT_LINE('한예인이당');
	ELSE DBMS_OUTPUT.PUT_LINE('아니네...');
	END IF;
END;
/

--3. IF ~ THEN ~ ELSEIF ~ ELSE ~ END IF;
/*
 * IF 조건1 THEN
 * 		실행1;
 * ELSEIF 조건2 THEN
 * 		실행2;
 * ELSE
 * 		모든 조건 만족하지 않을 때;
 * */

DECLARE
	NAME VARCHAR2(30) := '한예인';
BEGIN
	IF NAME = '한예인' THEN DBMS_OUTPUT.PUT_LINE('한예인이네....');
	ELSIF NAME = '장돈건' THEN DBMS_OUTPUT.PUT_LINE('장동건이구만...');
	ELSE DBMS_OUTPUT.PUT_LINE('누구여...');
	END IF;
END;
/

--4. CASE문
-- CASE ~ END CASE;
/*
 * CASE
 * 		WHEN 표현식1 THEN
 * 				실행문;
 * 		WHEN 표현식2 THEN
 * 				싱행문2;
 * 		ELSE 기본실행문;
 * END CASE;
 * */

DECLARE
	NUM NUMBER(10) := 3;
BEGIN
	CASE NUM
	WHEN 1 THEN 
		DBMS_OUTPUT.PUT_LINE(NUM || '입니다.');
	WHEN 2 THEN
		DBMS_OUTPUT.PUT_LINE(NUM || '입니다아');
	WHEN 3 THEN
		DBMS_OUTPUT.PUT_LINE(NUM || '일껄요?');
	ELSE
		DBMS_OUTPUT.PUT_LINE('으잉?');
	END CASE;
END;
/

SELECT * FROM EMPLOYEE;

--사원번호를 통해 조회한 직원들의 직급코드로 대표, 임원진, 일반직원을 구분하는 예제를 CASE로 구현

DECLARE
	JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
	EMP_TEAM VARCHAR2(15);
BEGIN
	SELECT JOB_CODE
	INTO JOB_CODE
	FROM EMPLOYEE
	WHERE EMP_ID = '201';
	CASE JOB_CODE
		WHEN 'J1' THEN EMP_TEAM := '대표';
		WHEN 'J2' THEN EMP_TEAM := '임원진';
		ELSE EMP_TEAM := '일반직원';
	END CASE;
	DBMS_OUTPUT.PUT_LINE('소속:' || EMP_TEAM);
END;
/

--PL/SQL 반복문
--LOOP
DECLARE
	E EMPLOYEE%ROWTYPE;
BEGIN
	SELECT *
	INTO E
	FROM EMPLOYEE;
	DBMS_OUTPUT.PUT_LINE(E.EMP_ID);
END;
/

--LOOP, FOR, WHILE

--일반 LOOP문
/*
 * LOOP
 * 		반복시킬 내용
 * 		IF 반복 종료 조건
 * 			EXIT;
 * 		END IF;
 * END LOOP;
 * */

DECLARE
	N INT := 5;
BEGIN
	LOOP
		DBMS_OUTPUT.PUT_LINE(N);
		N := N-1;
		EXIT WHEN N=0;
	END LOOP;
END;
/

--FOR 반복문 
--카운트용 변수는 자동선언, 카운트 값은 자동으로 1씩 증가, REVERSE 1씩 감소
/*
 * FOR 카운트변수 IN [REVERSE] 시작값..종료값 LOOP
 * 반복할 내용;
 * */

BEGIN
	FOR N IN 1..5 LOOP
		DBMS_OUTPUT.PUT_LINE(N);
	END LOOP;
END;
/

--FOR문을 반대로 실행

BEGIN
	FOR N IN REVERSE 1..5 LOOP
	DBMS_OUTPUT.PUT_LINE(N);
	END LOOP;
END;
/

--FOR문을 통한 INSERT 사용
CREATE TABLE TB_FOR(
	NO NUMBER(10),
	TEST_DATE DATE
);
BEGIN
	FOR X IN 1..10 LOOP
		INSERT INTO TB_FOR VALUES(X, SYSDATE+X);
	END LOOP;
END;
/

SELECT * FROM TB_FOR;

--PL/SQL의 FOR 반복문을 이용하여 EMPLOYEE 테이블에서
--200번붙터 210번 까지의 사원의 아이디, 사원명, 이메일을 출력;
BEGIN 
	FOR R IN 1..10 LOOP
	
	END LOOP;
END





