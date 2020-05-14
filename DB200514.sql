--EMPLOYEE 테이블 형태
DESC EMPLOYEE;

--CRUD	:데이터 처리 로직
--CREATE:데이터 추가	/INSERT
--READ	:데이터 조회	/SELECT
--UPDATE:데이터 수정	/UPDATE
--DELETE:데이터 삭제	/DELETE

--기본 형태 연습
--EMPLOYEE 테이블에서 모든 사원의 사원명, 이메일, 연락처, 입사일 조회하기
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE FROM EMPLOYEE;

--기본형태 연습2
--부서코드가 D6인 부서의 모든 직원 정보 조회하기
SELECT * FROM EMPLOYEE WHERE DEPT_CODE ='D6';

--조건을 2개이상 붙었을 경우(AND, OR)
--부서코드가 D6이면서, 이름이 '유재식'인 사원의 모든정보 조회
SELECT * FROM EMPLOYEE WHERE DEPT_CODE='D6' OR EMP_NAME = '유재식';

--컬럼 명에 별칭 달기
--1. AS(alias) 표현
SELECT EMP_ID AS "사원번호", EMP_NAME AS "사원명" FROM EMPLOYEE;

--AS 생략 / 별칭에 ()나 띄어쓰기 같은 문자가 들어갈 경우 반드시 ""로 구분 지어야한다. 
SELECT EMP_ID "사번 번호", EMP_NAME 사원명 FROM EMPLOYEE;

--실습 문제1
--EMPLOYEE 테이블에서 사원 번호가 205인 사원의 사원명, 이메일, 급여, 입사 일자를 조회하시오
--단, 조회하는 컬럼명에 별칭 부여


SELECT * FROM EMPLOYEE;

SELECT EMP_NAME 사원명, EMAIL 이메일, SALARY 급여, HIRE_DATE 입사일자 FROM EMPLOYEE WHERE EMP_ID = 205;

--컬럼 값을 사용하여 계산식 허용
--컬럼 값이 만약 NULL 이라면 연산을 처리하여도 결화는 NULL
SELECT EMP_NAME "사원명", (SALARY * 12) "연봉", BONUS "보너스",(SALARY + (SALARY *BONUS )) * 12 "연봉총합" FROM EMPLOYEE;

--NVL(): 만약 현재 조회한 값이 NULL 일 경우 별도로 설정한 값으로 변경
--NUL(컬럼명, 끼본값) 
SELECT EMP_NAME 사원명, (SALARY * 12) 연봉, BONUS 보너스, (SALARY + (SALARY * NVL(BONUS,0) )) *12 연봉총합 FROM EMPLOYEE ;

--컬럼에 일반값 사용
SELECT EMP_NAME, SALARY * 12, '원' 단위 FROM EMPLOYEE;

--DISTINCT: 중복 제거
--해당하는 값이 컬럼에 여러개 존재 할 경우 중복을 제거하고 한 개만 조회(NULL 포함)

SELECT DEPT_CODE FROM EMPLOYEE;
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE e 

--실습2
--DEPARTMENT 테이블을 참조하여, 부서가 '해외영업2부'인 부서의 코드를 찾고 
--EMPLOYEE 테이블에서 해당 부서의 사원들 중 급여를 200만원 보다 많이 받는 직원의 사번, 사원명, 급여를 조회
--1. '해외영업2부'의 부서의 코드찾기
--2. 조회한 부서코드를 이용해 사원들 중 금여를 200~
SELECT * FROM DEPARTMENT WHERE DEPT_TITLE ='해외영업2부'; --D6
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE ='D6' AND SALARY > 2000000;

--연산자
--연결 연산자 '||'
--여러 컬럼의 결과나 값을 하나의 컬럼으로 묶을 때 사용
--EX) '사번'을 가진 사원의 이름은 'ㅇㅇㅇ' 입니다.
SELECT EMP_ID || '을 가진 사원의 이름은' || EMP_NAME || '입니다' FROM EMPLOYEE e 

--비교 연산자
-- <, >, <=, >= 크기를 나타내는 부등호
-- = : 같다
-- !=, ^=, <> : 같지않다.

--EMPLOYEE에서 부서코드가 D9이 아닌 직원들의 모든 정보 조회
SELECT * FROM EMPLOYEE e WHERE DEPT_CODE  <>'D6';

--EMPLOYEE에서 급여가 350만원 이상 550만원 이하인 직원의 사번, 사원명, 부서코드, 직급코드, 급여정보를 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY FROM EMPLOYEE WHERE SALARY>=3500000 AND SALARY <= 5500000 ORDER BY SALARY ASC;--오름차순;
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY FROM EMPLOYEE WHERE SALARY>=3500000 AND SALARY <= 5500000 ORDER BY SALARY DESC;--내림차순;

