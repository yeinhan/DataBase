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


--************************2
--한줄 주석
/*
 * 여러줄 주석
 */
--';' 문장의 끝

--SELECT 문: 조회용 SQL
--[형식]
--SELECT 컬럼명   : 조회하고자 하는 내용
--FROM 테이블명   : 조회하고자 하는 테이블 명
--[WHERE 조건]   : 특정조건
--[ORDER BY 컬럼]   : 정렬
-- ;

--모든 행과 모든 컬럼 조회
SELECT * FROM EMPLOYEE;

--사원의 ID와 사원명, 연락처 조회
SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE;

--사원의 ID, 사원명, 이메일, 연락처, 부서번호 직급코드를 조회
SELECT EMP_ID, EMP_NAME, EMAIL, PHONE, DEPT_CODE, JOB_CODE FROM EMPLOYEE;

--WHERE 절
--테이블에서 조건을 만족하는 값을 가지는 행을 따로 선택하여 조회한느 조건절
--여러 개의 조건을 선택하고자 할 경우 AND, OR 명령어를 함께 사용

--부서 코드가 D6인 사원 정보를 모두 조회하기
SELECT * FROM EMPLOYEE WHERE DEPT_CODE = 'D6';

--문제1.
--직급이'J1'인 사원의 사번, 사원명, 부서코드를 조회하시오
--문제2
--급여가 300만원 이상인 사원의 아이디, 사원명, 직급코드, 급여를 조회하시오.

SELECT EMP_ID , EMP_NAME,JOB_CODE, DEPT_CODE FROM EMPLOYEE WHERE JOB_CODE='J6';

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY FROM EMPLOYEE WHERE SALARY > 3000000;

--200515--
-- 날짜 처리 함수
-- SYSDATE : 현재 컴퓨터의 날짜를 반환하는 함수
SELECT SYSDATE FROM DUAL; 

-- MONTHS_BETWEEN(날짜1, 날짜2) : 두 날짜 사이의 개월 수
SELECT HIRE_DATE 입사일,
      FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "입사 후 개월 수" 
FROM EMPLOYEE;

-- ADD_MONTHS(날짜, 개월 수)
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL; 

-- EXTRACT(YEAR | MONTH | DAT FROM 날짜데이터)
-- 지정한 날로부터 날짜 값을 추출하는 함수
SELECT EXTRACT(YEAR FROM HIRE_DATE),
       EXTRACT(MONTH FROM HIRE_DATE),
       EXTRACT(DAY FROM HIRE_DATE)
FROM EMPLOYEE;

-- 형변환 함수
-- DATE <--> CHAR <--> NUMBER
-- TO_DATE(), TO_CHAR(), TO_NUMBER

-- TO_CHAR --
-- 날짜 정보 변경 --
SELECT HIRE_DATE,TO_CHAR(HIRE_DATE,'YYYY-MM-DD'),TO_CHAR(HIRE_DATE,'YY-MON-DD') FROM EMPLOYEE;

-- 숫자 형식 변경
-- 9: 남은 빈 칸은 표시하지 않는다.
-- 0: 남은 빈 칸을 0으로 표시
-- L: 통화기호(원, 엔, 위안, 달러)
SELECT SALARY,TO_CHAR(SALARY),TO_CHAR(SALARY, 'L999,999,999'), TO_CHAR(SALARY, '000,000,000'),TO_CHAR(SALARY, 'L999,999')
FROM EMPLOYEE;


-- TO_DATE() --
SELECT 20200515,
      TO_DATE(20200515, 'yyyymmdd'),
      TO_DATE(20200515, 'YYYY/MM/DD')
FROM DUAL;


-- DECODE() --
-- JAVA에서 3항 연산자
-- 조건  ? 참 : 거짓

-- 현재 근무하는 직원들의 성별을 남, 여로 구분 짓기
SELECT EMP_NAME, EMP_NO,DECODE(SUBSTR(EMP_NO,8,1), '1', '남', '2', '여') 성별 FROM EMPLOYEE ORDER BY 성별;

--실습1
--모든 직원의 사번, 사원명, 부서코드, 직급코드, 근무여부, 관지라여부 조회하되 만약 근무 여부가 'Y'퇴사자, 'N'근무자, 관리자사번(MANAGER_ID) 있으면 '사원', 없으면 '관리자'로 작성하여 조회
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_CODE 부서코드, JOB_CODE 직급코드,
   DECODE(ENT_YN, 'Y', '퇴사자','근무자') "근무 여부",
   DECODE(NVL(MANAGER_ID ,0),0,'관리자','사원' ) "관리자 여부"
   FROM EMPLOYEE;

