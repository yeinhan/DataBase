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
				