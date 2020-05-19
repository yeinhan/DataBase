   --*********************************3
   --1. ������� �ֹι�ȣ�� ��ȸ��
--  ��, �ֹι�ȣ 9��° �ڸ����� �������� '*'���ڷ� ä��
--  �� : ȫ�浿 771120-1******
SELECT EMP_NAME ������,
       RPAD(SUBSTR(EMP_NO,1,8), 14,'*') �ֹι�ȣ
FROM EMPLOYEE;


--2. ������, �����ڵ�, ����(��) ��ȸ
--  ��, ������ ��57,000,000 ���� ǥ�õǰ� ��
--     ������ ���ʽ�����Ʈ�� ����� 1��ġ �޿���
SELECT EMP_NAME ������, JOB_CODE �����ڵ�, 
       TO_CHAR((SALARY + (SALARY * NVL(BONUS, 0)))*12, 'L999,999,999') "����(��)"
FROM EMPLOYEE;


--3. �μ��ڵ尡 D5, D9�� ������ �߿��� 2004�⵵�� �Ի��� ������ 
--   �� ��ȸ��.
--   ��� ����� �μ��ڵ� �Ի���

SELECT EMP_ID ���, EMP_NAME �����,
       DEPT_CODE �μ��ڵ�, HIRE_DATE �Ի���
FROM EMPLOYEE
WHERE (DEPT_CODE = 'D5' OR DEPT_CODE ='D9')
AND SUBSTR(HIRE_DATE, 1, 2) = 04;


--4. ������, �Ի���, �Ի��� ���� �ٹ��ϼ� ��ȸ
--   ��, �ָ��� ������
SELECT EMP_NAME ������, 
       HIRE_DATE �Ի���,
       LAST_DAY(HIRE_DATE) - HIRE_DATE+1 "�Ի��� ���� �ٹ��ϼ�"
FROM EMPLOYEE;