--Case 문
--JAVA의 IF, SWITH 처럼 사용할 수 있는 함수 표현식
--Case
--WHEN (조건식1) THEN 결과값1
--WHEN (조건식2) THEN 결과값2
--ELSE 결과값3
--END
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_CODE 부서코드, JOB_CODE 직급코드,
   CASE
      WHEN ENT_YN = 'Y' THEN '퇴사자'
      ELSE '근무자'
   END   "근무 여부",
   CASE 
      --WHEN MANAGER_ID IS NULL THEN '관리자'
      WHEN NVL(MANAGER_ID ,0) = 0 THEN '관리자'
      ELSE '사원'
   END "관리자 여부"
   FROM EMPLOYEE;

--NVL(컬럼명|데이터, NULL이 아닐경우 값, NULL일 경우 값)
SELECT EMP_ID 사번, EMP_NAME 사원명, BONUS 보너스,
   NVL(TO_CHAR(BONUS),'X')   "NVL함수",
   NVL2(BONUS, TO_CHAR(BONUS,'0.9'),'X' ) "NVL2 함수" 
   FROM EMPLOYEE;

--숫자 데이터 함수--
-- ABS() : 절대값 표현
SELECT ABS(10), ABS(-10)
FROM DUAL;

--MOD() : 나머지를 반환
SELECT MOD(10,3),MOD(10,2), MOD(10,7)
FROM DUAL;

--ROUND() : 지정한 숫자를 반올림 하는 함수
SELECT ROUND(123.456,0),
   ROUND(123.456,1),
   ROUND(123.456,2),
   ROUND(123.456,-2)
   FROM DUAL;

--CEIL() : 소수점 첫째 자리에서 올림
--FLOOR() : 소수점 이하 자리를 버림
--TRUNC() : 지정한 위치까지 숫자를 버림
SELECT CEIL(123.456),
   FLOOR(123.456),
   TRUNC(123.456,0),
   TRUNC(123.456,1),
   TRUNC(123.456,-2)
FROM DUAL;

--실습2
--EMPLOYEE 테이블에서 입사한 달의 숫자가 홀수 달인 직원의 사번, 사원명, 입사일 정보를 조회
SELECT EMP_ID 사번, EMP_NAME 사원명, SUBSTR(HIRE_DATE ,4,2) 입사일
   FROM EMPLOYEE   --10/11/15
   WHERE MOD(SUBSTR(HIRE_DATE,5,1),2 )=1;
   --WHERE MOD(EXTRACT(MONTH FROM HIRE_DATE),2) =1;

--날짜 데이터
--SYSDATE, MONTHS_BETWEEN, ADD_MONTHS
--EXTRACTM, LAST_DAY, NEXT_DAT
SELECT SYSDATE,
   SYSTIMESTAMP
FROM DUAL;

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS') ,
   TO_CHAR(SYSTIMESTAMP,'YYYY-MM-DD HH:MI:SSFF' ) 
   FROM DUAL;

--NEXT_DAY(날짜, 요일명)
SELECT NEXT_DAY(SYSDATE, '일요일'),
   NEXT_DAY(SYSDATE,'토') ,
   NEXT_DAY(SYSDATE,7 ),   --1:일. 2:월, 3:화, 4:수
   NEXT_DAY(SYSDATE,'SATURDAY')
FROM DUAL;

--데이터 사전(데이터 딕셔너리) : 현재 계정에 설정된 정보를 DB의 테이블 형태로 보관하는 테이블
--기본적으로 시스템의 관리자만 변경 가능
--단, 사용자 계정도 접속한 동안은 변경가능, 변경 후 재접속하면 초기화
SELECT * FROM V$NLS_PARAMETERS;
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

--영문자 요일 조회
SELECT NEXT_DAY(SYSDATE, 'SATURDAY') 
FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

SELECT LAST_DAY(SYSDATE)
FROM DUAL;

--날짜값끼리는 가장 최근 날짜일수록 점점 더 큰값으로 판단
--+,- 연산 가능
SELECT (SYSDATE - 10) "날짜1",
   TRUNC(SYSDATE - TO_DATE('20/03/01', 'RR/MM/DD')) "날짜2",
   TRUNC(TO_DATE('20/03/01','RR/MM/DD') - SYSDATE) "날짜2"
FROM DUAL;

--실습3
--EMPLOYEE 근무 년수가 20년 이상인 사원들의 사번 사원명 부서코ㅡ 입사일 조회
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_CODE 부서코드, HIRE_DATE 입사일
FROM EMPLOYEE 
WHERE ADD_MONTHS(HIRE_DATE,240) <= SYSDATE;

--형변환
-- YYYY 년도 표현(4자리) YY 년도 표현(2자리)
-- MM 월을 숫자로
-- DAY 요일 표현
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') ,
   TO_CHAR(SYSDATE,'MON DY YYYY' ),
   TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY'),
   TO_CHAR(SYSDATE, 'YEAR, Q')   --Q 분기
