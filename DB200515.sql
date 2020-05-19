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

SELECT * FROM EMPLOYEE ;
--��������1
--��������2
SELECT EMP_NAME �̸�, JOB_CODE �����ڵ�,
   TRUNC((SALARY*12+NVL(BONUS ,0))) ���� 
FROM EMPLOYEE;
--��������3
SELECT EMP_ID ���, EMP_NAME �����   ,
   DEPT_CODE �μ��ڵ�,
   HIRE_DATE �Ի���
   FROM EMPLOYEE
   WHERE (DEPT_CODE = 'D5' OR DEPT_CODE ='D9') AND EXTRACT(YEAR FROM HIRE_DATE)=2004 ;
--��������4
SELECT EMP_NAME �����, 
   TO_CHAR(HIRE_DATE,'YYYY-MM-DD') �Ի���,
   LAST_DAY(HIRE_DATE)-HIRE_DATE "�Ի�� �ٹ��ϼ�"
   FROM EMPLOYEE;
--��������5
SELECT EMP_NAME ������,
   DEPT_CODE �μ��ڵ�,
   SUBSTR(EMP_NO,1,2) || '��' || SUBSTR(EMP_NO ,3,2) || '��' || SUBSTR(EMP_NO ,5,2) || '��' 
   FROM EMPLOYEE;
--��������6
SELECT COUNT(*) ��ü������,
   DECODE(SUBSTR(HIRE_DATE,2,1),1, )    