--5. ������, �μ��ڵ�, �������, ����(��) ��ȸ
--   ��, ��������� �ֹι�ȣ���� �����ؼ�, 
--   ������ ������ �����Ϸ� ��µǰ� ��.
--   ���̴� �ֹι�ȣ���� �����ؼ� ��¥�����ͷ� ��ȯ�� ����, �����
SELECT EMP_NAME, DEPT_CODE, 
      SUBSTR(EMP_NO, 1, 2) || '�� ' || 
      SUBSTR(EMP_NO, 3, 2) || '�� ' || 
      SUBSTR(EMP_NO, 5, 2) || '�� ' �������,
      EXTRACT(YEAR FROM SYSDATE) - 
      EXTRACT(YEAR FROM(TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD'))) + 1 ����
FROM EMPLOYEE
WHERE EMP_ID NOT IN (200, 201, 
214);

--6. �������� �Ի��Ϸ� ���� �⵵�� ������, �� �⵵�� �Ի��ο����� ���Ͻÿ�.
--  �Ʒ��� �⵵�� �Ի��� �ο����� ��ȸ�Ͻÿ�.
--  => to_char, decode, sum ���
--
--	-------------------------------------------------------------
--	��ü������   2001��   2002��   2003��   2004��
--	-------------------------------------------------------------
SELECT COUNT(*) ��ü������, 
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2001', 1)) "2001��",
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2002', 1)) "2002��",
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2003', 1)) "2003��",
      COUNT(DECODE(TO_CHAR(EXTRACT(YEAR FROM HIRE_DATE)), '2004', 1)) "2004��"
FROM EMPLOYEE;


--7.  �μ��ڵ尡 D5�̸� �ѹ���, D6�̸� ��ȹ��, D9�̸� �����η� ó���Ͻÿ�.
--   ��, �μ��ڵ尡 D5, D6, D9 �� ������ ������ ��ȸ��
--  => case ���
--   �μ��ڵ� ���� �������� ������.

SELECT EMP_NAME �����, DEPT_CODE �μ��ڵ�,
CASE
  WHEN DEPT_CODE = 'D5' THEN '�ѹ���'
  WHEN DEPT_CODE = 'D6' THEN '��ȹ��'
  WHEN DEPT_CODE = 'D9' THEN '������'
END "�μ���"
FROM EMPLOYEE  
WHERE DEPT_CODE IN('D5', 'D6', 'D9')
ORDER BY 2;

-- GROUP BY : �־��� ����� Ư�� �ұ׷����� ���� �� ����ϴ� ����
-- HAVING : �׷� ���� ������ ������ �� ����Ѵ�.

/*
 * - ���� ���� ���� -
 * 5: SELECT �÷���
 * 1: FROM ���̺��
 * 2: WHERE ���ǽ�
 * 3: GROUP BY �÷���
 * 4: HAVING �׷� ���� ���ǽ�
 * 6: ORDER BY ǥ����
 */

-- �ǽ� 1
-- EMPLOYEE ���̺��� ���޺� �׷��� ���Ͽ�
-- �����ڵ�, �޿��հ�, �޿����, �ο����� ��ȸ
-- ��, �ο����� 3���� �ʰ��ϴ� ���޸��� ��ȸ
SELECT JOB_CODE, SUM(SALARY), TRUNC(AVG(SALARY),-2), COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE 
HAVING COUNT(*)  > 3
ORDER BY 4 DESC;



SELECT
	JOB_CODE �����ڵ�,
	SUM(SALARY) �޿��հ�,
	TRUNC(AVG(SALARY),-2) �޿����,
	COUNT(*) �ο���
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING COUNT(*) > 3
ORDER BY 4 DESC;

-- DECODE()
-- DECODE(�÷���, ���1, ��1, ���2, ��2, ...., �⺻��)
SELECT
	EMP_NAME �����,
	DECODE(SUBSTR(EMP_NO,8,1),1,'����',2,'����') ����
FROM EMPLOYEE;

SELECT EMP_NAME �����, 
	DECODE (SUBSTR(EMP_NO,8,1),1,'����',2,'����' ) ����
	FROM EMPLOYEE;

-- SET OPERATOR --
-- �� �� �̻��� SELECT �� ����� ��ġ�ų�, �ߺ��� ������ �����ϰų� �ϴ�
-- ���� ������ ����� ��ȸ�ϴ� ��ɾ�

-- ������ --
-- UNION :
-- �� �� �̻��� SELECT �� ����� ���ϴ� ��ɾ�, �ߺ��� ���� ��� �ߺ��Ǵ� ����� 1���� �����ش�.
-- UNION ALL :
-- �� �� �̻��� SELECT �� ����� �����ֵ�, �ߺ��� ���� ��� �״�� ��ȸ�Ͽ� �����ش�.

-- ������ --
-- INTERSECT : �� �� �̻��� ��� �� �ߺ��Ǵ� ����� �����ش�.

-- ������ --
-- MINUS : �� �� �̻��� ��� �� ù��° ������� ���� ������ �����ִ� ��ɾ�

-- SELECT ����� A�� B�� �ϳ��� ��ġ�� ���
-- A�� B�� �÷� ������ �ڷ����� ���ƾ� �Ѵ�!!! �ݵ��!!

-- UNION
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
UNION --��Ĩ��
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


-- INTERSECT --������
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;

-- MINUS --������
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
MINUS
SELECT EMP_ID, EMP_NAME,DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000;


-- JOIN --
-- �� �� �̻��� ���̺��� �ϳ��� ���ļ� ����ϴ� ���

-- ���࿡ 'J6'��� ������ ���� ������� �ٹ� �μ����� �ñ��ϴٸ�??
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

-- ����Ŭ ���� ���� / ANSI ǥ�� ����

-- ����Ŭ ���� ����
-- FROM ���� ',' ��ȣ�� �ٿ� ��ġ�� �� ���̺���� ����
-- WHERE ������ ���ؼ� ��ĥ ���̺���� ���� ������ �ۼ�
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

-- ANSI ǥ�� ����
-- �����ϰ��� �ϴ� ���̺��� FROM ���� ������
-- JOIN ���̺�� ON() | USING() ������ ����Ͽ�
-- �� �� �̻��� ���̺��� �ϳ��� ��ġ�� ���

-- �� ���� ���̺��� ���� �÷��� �̸��� �ٸ� ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
LEFT OUTER JOIN DEPARTMENT ON DEPT_CODE=DEPT_ID;

-- �� ���� ���̺��� ���� �÷��� �̸��� ���� ���
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE);

-- �ǽ� 2
-- EMPLOYEE ���̺��� ���� �޿� ������ SAL_GRADE�� �޿� ����� ���ļ�
-- ���, �����, �޿����, ��� ���� �ּұ޿�, �ִ�޿��� ��ȸ
SELECT * FROM SAL_GRADE;
-- ANSI
SELECT
	EMP_ID ���, EMP_NAME �����, SAL_LEVEL �޿����, MIN_SAL �ּұ޿�, MAX_SAL �ִ�޿�
FROM EMPLOYEE 
JOIN SAL_GRADE USING(SAL_LEVEL);
-- ORACLE
SELECT
	EMP_ID ���, EMP_NAME �����, E.SAL_LEVEL �޿����, MIN_SAL �ּұ޿�, MAX_SAL �ִ�޿�
FROM EMPLOYEE E, SAL_GRADE SG
WHERE E.SAL_LEVEL = SG.SAL_LEVEL;

SELECT  EMP_ID ���, EMP_NAME �����, E.SAL_LEVEL �޿����, MIN_SAL �ּұ޿�, MAX_SAL �ִ�޿�
FROM EMPLOYEE E, SAL_GRADE SG
WHERE E.SAL_LEVEL = SG.SAL_LEVEL ;

-- �ǽ� 3
-- DEPARTMENT ���̺��� ��ġ ����
-- LOCATION ���̺��� �����Ͽ�
-- �� �μ��� �ٹ��� ��ġ�� ��ȸ
-- �μ��ڵ�, �μ���, �ٹ��� �ڵ�, �ٹ��� ��ġ
SELECT * FROM DEPARTMENT;
SELECT * FROM LOCATION;
-- ANSI
SELECT
	DEPT_ID �μ��ڵ�, DEPT_TITLE �μ���, LOCATION_ID "�ٹ��� �ڵ�", LOCAL_NAME "�ٹ��� ��ġ"
FROM DEPARTMENT
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE);
-- ORACLE
SELECT
	DEPT_ID �μ��ڵ�, DEPT_TITLE �μ���, LOCATION_ID "�ٹ��� �ڵ�", LOCAL_NAME "�ٹ��� ��ġ"
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID=LOCAL_CODE;