FROM DUAL;

--Y/R
SELECT TO_CHAR(TO_DATE('200315','YYMMDD'),'YYYY') "결과1",
   TO_CHAR(TO_DATE('200315','RRMMDD'),'RRRR' ) "결과2",
   TO_CHAR(TO_DATE('800315','YYMMDD'),'YYYY') "결과3",
   TO_CHAR(TO_DATE('800315','RRMMDD'), 'RRRR') "결과4" 
FROM DUAL;
--4자리 한번에 입력 받을 경우 문제X
--2자리 입력받는 경우 
--YY는 현 세기 기준
--RR은 반 세기 기준

--SELECT문의 실행 순서
/*
 * 5: SELECT 컬럼명 AS 별칭, 계산, 함수식
 * 1: FROM 테이블명
 * 2: WHERE 조건
 * 3: GROUP BY 그룹을 묶을 컬렴명
 * 4: HAVING 그룹에 대한 조건식, 함수식
 * 6: ORDER BY 컬럼|벌칭|순서
 * 
 * */
--ORDER BY
SELECT EMP_ID, EMP_NAME 이름, SALARY, DEPT_CODE
FROM EMPLOYEE
--ORDER BY EMP_ID;   --기본값은 ASC
ORDER BY EMP_NAME DESC;

--GROUP BY
--부서별 평균
SELECT TRUNC(AVG(SALARY),-3 ) 
FROM EMPLOYEE;
--D1 평균 급여
SELECT TRUNC(AVG(SALARY),-3)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

--특정 컬럼, 계산식을 하나의 그룹으로 묶어 한 테이블 내에서 소그룹 별로 조회 하고자 할 때 선어하는 구문
SELECT DEPT_CODE, TRUNC(AVG(SALARY), -3)
FROM EMPLOYEE
GROUP BY DEPT_CODE 
ORDER BY 1;

--실습 4
--EMPLOYEE 부서별 총 인원, 급여 함계, 급여 평균, 최대 급여, 최소 급여를 부서코드의 기준으로 오름차순 정렬
SELECT * FROM EMPLOYEE;
SELECT NVL(DEPT_CODE,'없음') 부서코드,
   COUNT(*) 인원,
   SUM(SALARY) 급여합계,
   TRUNC(AVG(SALARY),-3) 급여평균,
   MAX(SALARY) 최대급여,
   MIN(SALARY) 최소급여
   FROM EMPLOYEE
   GROUP BY DEPT_CODE
   ORDER BY DEPT_CODE ASC;

--직급코드 별 보너스를 받는 사원의 수를 조회
SELECT JOB_CODE 직급코드, COUNT(BONUS) 인원
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

--실습5
--남성직원과 여성직원의 수를 조회하시오
--GROUP BY에서 주어진 컬럼만이 아닌 함수식도 사용가능
SELECT DECODE(SUBSTR(EMP_NO,8,1),1,'남성',2,'여성' ) 성별,
   COUNT(*) || '명' 직원수
   FROM EMPLOYEE
   GROUP BY DECODE(SUBSTR(EMP_NO,8,1),1,'남성',2,'여성' );

--HAVING 구문
--GROUP BY 한 각 소그룹에 대한 조건을 설정 할 때 그룹함수와 함께 사용하는 구문
SELECT DEPT_CODE,
   AVG(SALARY) 평군
   FROM EMPLOYEE
   WHERE SALARY>3000000
   GROUP BY DEPT_CODE;

SELECT DEPT_CODE,
   AVG(SALARY)  평균
   FROM EMPLOYEE
   GROUP BY DEPT_CODE 
   HAVING AVG(SALARY) >3000000
   ORDER BY 1;


--실습6
--부서별 그룹의 급여 합계 중 900만원을 초과하는 부서의 코드와 급여 합계를 조회
SELECT DEPT_CODE 부서코드, 
   SUM(SALARY)  급여합계
   FROM EMPLOYEE
   GROUP BY DEPT_CODE
   HAVING SUM(SALARY) > 9000000
   ORDER BY 1;

--실습7
--급여합계가 가장 높은 부서를 찾고
--해당부서의 부서코드와 급여 합계를 조회하시오
--)급여합계가 가장 높은 값
--)급여합계가 가장 높은 급여 합계와 부서
SELECT MAX(SUM(SALARY) ) 합계
   FROM EMPLOYEE
   GROUP BY DEPT_CODE;--17,700,000

SELECT DEPT_CODE 부서, 
   SUM(SALARY)
   FROM EMPLOYEE
   GROUP BY DEPT_CODE
   HAVING SUM(SALARY) >= 17700000;

--SUB QUERY
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY ) = (SELECT MAX(SUM(SALARY) )
                  FROM EMPLOYEE
                  GROUP BY DEPT_CODE);

   
   --*********************************3
   --1. 직원명과 주민번호를 조회함
