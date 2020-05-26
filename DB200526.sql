---------------0526
--�ε���--
--SQL ��ɾ� ��ȸ ó�� �ӵ��� ����Ű�� ���� ��ü

--����:�˻��ӵ� ���
--����: �ε����� �����ϴ� ���̺��� ������ ���� ����Ǵ� ���̺��̶�� �ε����� �Ź� �ٽ� ����Ͽ� �������ϱ� ������
--		������ ������ ���ϵ� �� �ִ�.
--		�ε����� �����ϱ� ���� ������ ������ �Ҵ� 

--�ε��� �������
-- CREATE [UNIQUE] INDEX �ε�����
-- ON ���̺��(�÷�[,�÷��� | �Լ���])

--�ε����� �����ϴ� �����ͻ���
SELECT * FROM USER_IND_COLUMNS;

SELECT ROWID, EMP_ID, EMP_NAME
FROM EMPLOYEE;

--ROWID
--���̺� ���� �� ������ �߰��ÿ� ����Ŭ���� �ش� ��ü�� �����ϱ� ����
--�������� ����, �ý��ۿ��� ���� �����ϱ� ������ ����ڰ� �Ժη� ���� �Ұ�

--�ε����� ����
--1. �����ε���(UNIQUE INDEX)
--2. ������ε���(NOUNIQUE INDEX)
--3. �����ε���(SINGLE INDEX)
--4. �����ε���(COMPOSITE INDEX)
--5. �Լ���� �ε���(FUNCTION BASE INDEX)

-- ���� �ε��� --
--�ε��� ���� �� �������� �������� �����ϴ� �ε���
--PRIMARY KEY ���������� ����ϸ� �ڵ����� �����ϴ� �ε���

CREATE UNIQUE INDEX IDX_EMP_NO
ON EMPLOYEE(EMP_NO);

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMPLOYEE';

--ORA-01452: cannot CREATE UNIQUE INDEX; duplicate keys found
--�÷��� ���� �ߺ��� ������ ��� UNIQUE INDEX ������ �� ����.
CREATE UNIQUE INDEX IDX_DEPT_CODE
ON EMPLOYEE(DEPT_CODE);

--NON-UNIQUE INDEX
-- ���� ���� ����ϴ� �÷��� �ε����� �����Ͽ� �˻� �ӵ��� ��� ��Ű�� ���� �ε���
CREATE INDEX IDX_DEPT_CODE
ON EMPLOYEE(DEPT_CODE);

SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6';

SELECT * FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMPLOYEE';

--���� �ε���
--���� �÷��� �ϳ��� ���� ���� �ε���
CREATE INDEX IDX_DEPT
ON DEPARTMENT(DEPT_ID, DEPT_TITLE);

SELECT * FROM DEPARTMENT;

SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT
WHERE DEPT_ID != 'D1'
	AND DEPT_TITLE != '���������';

--�Լ�����ε���
--��ȸ �� ���� ����ϴ� �Լ����� �ִٸ� �ش� �Լ����� �ε��� ������ �ݿ��Ͽ� �˻��� ��� �ϴ� �ε���

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ((SALARY * NVL(BONUS,0) + SALARY)*12) >1000000;

CREATE INDEX IDX_EMP_SAL_CAL
ON EMPLOYEE ((SALARY * NVL(BONUS,0) + SALARY)*12) ;

--�ε��� ���ΰ�ħ
ALTER INDEX IDX_DEPT REBUILD;

--�ε��� ����
DROP INDEX IDX_DEPT;





--PL/SQL--
--(PROCEDURAL LANGUAGE EXTENSION TO SQL)

--���: ��������, ��ó��, �ݺ�ó��

--PL/SQL�� ����
--�����, �����,����ó����
-- ����� : DECLARE, ���� ���� �ϴ� �κ�
-- �����: BEGIN, ���/�ݺ��� ���� �ۼ��ϴ� �κ�
-- ����ó����: EXCEPTION, ���ܹ߻��� ó���ϴ� ���� �ۼ��ϴ� �κ�

--����θ� ����ؼ� ������ ���� ���
BEGIN
	DBMS_OUTPUT.PUT_LINE('HELLO WORLD');
	--DBMS_OUTPUT��Ű���� PUT_LINE�̶�� ���ν����� �̿��Ͽ� ȣ��
END;

--ȭ�鿡 ���̵��� ����
SET SERVEROUTPUT ON;


--���� ����� �ʱ�ȭ, ���
DECLARE
	vid NUMBER;
BEGIN
	SELECT EMP_ID
	INTO vid		--������ ��ȸ�� ���� ����
	FROM EMPLOYEE
	WHERE EMP_NAME = '������';
	DBMS_OUTPUT.PUT_LINE('ID='||vid);
EXCEPTION
	WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('No Data!!');
END;

--��������
--[1]�Ϲݺ���
DECLARE
	v_empno NUMBER(4);
	v_empname VARCHAR2(10);
	test_num NUMBER(5) := 10 * 20;
BEGIN
	v_empno := 1001;
	v_empname := '�ѿ���';
	DBMS_OUTPUT.PUT_LINE(v_empno || '   '|| v_empname|| '    '|| test_num);
END;

--[2]���۷��� ����
--	(1)%TYPE: �� �÷��� �ڷ����� �޾� �ö� ����ϴ� �ڷ��� Ÿ��
DECLARE
	EMP_ID EMPLOYEE.EMP_ID%TYPE;
	EMP_NAME EMPLOYEE.EMP_NAME%TYPE;
	SALARY EMPLOYEE.SALARY%TYPE;