-- INNER JOIN / OUTER JON --
-- �� �� �̻��� ���̺��� ��ĥ��
-- INNER JOIN�� �� ��� ��ġ�ϴ� �����͸� ��ġ��
-- OUTER JOIN�� �� �� �ϳ�, Ȥ�� �� ��ΰ� ���� ��� ���� ��ĥ�� ���

-- INNER JOIN
SELECT DISTINCT DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
ORDER BY 1;

-- OUTER JOIN
-- LEFT [OUTER] JOIN : �� ���̺� �� ����(����) ���̺��� ������ ��� �����Ͽ� ��ȸ
-- RIGHT [OUTER] JOIN : �� ���̺� �� JOIN�� ����� ���̺��� ������ ��� �����Ͽ� ��ȸ
-- FULL [OUTER] JOIN : �� ���̺��� ���� ������ �� ���ΰ� ������ ���� ���̶� ��� �����Ͽ� ��ȸ

-- LEFT JOIN
-- ANSI ǥ��
SELECT DEPT_CODE, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID);
-- ORACLE ����
SELECT DEPT_CODE, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE=DEPT_ID(+);

-- RIGHT JOIN
-- ANSI ǥ��
SELECT DEPT_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID);
-- ORACLE ����
SELECT DEPT_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+)=DEPT_ID;

-- FULL JOIN
-- ANSI ǥ��
SELECT DEPT_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID);
-- ORACLE ���������� FULL JOIN�� �������� �ʴ´�.


-- CROSS JOIN
SELECT EMP_NAME, NATIONAL_CODE
FROM EMPLOYEE
CROSS JOIN NATIONAL
ORDER BY 1;
-- ī�׽þ� ��

-- SELF JOIN
-- �ڱ� �ڽ��� �����ϴ� ���
-- �� ���̺��� ���� �� �� �񱳰� �ʿ��� �������� ����Ͽ� ��ȸ�ϴ� ���

-- ������ ������ ������ �����ϴ� �Ŵ����� ������ ��ȸ
-- ANSI
SELECT * FROM EMPLOYEE E
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID)
ORDER BY 1;


-- ORACLE
SELECT
	E.EMP_ID ���,
	E.EMP_NAME �����,
	E.MANAGER_ID "������ ���",
	M.EMP_NAME �����ڸ�
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+)
ORDER BY 1;


-- ���� JOIN --
-- �������� ���̺��� JOIN�ϴ� ��
-- �Ϲ� ���ΰ� ���� ����� ������, �ռ� ������ ����� ��������
-- ���Ŀ� ������ ���̺��� ���� ���´�.
-- ���� ���� ������ �ݵ�� �����ؾ� �Ѵ�.

-- ANSI ǥ��
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE);
-- ORACLE ����
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION
WHERE DEPT_CODE=DEPT_ID AND LOCATION_ID=LOCAL_CODE;