--  단, 주민번호 9번째 자리부터 끝까지는 '*'문자로 채움
--  예 : 홍길동 771120-1******
SELECT EMP_NAME 직원명,
       RPAD(SUBSTR(EMP_NO,1,8), 14,'*') 주민번호
FROM EMPLOYEE;


--2. 직원명, 직급코드, 연봉(원) 조회
--  단, 연봉은 ￦57,000,000 으로 표시되게 함
--     연봉은 보너스포인트가 적용된 1년치 급여임
SELECT EMP_NAME 직원명, JOB_CODE 직급코드, 
       TO_CHAR((SALARY + (SALARY * NVL(BONUS, 0)))*12, 'L999,999,999') "연봉(원)"
FROM EMPLOYEE;


--3. 부서코드가 D5, D9인 직원들 중에서 2004년도에 입사한 직원의 
--   수 조회함.
--   사번 사원명 부서코드 입사일

SELECT EMP_ID 사번, EMP_NAME 사원명,
       DEPT_CODE 부서코드, HIRE_DATE 입사일
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D5' OR DEPT_CODE ='D9')
AND SUBSTR(HIRE_DATE, 1, 2) = 04;


--4. 직원명, 입사일, 입사한 달의 근무일수 조회
--   단, 주말도 포함함
SELECT EMP_NAME 직원명, 
       HIRE_DATE 입사일,
       LAST_DAY(HIRE_DATE) - HIRE_DATE+1 "입사한 달의 근무일수"
FROM EMPLOYEE;

