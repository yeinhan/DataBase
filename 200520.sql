--EMPLOYEE ���̺� ����
DESC EMPLOYEE;

--CRUD	:������ ó�� ����
--CREATE:������ �߰�	/INSERT
--READ	:������ ��ȸ	/SELECT
--UPDATE:������ ����	/UPDATE
--DELETE:������ ����	/DELETE

--�⺻ ���� ����
--EMPLOYEE ���̺��� ��� ����� �����, �̸���, ����ó, �Ի��� ��ȸ�ϱ�
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE FROM EMPLOYEE;

--�⺻���� ����2
--�μ��ڵ尡 D6�� �μ��� ��� ���� ���� ��ȸ�ϱ�
SELECT * FROM EMPLOYEE WHERE DEPT_CODE ='D6';

--������ 2���̻� �پ��� ���(AND, OR)
--�μ��ڵ尡 D6�̸鼭, �̸��� '�����'�� ����� ������� ��ȸ
SELECT * FROM EMPLOYEE WHERE DEPT_CODE='D6' OR EMP_NAME = '�����';

--�÷� �� ��Ī �ޱ�
--1. AS(alias) ǥ��
SELECT EMP_ID AS "�����ȣ", EMP_NAME AS "�����" FROM EMPLOYEE;

--AS ���� / ��Ī�� ()�� ���� ���� ���ڰ� �� ��� �ݵ�� ""�� ���� ������Ѵ�. 
SELECT EMP_ID "��� ��ȣ", EMP_NAME ����� FROM EMPLOYEE;

--�ǽ� ����1
--EMPLOYEE ���̺��� ��� ��ȣ�� 205�� ����� �����, �̸���, �޿�, �Ի� ���ڸ� ��ȸ�Ͻÿ�
--��, ��ȸ�ϴ� �÷��� ��Ī �ο�


SELECT * FROM EMPLOYEE;

SELECT EMP_NAME �����, EMAIL �̸���, SALARY �޿�, HIRE_DATE �Ի����� FROM EMPLOYEE WHERE EMP_ID = 205;

--�÷� ���� ����Ͽ� ���� ���
--�÷� ���� ���� NULL �̶�� ������ ó���Ͽ��� ��ȭ�� NULL
SELECT EMP_NAME "�����", (SALARY * 12) "����", BONUS "���ʽ�",(SALARY + (SALARY *BONUS )) * 12 "��������" FROM EMPLOYEE;

--NVL(): ���� ���� ��ȸ�� ���� NULL �� ��� ������ ������ ������ ����
--NUL(�÷���, ������) 
SELECT EMP_NAME �����, (SALARY * 12) ����, BONUS ���ʽ�, (SALARY + (SALARY * NVL(BONUS,0) )) *12 �������� FROM EMPLOYEE ;

--�÷��� �Ϲݰ� ���
SELECT EMP_NAME, SALARY * 12, '��' ���� FROM EMPLOYEE;

--DISTINCT: �ߺ� ����
--�ش��ϴ� ���� �÷��� ������ ���� �� ��� �ߺ��� �����ϰ� �� ���� ��ȸ(NULL ����)

SELECT DEPT_CODE FROM EMPLOYEE;
SELECT DISTINCT DEPT_CODE FROM EMPLOYEE e 

--�ǽ�2
--DEPARTMENT ���̺��� �����Ͽ�, �μ��� '�ؿܿ���2��'�� �μ��� �ڵ带 ã�� 
--EMPLOYEE ���̺��� �ش� �μ��� ����� �� �޿��� 200���� ���� ���� �޴� ������ ���, �����, �޿��� ��ȸ
--1. '�ؿܿ���2��'�� �μ��� �ڵ�ã��
--2. ��ȸ�� �μ��ڵ带 �̿��� ����� �� �ݿ��� 200~
SELECT * FROM DEPARTMENT WHERE DEPT_TITLE ='�ؿܿ���2��'; --D6
SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE FROM EMPLOYEE WHERE DEPT_CODE ='D6' AND SALARY > 2000000;

--������
--���� ������ '||'
--���� �÷��� ����� ���� �ϳ��� �÷����� ���� �� ���
--EX) '���'�� ���� ����� �̸��� '������' �Դϴ�.
SELECT EMP_ID || '�� ���� ����� �̸���' || EMP_NAME || '�Դϴ�' FROM EMPLOYEE e 

--�� ������
-- <, >, <=, >= ũ�⸦ ��Ÿ���� �ε�ȣ
-- = : ����
-- !=, ^=, <> : �����ʴ�.