-- �ǽ� 4
-- ������ �븮�̸鼭, �ƽþ� �������� �ٹ��ϴ� ��� ��ȸ
-- ���, �����, ���޸�, �μ���, �ٹ�������, �޿�
SELECT * FROM JOB; --J6
SELECT * FROM LOCATION; --L1,L2,L3
SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;

-- ANSI
SELECT
	EMP_ID ���,
	EMP_NAME �����,
	JOB_NAME ���޸�,
	DEPT_TITLE �μ���,
	LOCAL_NAME �ٹ�������,
	SALARY �޿�
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE AND LOCAL_NAME LIKE 'ASIA%')
WHERE JOB_NAME='�븮';
--WHERE JOB_CODE='J6' AND LOCAL_CODE IN('L1','L2','L3');
-- ORACLE
SELECT
	EMP_ID ���,
	EMP_NAME �����,
	JOB_NAME ���޸�,
	DEPT_TITLE �μ���,
	LOCAL_NAME �ٹ�������,
	SALARY �޿�
FROM EMPLOYEE E, JOB J, DEPARTMENT, LOCATION
WHERE E.JOB_CODE=J.JOB_CODE AND DEPT_CODE=DEPT_ID AND LOCATION_ID=LOCAL_CODE
	AND J.JOB_NAME='�븮'
	AND LOCAL_NAME LIKE 'ASIA%';


-- �ǽ� 5
-- �ѱ�(KO)�� �Ϻ�(JP)�� �ٹ��ϴ� �ٹ� �������� ������ ��ȸ�Ͻÿ�.
-- �����, �μ���, ������, ������

-- ANSI
SELECT EMP_NAME �����, DEPT_TITLE �μ���, LOCAL_NAME ������, NATIONAL_NAME ������
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME IN('�ѱ�','�Ϻ�');
-- ORACLE
SELECT EMP_NAME �����, DEPT_TITLE �μ���, LOCAL_NAME ������, NATIONAL_NAME ������
FROM EMPLOYEE, DEPARTMENT, LOCATION L, NATIONAL N
WHERE DEPT_CODE=DEPT_ID AND LOCATION_ID=LOCAL_CODE AND L.NATIONAL_CODE=N.NATIONAL_CODE
	AND N.NATIONAL_NAME IN('�ѱ�','�Ϻ�');

----------------------------------------------------
-- Sub Query --
-- �ְ� �Ǵ� ���� ���� �ȿ��� �����̳� �ϳ��� �˻��� ���� �ٸ� ������ �߰��ϴ� ���

-- ���� �� ��������
-- ������� 1�� ������ ��������
-- EX) �ּ� �޿��� �޴� ����� ���� ��ȸ
SELECT MIN(SALARY) FROM EMPLOYEE; --1380000
SELECT * FROM EMPLOYEE WHERE SALARY=1380000;

SELECT * FROM EMPLOYEE WHERE SALARY=(SELECT MIN(SALARY) FROM EMPLOYEE);

-- ���� �� ��������
-- ������� ������ ������ ��������
-- �� ���޺� �ּ� �޿�
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

SELECT * FROM EMPLOYEE
WHERE SALARY IN(SELECT MIN(SALARY)
				FROM EMPLOYEE
				GROUP BY JOB_CODE);
			
-- ���� �� ���� �� ��������
-- ���� �÷��� ���� ���� ���� ���������� ����Ͽ� ����� ��ȸ
SELECT * FROM EMPLOYEE
WHERE (JOB_CODE,SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
							FROM EMPLOYEE
							GROUP BY JOB_CODE);

-- ���� �� ���� �� �������� �� �Ϲ� ���� �� �������� ����
-- EX) ����� �������� ���� ����, ���� �μ��� �ٹ��ϴ� �������� ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE ENT_YN='Y';

SELECT * FROM EMPLOYEE
WHERE DEPT_CODE IN (SELECT DEPT_CODE FROM EMPLOYEE WHERE ENT
_YN='Y')
	AND JOB_CODE IN (SELECT JOB_CODE FROM EMPLOYEE WHERE ENT_YN='Y')
	AND EMP_NAME <> (SELECT EMP_NAME FROM EMPLOYEE WHERE ENT_YN='Y');

-- ���� �� ���� �� ���������� ����
SELECT * FROM EMPLOYEE
WHERE (DEPT_CODE,JOB_CODE) IN (SELECT DEPT_CODE,JOB_CODE
							   FROM EMPLOYEE
							   WHERE ENT_YN='Y')
	AND EMP_NAME != (SELECT EMP_NAME FROM EMPLOYEE WHERE ENT_YN='Y');
				