--5. 직원명, 부서코드, 생년월일, 나이(만) 조회
--   단, 생년월일은 주민번호에서 추출해서, 
--   ㅇㅇ년 ㅇㅇ월 ㅇㅇ일로 출력되게 함.
--   나이는 주민번호에서 추출해서 날짜데이터로 변환한 다음, 계산함
SELECT EMP_NAME, DEPT_CODE, 
      SUBSTR(EMP_NO, 1, 2) || '년 ' || 
      SUBSTR(EMP_NO, 3, 2) || '월 ' || 
      SUBSTR(EMP_NO, 5, 2) || '일 ' 생년월일,
      EXTRACT(YEAR FROM SYSDATE) - 
      EXTRACT(YEAR FROM(TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD'))) + 1 나이
FROM EMPLOYEE
WHERE EMP_ID NOT IN (200, 201, 
214);

--6. 직원들의 입사일로 부터 년도만 가지고, 각 년도별 입사인원수를 구하시오.
--  아래의 년도에 입사한 인원수를 조회하시오.
--  => to_char, decode, sum 사용
--
--	-------------------------------------------------------------
--	전체직원수   2001년   2002년   2003년   2004년
--	-------------------------------------------------------------
SELECT COUNT(*) 전체직원수, 
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2001', 1)) "2001년",
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2002', 1)) "2002년",
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2003', 1)) "2003년",
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2004', 1)) "2004년"
FROM EMPLOYEE;


--7.  부서코드가 D5이면 총무부, D6이면 기획부, D9이면 영업부로 처리하시오.
--   단, 부서코드가 D5, D6, D9 인 직원의 정보만 조회함
--  => case 사용
--   부서코드 기준 오름차순 정렬함.

SELECT EMP_NAME 사원명, DEPT_CODE 부서코드,
CASE
  WHEN DEPT_CODE = 'D5' THEN '총무부'
  WHEN DEPT_CODE = 'D6' THEN '기획부'
  WHEN DEPT_CODE = 'D9' THEN '영업부'
END "부서명"
FROM EMPLOYEE  
WHERE DEPT_CODE IN('D5', 'D6', 'D9')
ORDER BY 2;

-- GROUP BY : 주어진 결과를 특정 소그룹으로 편성할 때 사용하는 문법
-- HAVING : 그룹 내의 조건을 설정할 때 사용한다.

/*
 * - 쿼리 실행 순서 -
 * 5: SELECT 컬럼명
 * 1: FROM 테이블명
 * 2: WHERE 조건식
 * 3: GROUP BY 컬럼명
 * 4: HAVING 그룹 내의 조건식
 * 6: ORDER BY 표현식
 */

-- 실습 1
-- EMPLOYEE 테이블에서 직급별 그룹을 편성하여
-- 직급코드, 급여합계, 급여평균, 인원수를 조회
-- 단, 인원수는 3명을 초과하는 직급만을 조회
SELECT JOB_CODE, SUM(SALARY), TRUNC(AVG(SALARY),-2), COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE 
HAVING COUNT(*)  > 3
ORDER BY 4 DESC;



SELECT
	JOB_CODE 직급코드,
	SUM(SALARY) 급여합계,
	TRUNC(AVG(SALARY),-2) 급여평균,
	COUNT(*) 인원수
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING COUNT(*) > 3
ORDER BY 4 DESC;

-- DECODE()
-- DECODE(컬럼명, 결과1, 값1, 결과2, 값2, ...., 기본값)
SELECT
	EMP_NAME 사원명,
	DECODE(SUBSTR(EMP_NO,8,1),1,'남성',2,'여성') 성별
FROM EMPLOYEE;

SELECT EMP_NAME 사원명, 
	DECODE (SUBSTR(EMP_NO,8,1),1,'남성',2,'여성' ) 성별
	FROM EMPLOYEE;

-- SET OPERATOR --
-- 두 개 이상의 SELECT 한 결과를 합치거나, 중복을 별도로 제거하거나 하는
-- 집합 형태의 결과로 조회하는 명령어

-- 합집합 --
-- UNION :
-- 두 개 이상의 SELECT 한 결과를 구하는 명령어, 중복이 있을 경우 중복되는 결과는 1번만 보여준다.
-- UNION ALL :
-- 두 개 이상의 SELECT 한 결과를 보여주되, 중복이 있을 경우 그대로 조회하여 보여준다.

-- 교집합 --
-- INTERSECT : 두 개 이상의 결과 중 중복되는 결과만 보여준다.

-- 차집합 --
-- MINUS : 두 개 이상의 결과 중 첫번째 결과만이 가진 내용을 보여주는 명령어

-- SELECT 결과인 A와 B를 하나로 합치는 경우
-- A와 B의 컬럼 개수와 자료형은 같아야 한다!!! 반드시!!

-- UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION --합칩합
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY 1;

-- UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000
ORDER BY 1;


-- INTERSECT --교집합
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- MINUS --차집합
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


-- JOIN --
-- 두 개 이상의 테이블을 하나로 합쳐서 사용하는 명령

-- 만약에 'J6'라는 직급을 가진 사원들의 근무 부서명이 궁금하다면??
SELECT
	EMP_NAME, JOB_CODE, DEPT_CODE
FROM EMPLOYEE
WHERE JOB_CODE = 'J6'	--D1, D8

SELECT *
FROM DEPARTMENT;

SELECT
	DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_ID IN('D1','D8');

-- 오라클 전용 문법 / ANSI 표준 문법

-- 오라클 전용 문법
-- FROM 절에 ',' 기호를 붙여 합치게 될 테이블들을 나열
-- WHERE 조건을 통해서 합칠 테이블들의 공통 사항을 작성
SELECT
	EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

SELECT
	EMP_ID, EMP_NAME,E.JOB_CODE,J.JOB_CODE,JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

SELECT *
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;
-------------------------------------------

-- ANSI 표준 문법
-- 조인하고자 하는 테이블을 FROM 구문 다음에
-- JOIN 테이블명 ON() | USING() 구문을 사용하여
-- 두 개 이상의 테이블을 하나로 합치는 방법

-- 두 개의 테이블에서 공통 컬럼의 이름이 다를 경우
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
LEFT OUTER JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID;

-- 두 개의 테이블에서 공통 컬럼의 이름이 같은 경우
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- 실습 2
-- EMPLOYEE 테이블의 직원 급여 정보와 SAL_GRADE의 급여 등급을 합쳐서
-- 사번, 사원명, 급여등급, 등급 기준 최소급여, 최대급여를 조회
SELECT * FROM SAL_GRADE;
-- ANSI
SELECT
	EMP_ID 사번, EMP_NAME 사원명, SAL_LEVEL 급여등급, MIN_SAL 최소급여, MAX_SAL 최대급여
FROM EMPLOYEE 
JOIN SAL_GRADE USING(SAL_LEVEL);
-- ORACLE
SELECT
	EMP_ID 사번, EMP_NAME 사원명, E.SAL_LEVEL 급여등급, MIN_SAL 최소급여, MAX_SAL 최대급여
FROM EMPLOYEE E, SAL_GRADE SG
WHERE E.SAL_LEVEL = SG.SAL_LEVEL;

SELECT  EMP_ID 사번, EMP_NAME 사원명, E.SAL_LEVEL 급여등급, MIN_SAL 최소급여, MAX_SAL 최대급여
FROM EMPLOYEE E, SAL_GRADE SG
WHERE E.SAL_LEVEL = SG.SAL_LEVEL ;

-- 실습 3
-- DEPARTMENT 테이블의 위치 정보
-- LOCATION 테이블을 조인하여
-- 각 부서별 근무지 위치를 조회
-- 부서코드, 부서명, 근무지 코드, 근무지 위치
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;
-- ANSI
SELECT
	DEPT_ID 부서코드, DEPT_TITLE 부서명, LOCATION_ID "근무지 코드", LOCAL_NAME "근무지 위치"
FROM DEPARTMENT
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE);
-- ORACLE
SELECT
	DEPT_ID 부서코드, DEPT_TITLE 부서명, LOCATION_ID "근무지 코드", LOCAL_NAME "근무지 위치"
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID=LOCAL_CODE;

-- INNER JOIN / OUTER JON --
-- 두 개 이상의 테이블을 합칠때
-- INNER JOIN은 둘 모두 일치하는 데이터만 합치고
-- OUTER JOIN은 둘 중 하나, 혹은 둘 모두가 가진 모든 값을 합칠때 사용

-- INNER JOIN
SELECT DISTINCT DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
ORDER BY 1;

-- OUTER JOIN
-- LEFT [OUTER] JOIN : 두 테이블 중 원본(좌측) 테이블의 정보를 모두 포함하여 조회
-- RIGHT [OUTER] JOIN : 두 테이블 중 JOIN에 명시한 테이블의 정보를 모두 포함하여 조회
-- FULL [OUTER] JOIN : 두 테이블이 가진 데이터 중 서로가 가지지 않은 값이라도 모두 포함하여 조회

-- LEFT JOIN
-- ANSI 표준
SELECT DEPT_CODE, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID);
-- ORACLE 구문
SELECT DEPT_CODE, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE=DEPT_ID(+);