--EMPLOYEE���� �μ��ڵ尡 D9�� �ƴ� �������� ��� ���� ��ȸ
SELECT * FROM EMPLOYEE e WHERE DEPT_CODE  <>'D6';

--EMPLOYEE���� �޿��� 350���� �̻� 550���� ������ ������ ���, �����, �μ��ڵ�, �����ڵ�, �޿������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY FROM EMPLOYEE WHERE SALARY>=3500000 AND SALARY <= 5500000 ORDER BY SALARY ASC;--��������;
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY FROM EMPLOYEE WHERE SALARY>=3500000 AND SALARY <= 5500000 ORDER BY SALARY DESC;--��������;

--BETWEEN A AND B
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY FROM EMPLOYEE WHERE SALARY BETWEEN 3500000 AND 5500000 ORDER BY SALARY ASC;

--���� �Ȱ��� ���� ������ ��ȸ�ϴµ� 350���� �̸�, 550���� �ʰ��� ���� ������ ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY FROM EMPLOYEE WHERE SALARY NOT BETWEEN 3500000 AND 5500000;

--LIKE : �Է��� ����, ���ڰ� ���Ե� ������ ��ȸ
--EMPLOYEE���� ����� �̸� ��� '��'�� ���� ��� ���� ��ȸ
--'_' : ������ �ѹ���
SELECT * FROM EMPLOYEE WHERE EMP_NAME LIKE '_��_';

--EMPLOYEE ���̺��� �ֹε�Ϲ�ȣ ���� ������ ����� ������ ��ȸ
SELECT * FROM EMPLOYEE WHERE EMP_NO LIKE '______-2%';

--��� �� �̸��� ���̵� 5���ڸ� �ʰ��ϴ� ����� �����, ���, �̸��� ���� ��ȸ
SELECT EMP_NAME, EMP_ID, EMAIL FROM EMPLOYEE WHERE EMAIL LIKE '_____%@%';

-- EMPLOYEE ���̺��� ���� '��'
SELECT * FROM EMPLOYEE WHERE EMP_NAME LIKE '��%';

--�̸��� 4��°�� _�� ���
SELECT * FROM EMPLOYEE WHERE EMAIL LIKE '___#_%@%' ESCAPE '#';

--IN ������
--IN(��1, ��2, ��3, ...)
--�ȿ� �ִ� �� �� �ϳ��� ��ġ �ϴ� ��� �ش簪�� ��ȸ

--�μ��ڵ尡 D1, D6�� �μ��� ���� ������ ��ȸ
SELECT * FROM EMPLOYEE WHERE DEPT_CODE IN('D1','D6');

--D1,D6�� �ƴ� ���
SELECT * FROM EMPLOYEE WHERE DEPT_CODE NOT IN('D1', 'D6');

