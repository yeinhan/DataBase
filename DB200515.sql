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

SELECT * FROM EMPLOYEE ;
--연습문제1
--연습문제2
SELECT EMP_NAME 이름, JOB_CODE 직급코드,
   TRUNC((SALARY*12+NVL(BONUS ,0))) 연봉 
FROM EMPLOYEE;
--연습문제3
SELECT EMP_ID 사번, EMP_NAME 사원명   ,
   DEPT_CODE 부서코드,
   HIRE_DATE 입사일
   FROM EMPLOYEE
   WHERE (DEPT_CODE = 'D5' OR DEPT_CODE ='D9') AND EXTRACT(YEAR FROM HIRE_DATE)=2004 ;
--연습문제4
SELECT EMP_NAME 사원명, 
   TO_CHAR(HIRE_DATE,'YYYY-MM-DD') 입사일,
   LAST_DAY(HIRE_DATE)-HIRE_DATE "입사달 근무일수"
   FROM EMPLOYEE;
--연습문제5
SELECT EMP_NAME 직원명,
   DEPT_CODE 부서코드,
   SUBSTR(EMP_NO,1,2) || '년' || SUBSTR(EMP_NO ,3,2) || '월' || SUBSTR(EMP_NO ,5,2) || '일' 
   FROM EMPLOYEE;
--연습문제6
SELECT COUNT(*) 전체직원수,
   DECODE(SUBSTR(HIRE_DATE,2,1),1, )    