BEGIN
	SELECT EMP_ID, EMP_NAME, SALARY
	INTO EMP_ID, EMP_NAME, SALARY
	FROM EMPLOYEE
	WHERE EMP_NAME = '������';
	DBMS_OUTPUT.PUT_LINE(EMP_ID || '     ' || EMP_NAME|| '     '||SALARY);
END;

--(2) %ROWTYPE : �����̺��� ��� �÷��� �ڷ����� ������ �� ����ϴ� Ÿ��
DECLARE
	myrow EMPLOYEE%ROWTYPE;
BEGIN
	SELECT EMP_ID, EMP_NAME
	INTO myrow.emp_id, myrow.emp_name
	FROM EMPLOYEE
	WHERE EMP_NAME = '������';
	DBMS_OUTPUT.PUT_LINE(myrow.emp_id||',    '||myrow.emp_name);
END;

--IF��--
--IF ~ THEN ~ END IF��
/*
 * IF ���� THEN ������ ������ ���ó�� ����;
 * END IF;
 * 
 * */
BEGIN
	IF '�ѿ���' = '�ѿ���' THEN
		DBMS_OUTPUT.PUT_LINE('�ѿ����̴�.');
	END IF;
END;
/

--2. IF ~ THEN ~ ELSE ~ END IF
BEGIN
	IF '�ѿ���' = '�ѿ���1' THEN
		DBMS_OUTPUT.PUT_LINE('�ѿ����̴�');
	ELSE DBMS_OUTPUT.PUT_LINE('�ƴϳ�...');
	END IF;
END;
/

--3. IF ~ THEN ~ ELSEIF ~ ELSE ~ END IF;
/*
 * IF ����1 THEN
 * 		����1;
 * ELSEIF ����2 THEN
 * 		����2;
 * ELSE
 * 		��� ���� �������� ���� ��;
 * */

DECLARE
	NAME VARCHAR2(30) := '�ѿ���';
BEGIN
	IF NAME = '�ѿ���' THEN DBMS_OUTPUT.PUT_LINE('�ѿ����̳�....');
	ELSIF NAME = '�嵷��' THEN DBMS_OUTPUT.PUT_LINE('�嵿���̱���...');
	ELSE DBMS_OUTPUT.PUT_LINE('������...');
	END IF;
END;
/

--4. CASE��
-- CASE ~ END CASE;
/*
 * CASE
 * 		WHEN ǥ����1 THEN
 * 				���๮;
 * 		WHEN ǥ����2 THEN
 * 				���๮2;
 * 		ELSE �⺻���๮;
 * END CASE;
 * */

DECLARE
	NUM NUMBER(10) := 3;
BEGIN
	CASE NUM
	WHEN 1 THEN 
		DBMS_OUTPUT.PUT_LINE(NUM || '�Դϴ�.');
	WHEN 2 THEN
		DBMS_OUTPUT.PUT_LINE(NUM || '�Դϴپ�');
	WHEN 3 THEN
		DBMS_OUTPUT.PUT_LINE(NUM || '�ϲ���?');
	ELSE
		DBMS_OUTPUT.PUT_LINE('����?');
	END CASE;
END;
/

SELECT * FROM EMPLOYEE;

--�����ȣ�� ���� ��ȸ�� �������� �����ڵ�� ��ǥ, �ӿ���, �Ϲ������� �����ϴ� ������ CASE�� ����

DECLARE
	JOB_CODE EMPLOYEE.JOB_CODE%TYPE;
	EMP_TEAM VARCHAR2(15);
BEGIN
	SELECT JOB_CODE
	INTO JOB_CODE
	FROM EMPLOYEE
	WHERE EMP_ID = '201';
	CASE JOB_CODE
		WHEN 'J1' THEN EMP_TEAM := '��ǥ';
		WHEN 'J2' THEN EMP_TEAM := '�ӿ���';
		ELSE EMP_TEAM := '�Ϲ�����';
	END CASE;
	DBMS_OUTPUT.PUT_LINE('�Ҽ�:' || EMP_TEAM);
END;
/

--PL/SQL �ݺ���
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

--�Ϲ� LOOP��
/*
 * LOOP
 * 		�ݺ���ų ����
 * 		IF �ݺ� ���� ����
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

--FOR �ݺ��� 
--ī��Ʈ�� ������ �ڵ�����, ī��Ʈ ���� �ڵ����� 1�� ����, REVERSE 1�� ����
/*
 * FOR ī��Ʈ���� IN [REVERSE] ���۰�..���ᰪ LOOP
 * �ݺ��� ����;
 * */

BEGIN
	FOR N IN 1..5 LOOP
		DBMS_OUTPUT.PUT_LINE(N);
	END LOOP;
END;
/

--FOR���� �ݴ�� ����

BEGIN
	FOR N IN REVERSE 1..5 LOOP
	DBMS_OUTPUT.PUT_LINE(N);
	END LOOP;
END;
/

--FOR���� ���� INSERT ���
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

--PL/SQL�� FOR �ݺ����� �̿��Ͽ� EMPLOYEE ���̺���
--200������ 210�� ������ ����� ���̵�, �����, �̸����� ���;
BEGIN 
	FOR R IN 1..10 LOOP
	
	END LOOP;
END