--������ �켱����
--0. ()
--1. ��������� +-/*
--2. ���������
--3. �񱳿�����
--4. IS NULL / IS NOT NULL / LIKE, IN/ NOT IN
--5. BETWEEN A AND B
--6. NOT
--7. AND
--8. OR

--���սǽ�����1:
--������ 'J2'�̸鼭 200���� �̻� �޴� �����̰ų�
--������ 'J7'�� ����� ��� ����� �����ڵ� �޿� ������ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY FROM EMPLOYEE WHERE JOB_CODE = 'J2' AND SALARY >2000000 OR JOB_CODE = 'J7';

--���սǽ�2
--������ 'J7' �̰ų� 'J2'�̸鼭 �޿��� 200���� �̻�޴� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY FROM EMPLOYEE WHERE JOB_CODE IN('J2','J7') AND SALARY >= 2000000;



--FUNCTION(�Լ�)

--���� �����Լ�
--LENGTH : ���ڿ� ����
SELECT LENGTH('Hello') FROM DUAL;

--DUAL : �ӽ����̺�(������ ���̺�)SELECT������ ���ͷ��� Ȱ���� ������ �׽�Ʈ�ϰ��� �� �� ����ϴ� �ӽ� ���̺�
SELECT LENGTH('��â��'), LENGTHB('��â��'), LENGTH('Hello'), LENGTHB('Hello') FROM DUAL;

--INSTR : �־��� ������ ���ϴ� ���ڰ����°���� ã�� ��ȯ
SELECT INSTR('ABCDE','A'), INSTR('ABCDE','C') FROM DUAL;

--SUBSTR(�÷���|��, ���ۼ���[,������ ����]) : �־��� ���ڿ����� Ư���κи� �������� �Լ� (��, ������ġ, ����)
SELECT 'Hello World', SUBSTR('Hello World',7), SUBSTR('Hellow World',1,5) FROM DUAL;

--�ǽ� 3
--EMPLOYEE ���̺��� ����� �̸�, �̸��� ��ȸ / �̸����� ���̵�κи� ��ȸ�ϱ�
SELECT EMP_NAME, EMAIL FROM  EMPLOYEE;
--@ ��ġ ã��
SELECT INSTR(EMAIL, '@') FROM EMPLOYEE;
SELECT EMP_NAME, SUBSTR(EMAIL,1, INSTR(EMAIL, '@')-1) FROM EMPLOYEE; 

--LPAD / RPAD : �� ĭ�� ������ ���ڷ� ä���ش�
SELECT LPAD(EMAIL, 20, '#') FROM EMPLOYEE; 
SELECT RPAD(EMAIL,20 , '_') FROM EMPLOYEE;

--LTRIM / RTRIM : ���� �ο��� �÷����̳�, Ư�� �����κ��� Ư�� ���ڸ� ã�� �����ִ� �Լ�
SELECT LTRIM('     Hello') FROM  DUAL;
SELECT RTRIM('Hello     ') FROM DUAL;
SELECT RTRIM('     HI') FROM DUAL;

SELECT LTRIM('012345','0'),
	LTRIM('1111234', '1'),
	LTRIM('012345','1') FROM DUAL;

--TRIM :  �־��� ���ڿ����� �� ���� �������� Ư�����ڸ� �����ִ� �Լ�
--�⺻����
SELECT TRIM('  ���Ϻ��   ') FROM DUAL;
--�� ���� Ư������ ������� �� ��
SELECT TRIM('0' FROM '000012300') FROM DUAL;
SELECT TRIM(LEADING '0' FROM '000012300') FROM DUAL;
SELECT TRIM(TRAILING  '0' FROM '000012300') FROM DUAL;
SELECT TRIM(BOTH '0' FROM '000012300') FROM DUAL;

--LOWER / UPPER / INITCAP : �ҹ���, �빮��, �ձ���
SELECT LOWER('NICE TO MEET YOU'),
	UPPER('nice to meet you'),
	INITCAP('nice to meet you') FROM DUAL;

--CONCAT : �������ڿ��� �ϳ��� ���ڿ��� ��ġ�� �Լ�
SELECT CONCAT('����Ŭ', '�ʹ� ����־��') FROM DUAL;
SELECT '����Ŭ '||'�ʹ� �������' FROM DUAL;

--REPLACE 
SELECT REPLACE('HELLO WORLD','HELLO','BYE') FROM DUAL;	

--�ǽ�4
SELECT EMP_NO FROM EMPLOYEE;
--����� �ֹι�ȣ�� ��ȸ�Ͽ� ���� ������ ���� ��ȸ
SELECT EMP_NAME �̸�, CONCAT(SUBSTR(EMP_NO,1,2),'��') ����, CONCAT(SUBSTR(EMP_NO,3,2),'��') ����, CONCAT(SUBSTR(EMP_NO,5,2),'��') ���� FROM EMPLOYEE;

--SUBSTR�� Ȱ���ϸ� ��¥ �����͵� ���� �� �ִ�.
SELECT EMP_NAME �̸�, CONCAT(SUBSTR(HIRE_DATE,1,2),'�� ') �Ի�⵵ FROM EMPLOYEE;

--���� �� �Լ�(Single Row Function) ����� ã�Ƽ� ����� ������ ���࿡ �Լ��� ����

--���� �� �Լ�(Multitple Row Function) ���� ���� �����ϴ� ��� ���� �� ã�� ���� �ѹ��� ����

--�׷��Լ� SUM(), AVG, MAX, MIN, COUNT

--SUM
SELECT SUM(SALARY) FROM EMPLOYEE;

--AVG
SELECT AVG(SALARY) FROM EMPLOYEE;

--MAX/ MIN
SELECT MAX(SALARY), MIN(SALARY) FROM EMPLOYEE;

--�ǽ� 5
--EMPLOYEE  '�ؿ�������1'�� �ٹ��ϴ� ��� ����� �򱺱޿�, ������� �ݿ�, ���� �޿�, �ݿ��հ�
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT WHERE DEPT_TITLE ='�ؿܿ���1��'; --D5
SELECT AVG(SALARY) ��, MAX(SALARY) ��������޿�, MIN(SALARY) ��������޿�, SUM(SALARY) �޿��հ� FROM EMPLOYEE WHERE DEPT_CODE ='D5';

--COUNT : �ش� �ϴ� ���� ����
SELECT COUNT(*) FROM EMPLOYEE;
SELECT COUNT(*), COUNT(DEPT_CODE), COUNT(DISTINCT DEPT_CODE) FROM EMPLOYEE;

--�ǽ�6
--EMPLOYEE ������� ��� ����� �̸��� �ֹι�ȣ�� ��ȸ�Ͽ� ��� ���ǥ�� ������
--�̸����� '@' ������ �ֹ̤���ȣ�� 7���� �ڸ� ���Ĵ� *ó��,, 
 SELECT EMP_ID ���, EMP_NAME �����, SUBSTR(EMAIL,1, INSTR(EMAIL, '@') ) �̸���, CONCAT(SUBSTR(EMP_NO,1,8),'*******' ) �ֺ��ȣ FROM EMPLOYEE;
 
 --�ǽ�7
 --��������� ���, �����, �����ڵ带 ��ȸ
 SELECT EMP_ID ���, EMP_NAME �̸�, ENT_YN ��翩�� FROM EMPLOYEE WHERE SUBSTR(EMP_NO,8,1) = 2; 
 --**ENT_YN: ���� �ٹ����θ� �ľ��ϴ� �÷�


--************************2
--���� �ּ�
/*
 * ������ �ּ�
 */