-- RIGHT JOIN
-- ANSI 표준
SELECT DEPT_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID);
-- ORACLE 구문
SELECT DEPT_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+)=DEPT_ID;

-- FULL JOIN
-- ANSI 표준
SELECT DEPT_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID);
-- ORACLE 구문에서는 FULL JOIN을 지원하지 않는다.


-- CROSS JOIN
SELECT EMP_NAME, NATIONAL_CODE
FROM EMPLOYEE
CROSS JOIN NATIONAL
ORDER BY 1;
-- 카테시안 곱

-- SELF JOIN
-- 자기 자신을 조인하는 방법
-- 한 테이블의 정보 중 값 비교가 필요한 정보들을 계산하여 조회하는 방식

-- 직원의 정보와 직원을 관리하는 매니저의 정보를 조회
-- ANSI
SELECT * FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID)
ORDER BY 1;


-- ORACLE
SELECT
	E.EMP_ID 사번,
	E.EMP_NAME 사원명,
	E.MANAGER_ID "관리자 사번",
	M.EMP_NAME 관리자명
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+)
ORDER BY 1;


-- 다중 JOIN --
-- 여러개의 테이블을 JOIN하는 것
-- 일반 조인과 선언 방식은 같으나, 앞서 조인한 결과를 기준으로
-- 이후에 조인할 테이블을 연결 짓는다.
-- 따라서 조인 순서에 반드시 주의해야 한다.

-- ANSI 표준
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE);
-- ORACLE 구문
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE=DEPT_ID AND LOCATION_ID=LOCAL_CODE;


-- 실습 4
-- 직급이 대리이면서, 아시아 지역에서 근무하는 사원 조회
-- 사번, 사원명, 직급명, 부서명, 근무지역명, 급여
SELECT * FROM JOB; --J6
SELECT * FROM LOCATION; --L1,L2,L3
SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;

-- ANSI
SELECT
	EMP_ID 사번,
	EMP_NAME 사원명,
	JOB_NAME 직급명,
	DEPT_TITLE 부서명,
	LOCAL_NAME 근무지역명,
	SALARY 급여
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE AND LOCAL_NAME LIKE 'ASIA%')
WHERE JOB_NAME='대리';
--WHERE JOB_CODE='J6' AND LOCAL_CODE IN('L1','L2','L3');
-- ORACLE
SELECT
	EMP_ID 사번,
	EMP_NAME 사원명,
	JOB_NAME 직급명,
	DEPT_TITLE 부서명,
	LOCAL_NAME 근무지역명,
	SALARY 급여
FROM EMPLOYEE E, JOB J, DEPARTMENT, LOCATION
WHERE E.JOB_CODE=J.JOB_CODE AND DEPT_CODE=DEPT_ID AND LOCATION_ID=LOCAL_CODE
	AND J.JOB_NAME='대리'
	AND LOCAL_NAME LIKE 'ASIA%';


-- 실습 5
-- 한국(KO)과 일본(JP)에 근무하는 근무 직원들의 정보를 조회하시오.
-- 사원명, 부서명, 지역명, 국가명

