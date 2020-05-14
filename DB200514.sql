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
--