--';' ������ ��

--SELECT ��: ��ȸ�� SQL
--[����]
--SELECT �÷���   : ��ȸ�ϰ��� �ϴ� ����
--FROM ���̺��   : ��ȸ�ϰ��� �ϴ� ���̺� ��
--[WHERE ����]   : Ư������
--[ORDER BY �÷�]   : ����
-- ;

--��� ��� ��� �÷� ��ȸ
SELECT * FROM EMPLOYEE;

--����� ID�� �����, ����ó ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE;

--����� ID, �����, �̸���, ����ó, �μ���ȣ �����ڵ带 ��ȸ
SELECT EMP_ID, EMP_NAME, EMAIL, PHONE, DEPT_CODE, JOB_CODE FROM EMPLOYEE;

--WHERE ��
--���̺��� ������ �����ϴ� ���� ������ ���� ���� �����Ͽ� ��ȸ�Ѵ� ������
--���� ���� ������ �����ϰ��� �� ��� AND, OR ��ɾ �Բ� ���

--�μ� �ڵ尡 D6�� ��� ������ ��� ��ȸ�ϱ�
SELECT * FROM EMPLOYEE WHERE DEPT_CODE = 'D6';

--����1.
--������'J1'�� ����� ���, �����, �μ��ڵ带 ��ȸ�Ͻÿ�
--����2
--�޿��� 300���� �̻��� ����� ���̵�, �����, �����ڵ�, �޿��� ��ȸ�Ͻÿ�.

SELECT EMP_ID , EMP_NAME,JOB_CODE, DEPT_CODE FROM EMPLOYEE WHERE JOB_CODE='J6';

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY FROM EMPLOYEE WHERE SALARY > 3000000;

--200515--
-- ��¥ ó�� �Լ�
-- SYSDATE : ���� ��ǻ���� ��¥�� ��ȯ�ϴ� �Լ�
SELECT SYSDATE FROM DUAL; 

-- MONTHS_BETWEEN(��¥1, ��¥2) : �� ��¥ ������ ���� ��
SELECT HIRE_DATE �Ի���,
      FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) "�Ի� �� ���� ��" 
FROM EMPLOYEE;

-- ADD_MONTHS(��¥, ���� ��)
SELECT ADD_MONTHS(SYSDATE, 6) FROM DUAL; 

-- EXTRACT(YEAR | MONTH | DAT FROM ��¥������)
-- ������ ���κ��� ��¥ ���� �����ϴ� �Լ�
SELECT EXTRACT(YEAR FROM HIRE_DATE),
       EXTRACT(MONTH FROM HIRE_DATE),
       EXTRACT(DAY FROM HIRE_DATE)
FROM EMPLOYEE;

-- ����ȯ �Լ�
-- DATE <--> CHAR <--> NUMBER
-- TO_DATE(), TO_CHAR(), TO_NUMBER

-- TO_CHAR --
-- ��¥ ���� ���� --
SELECT HIRE_DATE,TO_CHAR(HIRE_DATE,'YYYY-MM-DD'),TO_CHAR(HIRE_DATE,'YY-MON-DD') FROM EMPLOYEE;

-- ���� ���� ����
-- 9: ���� �� ĭ�� ǥ������ �ʴ´�.
-- 0: ���� �� ĭ�� 0���� ǥ��
-- L: ��ȭ��ȣ(��, ��, ����, �޷�)
SELECT SALARY,TO_CHAR(SALARY),TO_CHAR(SALARY, 'L999,999,999'), TO_CHAR(SALARY, '000,000,000'),TO_CHAR(SALARY, 'L999,999')
FROM EMPLOYEE;