--BETWEEN A AND B
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY FROM EMPLOYEE WHERE SALARY BETWEEN 3500000 AND 5500000 ORDER BY SALARY ASC;

--위와 똑같은 직원 정보를 조회하는데 350만원 미만, 550만원 초과인 직원 정보를 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY FROM EMPLOYEE WHERE SALARY NOT BETWEEN 3500000 AND 5500000;

--LIKE : 입력한 숫자, 문자가 포함된 정보를 조회
--EMPLOYEE에서 사원의 이름 가운데 '중'이 들어가는 사원 정보 조회
--'_' : 임이의 한문자
SELECT * FROM EMPLOYEE WHERE EMP_NAME LIKE '_중_';

--EMPLOYEE 테이블에서 주민등록번호 기준 남성인 사원의 정보만 조회
SELECT * FROM EMPLOYEE WHERE EMP_NO LIKE '______-2%';

--사원 중 이메일 아이디가 5글자를 초과하는 사원의 사원명, 사번, 이메일 정보 조회
SELECT EMP_NAME, EMP_ID, EMAIL FROM EMPLOYEE WHERE EMAIL LIKE '_____%@%';

-- EMPLOYEE 테이블에서 성이 '이'
SELECT * FROM EMPLOYEE WHERE EMP_NAME LIKE '이%';

--이메일 4번째가 _인 사원
SELECT * FROM EMPLOYEE WHERE EMAIL LIKE '___#_%@%' ESCAPE '#';

--IN 연산자
--IN(값1, 값2, 값3, ...)
--안에 있는 값 중 하나라도 일치 하는 경우 해당값을 조회

--부서코드가 D1, D6인 부서의 직원 정보를 조회
SELECT * FROM EMPLOYEE WHERE DEPT_CODE IN('D1','D6');

--D1,D6도 아닌 경우
SELECT * FROM EMPLOYEE WHERE DEPT_CODE NOT IN('D1', 'D6');