-- ANSI
SELECT EMP_NAME 사원명, DEPT_TITLE 부서명, LOCAL_NAME 지역명, NATIONAL_NAME 국가명
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME IN('한국','일본');
-- ORACLE
SELECT EMP_NAME 사원명, DEPT_TITLE 부서명, LOCAL_NAME 지역명, NATIONAL_NAME 국가명
FROM EMPLOYEE, DEPARTMENT, LOCATION L, NATIONAL N
WHERE DEPT_CODE=DEPT_ID AND LOCATION_ID=LOCAL_CODE AND L.NATIONAL_CODE=N.NATIONAL_CODE
	AND N.NATIONAL_NAME IN('한국','일본');

----------------------------------------------------
-- Sub Query --
-- 주가 되는 메인 쿼리 안에서 조건이나 하나의 검색을 위한 다른 쿼리를 추가하는 기법

-- 단일 행 서브쿼리
-- 결과값이 1개 나오는 서브쿼리
-- EX) 최소 급여를 받는 사원의 정보 조회
SELECT MIN(SALARY) FROM EMPLOYEE; --1380000
SELECT * FROM EMPLOYEE WHERE SALARY=1380000;

SELECT * FROM EMPLOYEE WHERE SALARY=(SELECT MIN(SALARY) FROM EMPLOYEE);

-- 다중 행 서브쿼리
-- 결과값이 여러줄 나오는 서브쿼리
-- 각 직급별 최소 급여
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

SELECT * FROM EMPLOYEE
WHERE SALARY IN(SELECT MIN(SALARY)
				FROM EMPLOYEE
				GROUP BY JOB_CODE);
			
-- 다중 열 다중 행 서브쿼리
-- 여러 컬럼과 여러 줄을 가진 서브쿼리를 사용하여 결과를 조회
SELECT * FROM EMPLOYEE
WHERE (JOB_CODE,SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
							FROM EMPLOYEE
							GROUP BY JOB_CODE);

-- 다중 행 다중 열 서브쿼리 와 일반 단일 행 서브쿼리 차이
-- EX) 퇴사한 여직원과 같은 직급, 같은 부서에 근무하는 직원들의 정보 조회
SELECT *
FROM EMPLOYEE
WHERE ENT_YN='Y';

SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_CODE FROM EMPLOYEE WHERE ENT
_YN='Y')
	AND JOB_CODE IN (SELECT JOB_CODE FROM EMPLOYEE WHERE ENT_YN='Y')
	AND EMP_NAME <> (SELECT EMP_NAME FROM EMPLOYEE WHERE ENT_YN='Y');

-- 다중 열 다중 행 서브쿼리로 변경
SELECT * FROM EMPLOYEE
WHERE (DEPT_CODE,JOB_CODE) IN (SELECT DEPT_CODE,JOB_CODE
							   FROM EMPLOYEE
							   WHERE ENT_YN='Y')
	AND EMP_NAME != (SELECT EMP_NAME FROM EMPLOYEE WHERE ENT_YN='Y');
				

--*******************************4
-- 서브 쿼리의 사용 위치
-- SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY, JOIN
-- DML: INSERT, UPDATE, DELETE
-- DDL: CREATE TABLE, CREATE VIEW
-- 어느 위치든 사용할 수 있다.

-- Inline View(인라인 뷰)



-- SET OPERATOR
-- 합집합
-- UNION
-- UNION ALL
-- 교집합 INTERSECT
-- 차집합 MINUS

--JOIN --
--두 개 이상의 테이블의 결과를 하나의 테이블 형태로 합쳐서 사용하는 방법
--INNER JOIN 합치려는 테이블의 데이터를 각각이 모두 일치하는 정보만 연결하여 조히
--OUTER JOIN 
--	LEFT: 좌측 테이블의 정보를 모두 포함 
--	RIGHT: 우측 테이블의 정보를 모두 포함
--	FULL: 양측

--CROSS JOIN, SELF JOIN, 다중 JOIN

--SUB QUERY: 메인쿼리안에 또 하나의 쿼리를 추가-- SELECT문안에 SELECT문

--인라인뷰
--FROM 위치에 사용되는 서브쿼리
--서브쿼리의 RESULT SET을 활용하여 데이터를 조회할 때 사용할 수 있다.
--이때 기존의 테이블을 대체한다는 의미에서 FROM 구문의 서브쿼리를 Inline View라고 부른다.
SELECT *
FROM(
	SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
	FROM EMPLOYEE
	JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
	JOIN JOB USING(JOB_CODE));

--TOP-N 분석 조호
--맛있는 음식 상위5개, 가장많이팔린아이스크림6게

--ROWNUM: 데이터를 조회할때 각 행의 번호를 매겨주는 함수
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM < 6;

--연습
--급여기준으로 가장 높은 급여를 받는 사원
--상위 5명 조회하겨 사번, 사원명, 급여를 출력

SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT ROWNUM, A.*
FROM (SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC) A
WHERE ROWNUM < 6;