-- TO_DATE() --
SELECT 20200515,
      TO_DATE(20200515, 'yyyymmdd'),
      TO_DATE(20200515, 'YYYY/MM/DD')
FROM DUAL;


-- DECODE() --
-- JAVA���� 3�� ������
-- ����  ? �� : ����

-- ���� �ٹ��ϴ� �������� ������ ��, ���� ���� ����
SELECT EMP_NAME, EMP_NO,DECODE(SUBSTR(EMP_NO,8,1), '1', '��', '2', '��') ���� FROM EMPLOYEE ORDER BY ����;

--�ǽ�1
--��� ������ ���, �����, �μ��ڵ�, �����ڵ�, �ٹ�����, �����󿩺� ��ȸ�ϵ� ���� �ٹ� ���ΰ� 'Y'�����, 'N'�ٹ���, �����ڻ��(MANAGER_ID) ������ '���', ������ '������'�� �ۼ��Ͽ� ��ȸ
SELECT EMP_ID ���, EMP_NAME �����, DEPT_CODE �μ��ڵ�, JOB_CODE �����ڵ�,
   DECODE(ENT_YN, 'Y', '�����','�ٹ���') "�ٹ� ����",
   DECODE(NVL(MANAGER_ID ,0),0,'������','���' ) "������ ����"
   FROM EMPLOYEE;

--Case ��
--JAVA�� IF, SWITH ó�� ����� �� �ִ� �Լ� ǥ����
--Case
--WHEN (���ǽ�1) THEN �����1
--WHEN (���ǽ�2) THEN �����2
--ELSE �����3
--END
SELECT EMP_ID ���, EMP_NAME �����, DEPT_CODE �μ��ڵ�, JOB_CODE �����ڵ�,
   CASE
      WHEN ENT_YN = 'Y' THEN '�����'
      ELSE '�ٹ���'
   END   "�ٹ� ����",
   CASE 
      --WHEN MANAGER_ID IS NULL THEN '������'
      WHEN NVL(MANAGER_ID ,0) = 0 THEN '������'
      ELSE '���'
   END "������ ����"
   FROM EMPLOYEE;

--NVL(�÷���|������, NULL�� �ƴҰ�� ��, NULL�� ��� ��)
SELECT EMP_ID ���, EMP_NAME �����, BONUS ���ʽ�,
   NVL(TO_CHAR(BONUS),'X')   "NVL�Լ�",
   NVL2(BONUS, TO_CHAR(BONUS,'0.9'),'X' ) "NVL2 �Լ�" 
   FROM EMPLOYEE;

--���� ������ �Լ�--
-- ABS() : ���밪 ǥ��
SELECT ABS(10), ABS(-10)
FROM DUAL;

--MOD() : �������� ��ȯ
SELECT MOD(10,3),MOD(10,2), MOD(10,7)
FROM DUAL;

--ROUND() : ������ ���ڸ� �ݿø� �ϴ� �Լ�
SELECT ROUND(123.456,0),
   ROUND(123.456,1),
   ROUND(123.456,2),
   ROUND(123.456,-2)
   FROM DUAL;

--CEIL() : �Ҽ��� ù° �ڸ����� �ø�
--FLOOR() : �Ҽ��� ���� �ڸ��� ����
--TRUNC() : ������ ��ġ���� ���ڸ� ����
SELECT CEIL(123.456),
   FLOOR(123.456),
   TRUNC(123.456,0),
   TRUNC(123.456,1),
   TRUNC(123.456,-2)
FROM DUAL;

--�ǽ�2
--EMPLOYEE ���̺��� �Ի��� ���� ���ڰ� Ȧ�� ���� ������ ���, �����, �Ի��� ������ ��ȸ
SELECT EMP_ID ���, EMP_NAME �����, SUBSTR(HIRE_DATE ,4,2) �Ի���
   FROM EMPLOYEE   --10/11/15
   WHERE MOD(SUBSTR(HIRE_DATE,5,1),2 )=1;
   --WHERE MOD(EXTRACT(MONTH FROM HIRE_DATE),2) =1;

--��¥ ������
--SYSDATE, MONTHS_BETWEEN, ADD_MONTHS
--EXTRACTM, LAST_DAY, NEXT_DAT
SELECT SYSDATE,
   SYSTIMESTAMP
FROM DUAL;

SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH:MI:SS') ,
   TO_CHAR(SYSTIMESTAMP,'YYYY-MM-DD HH:MI:SSFF' ) 
   FROM DUAL;