--연산자 우선순위
--0. ()
--1. 산술연산자 +-/*
--2. 연껼언산자
--3. 비교연산자
--4. IS NULL / IS NOT NULL / LIKE, IN/ NOT IN
--5. BETWEEN A AND B
--6. NOT
--7. AND
--8. OR

--종합실습문제1:
--직급이 'J2'이면서 200만원 이상 받는 직원이거나
--직급이 'J7'인 사원의 사번 사원명 직급코드 급여 정보조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY FROM EMPLOYEE WHERE JOB_CODE = 'J2' AND SALARY >2000000 OR JOB_CODE = 'J7';

--종합실습2
--직급이 'J7' 이거나 'J2'이면서 급여를 200만원 이상받는 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY FROM EMPLOYEE WHERE JOB_CODE IN('J2','J7') AND SALARY >= 2000000;



--FUNCTION(함수)

--문자 관련함수
--LENGTH : 문자열 길이
SELECT LENGTH('Hello') FROM DUAL;

--DUAL : 임시테이블(가상의 테이블)SELECT문에서 리터럴을 활용한 계산식을 테스트하고자 할 떄 사용하는 임시 테이블
SELECT LENGTH('이창진'), LENGTHB('이창진'), LENGTH('Hello'), LENGTHB('Hello') FROM DUAL;

--INSTR : 주어진 값에서 원하는 문자가몇번째인지 찾아 반환
SELECT INSTR('ABCDE','A'), INSTR('ABCDE','C') FROM DUAL;

--SUBSTR(컬럼명|값, 시작순번[,가져올 개수]) : 주어진 문자열에서 특정부분만 꺼내오는 함수 (값, 시작위치, 갯수)
SELECT 'Hello World', SUBSTR('Hello World',7), SUBSTR('Hellow World',1,5) FROM DUAL;

--실습 3
--EMPLOYEE 테이블에서 사원의 이름, 이메일 조회 / 이메일은 아이디부분만 조회하기
SELECT EMP_NAME, EMAIL FROM  EMPLOYEE;
--@ 위치 찾기
SELECT INSTR(EMAIL, '@') FROM EMPLOYEE;
SELECT EMP_NAME, SUBSTR(EMAIL,1, INSTR(EMAIL, '@')-1) FROM EMPLOYEE; 

--LPAD / RPAD : 빈 칸을 지정한 문자로 채워준다
SELECT LPAD(EMAIL, 20, '#') FROM EMPLOYEE; 
SELECT RPAD(EMAIL,20 , '_') FROM EMPLOYEE;

--LTRIM / RTRIM : 현재 부여된 컬럼값이나, 특정 값으로부터 특정 문자를 찾아 지워주는 함수
SELECT LTRIM('     Hello') FROM  DUAL;
SELECT RTRIM('Hello     ') FROM DUAL;
SELECT RTRIM('     HI') FROM DUAL;

SELECT LTRIM('012345','0'),
	LTRIM('1111234', '1'),
	LTRIM('012345','1') FROM DUAL;

--TRIM :  주어진 문자열에서 양 끝을 기준으로 특정문자를 지워주는 함수
--기본형태
SELECT TRIM('  내일비옴   ') FROM DUAL;
--양 끝의 특정값을 지우고자 할 떄
SELECT TRIM('0' FROM '000012300') FROM DUAL;
SELECT TRIM(LEADING '0' FROM '000012300') FROM DUAL;
SELECT TRIM(TRAILING  '0' FROM '000012300') FROM DUAL;
SELECT TRIM(BOTH '0' FROM '000012300') FROM DUAL;

--LOWER / UPPER / INITCAP : 소문자, 대문자, 앞글자
SELECT LOWER('NICE TO MEET YOU'),
	UPPER('nice to meet you'),
	INITCAP('nice to meet you') FROM DUAL;

--CONCAT : 여러문자열을 하나의 문자열로 합치는 함수
SELECT CONCAT('오라클', '너무 재미있어요') FROM DUAL;
SELECT '오라클 '||'너무 재미져용' FROM DUAL;

--REPLACE 
SELECT REPLACE('HELLO WORLD','HELLO','BYE') FROM DUAL;	

--실습4
SELECT EMP_NO FROM EMPLOYEE;
--사원의 주민번호를 조회하여 생년 월일을 각각 조회
SELECT EMP_NAME 이름, CONCAT(SUBSTR(EMP_NO,1,2),'년') 생년, CONCAT(SUBSTR(EMP_NO,3,2),'월') 생월, CONCAT(SUBSTR(EMP_NO,5,2),'일') 생일 FROM EMPLOYEE;

--SUBSTR을 활용하면 날짜 데이터도 나눌 수 있다.
SELECT EMP_NAME 이름, CONCAT(SUBSTR(HIRE_DATE,1,2),'년 ') 입사년도 FROM EMPLOYEE;

--단일 행 함수(Single Row Function) 결과를 찾아서 출력할 때마다 각행에 함수가 적용

--다중 행 함수(Multitple Row Function) 조건 절에 만족하는 모든 행을 다 찾고 나서 한번에 연산

--그룹함수 SUM(), AVG, MAX, MIN, COUNT

--SUM
SELECT SUM(SALARY) FROM EMPLOYEE;

--AVG
SELECT AVG(SALARY) FROM EMPLOYEE;

--MAX/ MIN
SELECT MAX(SALARY), MIN(SALARY) FROM EMPLOYEE;

--실습 5
--EMPLOYEE  '해오영업부1'에 근무하는 모든 사원의 평군급여, 가장높은 금여, 낮은 급영, 금여합게
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT WHERE DEPT_TITLE ='해외영업1부'; --D5
SELECT AVG(SALARY) 평군, MAX(SALARY) 가장높은급여, MIN(SALARY) 가장높은급여, SUM(SALARY) 급여합계 FROM EMPLOYEE WHERE DEPT_CODE ='D5';

--COUNT : 해당 하는 행의 개수
SELECT COUNT(*) FROM EMPLOYEE;
SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE) FROM EMPLOYEE;

--실습6
--EMPLOYEE 모든사원의 사번 사원명 이메일 주민번호를 조회하여 사원 목룔표를 만들자
--이메일은 '@' 전까지 주미ㄴ번호는 7번쨰 자리 이후는 *처리,, 
 SELECT EMP_ID 사번, EMP_NAME 사원명, SUBSTR(EMAIL,1, INSTR(EMAIL, '@') ) 이메일, CONCAT(SUBSTR(EMP_NO,1,8),'*******' ) 주빈번호 FROM EMPLOYEE;
 
 --실습7
 --여성사원의 사번, 사원명, 직금코드를 조회
 SELECT EMP_ID 사번, EMP_NAME 이름, ENT_YN 퇴사여부 FROM EMPLOYEE WHERE SUBSTR(EMP_NO,8,1) = 2; 
 --**ENT_YN: 현재 근무여부를 파악하는 컬럼
--