--RANK(): 순위를 매기는 함수	<==> DENESE_RANK(): 순위를 매기는 함수
--1								1
--2								2
--3								2
--4								3
SELECT EMP_NAME, SALARY,
RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM EMPLOYEE;

SELECT *
FROM(SELECT EMP_NAME, SALARY,
RANK() OVER(ORDER BY SALARY DESC) "순위"
FROM  EMPLOYEE)
WHERE 순위 < 4;

SELECT EMP_NAME, SALARY,
	DENSE_RANK() OVER(ORDER BY SALARY DESC) "순위"
	FROM EMPLOYEE;
	
--실습5
--EMPLOYEE 
--보너스를 포함한 연봉이 가장 높은 사원 상위 5명을 RANK() 함수를 활용하여 조회
--사번, 사원명, 부서명, 직급명, 연봉(보너스 포함)
SELECT *
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE,
(SALARY + (SALARY)*NVL(BONUS,0)+1) *12 연봉
RANK() OVER(ORDER BY (SALARY + (SALARY)*NVL(BONUS,0)+1) *12 순위 )
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE )
JOIN JOB USING(JOB_NAME))
WHERE 순위 < 6;

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE,
SALARY + (SALARY)*NVL(BONUS,0)*12  연봉,
RANK() OVER(ORDER BY SALARY + (SALARY)*NVL(BONUS,0)*12 DESC ) 순위
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

--WITH AS
--동일한 서브쿼리를 중복해서 사용할때 이를 별칭화 하여 사용하도록 하는 구문
--사용형식: WITH 별칭 AS
--**인라인 뷰에서만 가능
WITH TOP_N_SAL AS(
	SELECT EMP_NAME, SALARY
	FROM EMPLOYEE
	ORDER BY SALARY DESC
) SELECT *
FROM TOP_N_SAL;

--부서 별 급여 합계가 전체 부서 급여 총합의 20%보다 많은 부서의 부서명과, 부서급여 합계를 조회
--1) 일반 단일행 서브쿼리
--전체 부서의 급여 합계의 20%조회
SELECT SUM(SALARY)*0.2, DEPT_CODE 부서명
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > (SELECT SUM(SALARY)*0.2 FROM EMPLOYEE);

--2) 인라인 뷰 활용
--서브쿼리
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE

--인라인 뷰
SELECT
	DEPT_CODE,
	SUMSAL
FROM
	(
	SELECT
		DEPT_CODE,
		SUM(SALARY) SUMSAL
	FROM
		EMPLOYEE
	GROUP BY
		DEPT_CODE )
WHERE SUMSAL > (SELECT SUM(SALARY)*0.2 FROM EMPLOYEE) 

--WITH AS를 이용
WITH SUM_SAL_VIEW
AS (
	SELECT DEPT_CODE, SUM(SALARY) SUMSAL
	FROM EMPLOYEE
	GROUP BY DEPT_CODE
) SELECT *
FROM SUM_SAL_VIEW
WHERE SUMSAL > (SELECT SUM(SALARY)*0.2 FROM EMPLOYEE);

--WITH AS 여러개 등록
WITH SUM_SAL AS (SELECT  SUM(SALARY) FROM EMPLOYEE), 
	AVG_SAL AS (SELECT AVG(SALARY) FROM EMPLOYEE)
	SELECT * FROM SUM_SAL
	UNION ALL
	SELECT * FROM AVG_SAL
	UNION ALL
	SELECT * FROM SUM_SAL;

--상호 연관 쿼리: 상관쿼리
--일반적으로 서브쿼리는 서브쿼리, 메인쿼리는 서브쿼리의 결과만 받아서 실행하는 방식과 다르게
--메인쿼리가 사용하는 컬럼값, 게산식 등을 서브쿼리에 적용하여 서브쿼리 실행 시 메인 쿼리의 값도 함께 사용하는 방식

--사원의 직급에 다른 급여 평균보다 많이 받는 사원의 정보를 조회
SELECT JOB_CODE, TRUNC(AVG(SALARY), -3)
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE E
WHERE SALARY > (
	SELECT AVG(SALARY)
	FROM EMPLOYEE E2
	WHERE E.JOB_CODE = E.JOB_CODE 
);

--스칼럿 쿼리
--단일행 서브쿼리 +상호연관 서브쿼리
--SELECT, WHERE, ORDER BY 절에 사용
--보통은 SELECT에 많이 사용하기 때문에 SELECT LIST라고도 한다.

SELECT EMP_ID, 
	EMP_NAME,
	MANAGER_ID,
	NVL((SELECT EMP_NAME FROM EMPLOYEE M
		WHERE E.MANAGER_ID = M.EMP_ID), '없음') 관리자이름
		FROM EMPLOYEE E
		ORDER BY 관리자이름, EMP_ID;


--데이터사전
--데이터베이스 안에서 사용자 정보동의 설정을 관리하는 테이블