--NEXT_DAY(��¥, ���ϸ�)
SELECT NEXT_DAY(SYSDATE, '�Ͽ���'),
   NEXT_DAY(SYSDATE,'��') ,
   NEXT_DAY(SYSDATE,7 ),   --1:��. 2:��, 3:ȭ, 4:��
   NEXT_DAY(SYSDATE,'SATURDAY')
FROM DUAL;

--������ ����(������ ��ųʸ�) : ���� ������ ������ ������ DB�� ���̺� ���·� �����ϴ� ���̺�
--�⺻������ �ý����� �����ڸ� ���� ����
--��, ����� ������ ������ ������ ���氡��, ���� �� �������ϸ� �ʱ�ȭ
SELECT * FROM V$NLS_PARAMETERS;
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;

--������ ���� ��ȸ
SELECT NEXT_DAY(SYSDATE, 'SATURDAY') 
FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

SELECT LAST_DAY(SYSDATE)
FROM DUAL;

--��¥�������� ���� �ֱ� ��¥�ϼ��� ���� �� ū������ �Ǵ�
--+,- ���� ����
SELECT (SYSDATE - 10) "��¥1",
   TRUNC(SYSDATE - TO_DATE('20/03/01', 'RR/MM/DD')) "��¥2",
   TRUNC(TO_DATE('20/03/01','RR/MM/DD') - SYSDATE) "��¥2"
FROM DUAL;

--�ǽ�3
--EMPLOYEE �ٹ� ����� 20�� �̻��� ������� ��� ����� �μ��ڤ� �Ի��� ��ȸ
SELECT EMP_ID ���, EMP_NAME �����, DEPT_CODE �μ��ڵ�, HIRE_DATE �Ի���
FROM EMPLOYEE 
WHERE ADD_MONTHS(HIRE_DATE,240) <= SYSDATE;

--����ȯ
-- YYYY �⵵ ǥ��(4�ڸ�) YY �⵵ ǥ��(2�ڸ�)
-- MM ���� ���ڷ�
-- DAY ���� ǥ��
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') ,
   TO_CHAR(SYSDATE,'MON DY YYYY' ),
   TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY'),
   TO_CHAR(SYSDATE, 'YEAR, Q')   --Q �б�
FROM DUAL;

--Y/R
SELECT TO_CHAR(TO_DATE('200315','YYMMDD'),'YYYY') "���1",
   TO_CHAR(TO_DATE('200315','RRMMDD'),'RRRR' ) "���2",
   TO_CHAR(TO_DATE('800315','YYMMDD'),'YYYY') "���3",
   TO_CHAR(TO_DATE('800315','RRMMDD'), 'RRRR') "���4" 
FROM DUAL;
--4�ڸ� �ѹ��� �Է� ���� ��� ����X
--2�ڸ� �Է¹޴� ��� 
--YY�� �� ���� ����
--RR�� �� ���� ����

--SELECT���� ���� ����
/*
 * 5: SELECT �÷��� AS ��Ī, ���, �Լ���
 * 1: FROM ���̺��
 * 2: WHERE ����
 * 3: GROUP BY �׷��� ���� �÷Ÿ�
 * 4: HAVING �׷쿡 ���� ���ǽ�, �Լ���
 * 6: ORDER BY �÷�|��Ī|����
 * 
 * */
--ORDER BY
SELECT EMP_ID, EMP_NAME �̸�, SALARY, DEPT_CODE
FROM EMPLOYEE
--ORDER BY EMP_ID;   --�⺻���� ASC
ORDER BY EMP_NAME DESC;

--GROUP BY
--�μ��� ���
SELECT TRUNC(AVG(SALARY),-3 ) 
FROM EMPLOYEE;
--D1 ��� �޿�
SELECT TRUNC(AVG(SALARY),-3)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

--Ư�� �÷�, ������ �ϳ��� �׷����� ���� �� ���̺� ������ �ұ׷� ���� ��ȸ �ϰ��� �� �� �����ϴ� ����
SELECT DEPT_CODE, TRUNC(AVG(SALARY), -3)
FROM EMPLOYEE
GROUP BY DEPT_CODE 
ORDER BY 1;

--�ǽ� 4
--EMPLOYEE �μ��� �� �ο�, �޿� �԰�, �޿� ���, �ִ� �޿�, �ּ� �޿��� �μ��ڵ��� �������� �������� ����
SELECT * FROM EMPLOYEE;
SELECT NVL(DEPT_CODE,'����') �μ��ڵ�,
   COUNT(*) �ο�,
   SUM(SALARY) �޿��հ�,
   TRUNC(AVG(SALARY),-3) �޿����,
   MAX(SALARY) �ִ�޿�,
   MIN(SALARY) �ּұ޿�
   FROM EMPLOYEE
   GROUP BY DEPT_CODE
   ORDER BY DEPT_CODE ASC;

--�����ڵ� �� ���ʽ��� �޴� ����� ���� ��ȸ
SELECT JOB_CODE �����ڵ�, COUNT(BONUS) �ο�
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY 1;

--�ǽ�5
--���������� ���������� ���� ��ȸ�Ͻÿ�
--GROUP BY���� �־��� �÷����� �ƴ� �Լ��ĵ� ��밡��
SELECT DECODE(SUBSTR(EMP_NO,8,1),1,'����',2,'����' ) ����,
   COUNT(*) || '��' ������
   FROM EMPLOYEE
   GROUP BY DECODE(SUBSTR(EMP_NO,8,1),1,'����',2,'����' );

--HAVING ����
--GROUP BY �� �� �ұ׷쿡 ���� ������ ���� �� �� �׷��Լ��� �Բ� ����ϴ� ����
SELECT DEPT_CODE,
   AVG(SALARY) ��
   FROM EMPLOYEE
   WHERE SALARY>3000000
   GROUP BY DEPT_CODE;

SELECT DEPT_CODE,
   AVG(SALARY)  ���
   FROM EMPLOYEE
   GROUP BY DEPT_CODE 
   HAVING AVG(SALARY) >3000000
   ORDER BY 1;


--�ǽ�6
--�μ��� �׷��� �޿� �հ� �� 900������ �ʰ��ϴ� �μ��� �ڵ�� �޿� �հ踦 ��ȸ
SELECT DEPT_CODE �μ��ڵ�, 
   SUM(SALARY)  �޿��հ�
   FROM EMPLOYEE
   GROUP BY DEPT_CODE
   HAVING SUM(SALARY) > 9000000
   ORDER BY 1;

--�ǽ�7
--�޿��հ谡 ���� ���� �μ��� ã��
--�ش�μ��� �μ��ڵ�� �޿� �հ踦 ��ȸ�Ͻÿ�
--)�޿��հ谡 ���� ���� ��
--)�޿��հ谡 ���� ���� �޿� �հ�� �μ�
SELECT MAX(SUM(SALARY) ) �հ�
   FROM EMPLOYEE
   GROUP BY DEPT_CODE;--17,700,000

SELECT DEPT_CODE �μ�, 
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
				

--*******************************4
-- ���� ������ ��� ��ġ
-- SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY, JOIN
-- DML: INSERT, UPDATE, DELETE
-- DDL: CREATE TABLE, CREATE VIEW
-- ��� ��ġ�� ����� �� �ִ�.

-- Inline View(�ζ��� ��)



-- SET OPERATOR
-- ������
-- UNION
-- UNION ALL
-- ������ INTERSECT
-- ������ MINUS

--JOIN --
--�� �� �̻��� ���̺��� ����� �ϳ��� ���̺� ���·� ���ļ� ����ϴ� ���
--INNER JOIN ��ġ���� ���̺��� �����͸� ������ ��� ��ġ�ϴ� ������ �����Ͽ� ����
--OUTER JOIN 
--	LEFT: ���� ���̺��� ������ ��� ���� 
--	RIGHT: ���� ���̺��� ������ ��� ����
--	FULL: ����

--CROSS JOIN, SELF JOIN, ���� JOIN

--SUB QUERY: ���������ȿ� �� �ϳ��� ������ �߰�-- SELECT���ȿ� SELECT��

--�ζ��κ�
--FROM ��ġ�� ���Ǵ� ��������
--���������� RESULT SET�� Ȱ���Ͽ� �����͸� ��ȸ�� �� ����� �� �ִ�.
--�̶� ������ ���̺��� ��ü�Ѵٴ� �ǹ̿��� FROM ������ ���������� Inline View��� �θ���.
SELECT *
FROM(
	SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
	FROM EMPLOYEE
	JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
	JOIN JOB USING(JOB_CODE));

--TOP-N �м� ��ȣ
--���ִ� ���� ����5��, ���帹���ȸ����̽�ũ��6��

--ROWNUM: �����͸� ��ȸ�Ҷ� �� ���� ��ȣ�� �Ű��ִ� �Լ�
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM < 6;

--����
--�޿��������� ���� ���� �޿��� �޴� ���
--���� 5�� ��ȸ�ϰ� ���, �����, �޿��� ���

SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;

SELECT ROWNUM, A.*
FROM (SELECT ROWNUM, EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC) A
WHERE ROWNUM < 6;

--RANK(): ������ �ű�� �Լ�	<==> DENESE_RANK(): ������ �ű�� �Լ�
--1								1
--2								2
--3								2
--4								3
SELECT EMP_NAME, SALARY,
RANK() OVER(ORDER BY SALARY DESC) "����"
FROM EMPLOYEE;

SELECT *
FROM(SELECT EMP_NAME, SALARY,
RANK() OVER(ORDER BY SALARY DESC) "����"
FROM  EMPLOYEE)
WHERE ���� < 4;

SELECT EMP_NAME, SALARY,
	DENSE_RANK() OVER(ORDER BY SALARY DESC) "����"
	FROM EMPLOYEE;
	
--�ǽ�5
--EMPLOYEE 
--���ʽ��� ������ ������ ���� ���� ��� ���� 5���� RANK() �Լ��� Ȱ���Ͽ� ��ȸ
--���, �����, �μ���, ���޸�, ����(���ʽ� ����)
SELECT *
FROM (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE,
(SALARY + (SALARY)*NVL(BONUS,0)+1) *12 ����
RANK() OVER(ORDER BY (SALARY + (SALARY)*NVL(BONUS,0)+1) *12 ���� )
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_ID = DEPT_CODE )
JOIN JOB USING(JOB_NAME))
WHERE ���� < 6;

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, HIRE_DATE,
SALARY + (SALARY)*NVL(BONUS,0)*12  ����,
RANK() OVER(ORDER BY SALARY + (SALARY)*NVL(BONUS,0)*12 DESC ) ����
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

--WITH AS
--������ ���������� �ߺ��ؼ� ����Ҷ� �̸� ��Īȭ �Ͽ� ����ϵ��� �ϴ� ����
--�������: WITH ��Ī AS
--**�ζ��� �信���� ����
WITH TOP_N_SAL AS(
	SELECT EMP_NAME, SALARY
	FROM EMPLOYEE
	ORDER BY SALARY DESC
) SELECT *
FROM TOP_N_SAL;

--�μ� �� �޿� �հ谡 ��ü �μ� �޿� ������ 20%���� ���� �μ��� �μ����, �μ��޿� �հ踦 ��ȸ
--1) �Ϲ� ������ ��������
--��ü �μ��� �޿� �հ��� 20%��ȸ
SELECT SUM(SALARY)*0.2, DEPT_CODE �μ���
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) > (SELECT SUM(SALARY)*0.2 FROM EMPLOYEE);

--2) �ζ��� �� Ȱ��
--��������
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE

--�ζ��� ��
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

--WITH AS�� �̿�
WITH SUM_SAL_VIEW
AS (
	SELECT DEPT_CODE, SUM(SALARY) SUMSAL
	FROM EMPLOYEE
	GROUP BY DEPT_CODE
) SELECT *
FROM SUM_SAL_VIEW
WHERE SUMSAL > (SELECT SUM(SALARY)*0.2 FROM EMPLOYEE);

--WITH AS ������ ���
WITH SUM_SAL AS (SELECT  SUM(SALARY) FROM EMPLOYEE), 
	AVG_SAL AS (SELECT AVG(SALARY) FROM EMPLOYEE)
	SELECT * FROM SUM_SAL
	UNION ALL
	SELECT * FROM AVG_SAL
	UNION ALL
	SELECT * FROM SUM_SAL;

--��ȣ ���� ����: �������
--�Ϲ������� ���������� ��������, ���������� ���������� ����� �޾Ƽ� �����ϴ� ��İ� �ٸ���
--���������� ����ϴ� �÷���, �Ի�� ���� ���������� �����Ͽ� �������� ���� �� ���� ������ ���� �Բ� ����ϴ� ���

--����� ���޿� �ٸ� �޿� ��պ��� ���� �޴� ����� ������ ��ȸ
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

--��Į�� ����
--������ �������� +��ȣ���� ��������
--SELECT, WHERE, ORDER BY ���� ���
--������ SELECT�� ���� ����ϱ� ������ SELECT LIST��� �Ѵ�.

SELECT EMP_ID, 
	EMP_NAME,
	MANAGER_ID,
	NVL((SELECT EMP_NAME FROM EMPLOYEE M
		WHERE E.MANAGER_ID = M.EMP_ID), '����') �������̸�
		FROM EMPLOYEE E
		ORDER BY �������̸�, EMP_ID;


--�����ͻ���
--�����ͺ��̽� �ȿ��� ����� �������� ������ �����ϴ� ���̺