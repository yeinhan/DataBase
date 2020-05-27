-------------0527
--PL/SQL�� FOR �ݺ����� �̿��Ͽ� EMPLOYEE ���̺���
--200������ 210�� ������ ����� ���̵�, �����, �̸����� ���;
DECLARE
	E EMPLOYEE%ROWTYPE;
BEGIN 
	DBMS_OUTPUT.PUT_LINE('ID     NAME     EMAIL	');
	DBMS_OUTPUT.PUT_LINE('----------------------');
	FOR I IN 0..10 LOOP
		SELECT *
		INTO E
		FROM EMPLOYEE
		WHERE EMP_ID = 200 + I;
		DBMS_OUTPUT.PUT_LINE(E.EMP_ID || '    ' || E.EMP_NAME || '     ' || E.EMAIL);
	END LOOP;
END;
/

--WHERE 
--���� ������ TRUE�� ���ȸ� ������ �ݺ� ����

--[�����]
-- WHILE �ݺ��� ���ǽ� LOOP
--�ݺ��� ��ũ��Ʈ ����
--END LOOP;
DECLARE
	N INT := 5;
BEGIN
	WHILE N>0 LOOP 
		DBMS_OUTPUT.PUT_LINE(N);
		N := N-1;
	END LOOP;
END;
/

--WHILE�� �̿��Ͽ� ������
DECLARE 
	DAN NUMBER := 5;
	N NUMBER :=2;
BEGIN
	WHILE N<=9 LOOP
		DBMS_OUTPUT.PUT_LINE(DAN||'  *  '||N||'  =  '||DAN *N);
		N := N+1;
	END LOOP;
END;
/


--PL/SQL ��ü--
--���ν���, Ʈ����, �Լ�
--���ν���: PL/SQL�� �̸� ������ ���Ҵٰ� ���ν����� ȣ���Ͽ� �Լ�ó�� ���۽�Ű�� ��ü

--[�������]
--CREATE [OR REPLACE] PROCEDURE ���ν����� (�Ű�����1 [IN/OUT/IN OUT] �ڷ���[, �Ű����� 2 �ڷ���])
-- 							IN: ���ν������� ����� ���� ���� �ܺο��� �޾� �� �� ����ϴ� ���
--							OUT: ���ν����� ������ ����� �ܺη� �����Ҷ� ����ϴ� ���
--							IN OUT: �ΰ��� ����� �����ؼ� ����Ҽ��ִ� ���						
--IS -> DECLARE(�����)
-- ��������;
--BEGIN
--	������ �ڵ�;
--END
--/

--[ȣ����]
-- EXECUTE ���ν�����[(���ް�, ���ް�2,...)];
-- EXEC		"		 		"
--[�輼]
--DROP PROCEDURE ���ν�����;

CREATE TABLE EMP_TMP
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_TMP;
SELECT COUNT(*) FROM EMP_TMP;

--���ν��� �ۼ�
CREATE OR REPLACE PROCEDURE DEL_ALL_EMP
IS --��������
BEGIN 
	DELETE FROM EMP_TMP;
	COMMIT;
END;
/

SELECT COUNT(*) FROM EMP_TMP;

--���ν��� ����
EXEC DEL_ALL_EMP;


DROP TABLE EMP_TMP;

--�Ű������� ���� ���ν���
-- IN --IN���� �ܺ��� ���� ���η� �����ϴ� ���
CREATE TABLE EMP_TMP_01
AS SELECT * FROM EMPLOYEE;

SELECT * FROM EMP_TMP_01;

--���ν��� ����
CREATE OR REPLACE PROCEDURE DEL_EMP_NAME(V_NAME IN EMP_TMP_01.EMP_NAME%TYPE)
IS 
BEGIN 
	DELETE FROM EMP_TMP_01 
	WHERE EMP_NAME LIKE V_NAME;
	DBMS_OUTPUT.PUT_LINE(V_NAME || '���������� �����Ǿ����ϴ�.');
	COMMIT;
END;
/

--����
EXEC DEP_EMP_NAME('���ؿ�¯');

--���� �̾��� ������� ��λ���
EXEC DEP_EMP_NAME('��%');


--OUT ������ ���� �ܺη� �����ϴ� ���
--	�ܺο����� ���� ���� �� �ְ� VARIABLE ��ü�� ����

--������ ���� ���� ���� ���� ����
--VARIABLE ������ �ڷ���(ũ��);

--EXEC ���ν���(���ް�, :���޹���������);
CREATE OR REPLACE PROCEDURE 
	EMP_INFO(VEMP_ID IN EMPLOYEE.EMP_ID%TYPE,
			 VEMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
			 VPHONE OUT EMPLOYEE.PHONE%TYPE)
IS
BEGIN 
	SELECT EMP_NAME, PHONE
	INTO VEMP_NAME, VPHONE
	FROM EMPLOYEE
	WHERE EMP_ID = VEMP_ID;
END;
/

--OUT�Ǵ� �����͸� ���� ���� ����
VARIABLE VAR_ENAME VARCHAR2(30);
VARIABLE VAR_PHONE VARCHAR2(30);

--PRINT
PRINT VAR_ENAME;


EXEC EMP_INFO(201, :VAR_ENAME, :VAR_PHONE);

--FUNCTION--
--���ο��� ���� ����� ��ȯ�ϴ� ��ü
--MAX, MIN, SUM, AVG
--���ν����� ���.

--�Լ�:���ϰ� ����, ������ ����� ������ ���°�
--���ν���: ���ϰ� ����. �����ϴ� ���� �� ��ü�� ����

/*
 * [�������]
 * CREATE [OR REPLACE] FUNCTION �Լ���(�Ű����� [���] �ڷ���)
 * RETURN �ڷ���; 	--��ȯ�� ����� �ڷ���
 * IS
 * BEGIN
 * RETURN ���������;
 * END;
 */

CREATE OR REPLACE FUNCTION BONUS_CALC(V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE)
RETURN NUMBER
IS 
	V_SAL EMPLOYEE.SALARY%TYPE;
	V_BONUS EMPLOYEE.BONUS%TYPE;
	RESULT NUMBER;
BEGIN 
	SELECT SALARY, NVL(BONUS, 0)
	INTO V_SAL, V_BONUS
	FROM EMPLOYEE
	WHERE EMP_ID = V_EMP_ID;
	RESULT := V_SAL*V_BONUS;
	RETURN RESULT;
END;
/

PRINT RESULT_SAL;


--TRIGGER--
--Ư�� ���̺��̳� ���� DML�� ���� ������ ��ȯ�� �Ͼ��
--�׽����� �����Ͽ� �ڵ����� �����ϴ� ��ũ��Ʈ
--����ڰ� DML�� �����ϴ� ���� �ƴ϶� �����ͺ��̽����� �ڵ����� ó���ϴ� ������ �����ϴ� ��ü

--��ǰ���� �ý���
--��ǰ ���� ���̺�
CREATE TABLE PRODUCT(
	PCODE NUMBER PRIMARY KEY,
	PNAME VARCHAR2(30),
	BRAND VARCHAR2(30),
	PRICE NUMBER,
	STOCK NUMBER DEFAULT 0
);

--����� ���� ���̺�
CREATE TABLE PRODUCT_DETAIL(
	DCODE NUMBER PRIMARY KEY,
	PCODE NUMBER NOT NULL,
	PDATE DATE DEFAULT SYSDATE,
	AMOUNT NUMBER,
	STATUS CHAR(6) CHECK(STATUS IN ('�԰�','���')),
	CONSTRAINT FK_PRODUCT FOREIGN KEY(PCODE) REFERENCES PRODUCT
);

SELECT * FROM PRODUCT;
SELECT * FROM PRODUCT_DETAIL;

CREATE SEQUENCE SEQ_PRODUCT;
CREATE SEQUENCE SEQ_DETAIL;
--��ǰ���--
--INSERT INTO PRODUCT VALUES(SEQ_PRODUCT.NEXTVAL, '��ǰ��','�귣��', ����, DEFAULT);
INSERT INTO PRODUCT
VALUES(SEQ_PRODUCT.NEXTVAL, '��Ʈ��','APPLE',3000000,DEFAULT);
INSERT INTO PRODUCT
VALUES(SEQ_PRODUCT.NEXTVAL, 'TV','LG',1000000,DEFAULT);
INSERT INTO PRODUCT
VALUES(SEQ_PRODUCT.NEXTVAL, '�ڵ���','SAMSUNG',1200000,DEFAULT);
INSERT INTO PRODUCT
VALUES(SEQ_PRODUCT.NEXTVAL, '����','�𳪹�',50000,DEFAULT);
COMMIT;

SELECT * FROM PRODUCT;

--��ǰ ��.��� ��� ��� ���� Ʈ����
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON PRODUCT_DETAIL
FOR EACH ROW
BEGIN
	IF :NEW.STATUS='�԰�'	
	THEN 
		UPDATE PRODUCT
		SET STOCK = STOCK + :NEW.AMOUNT
		WHERE PCODE = :NEW.PCODE;
	END IF;
	IF :NEW.STATUS ='���'
	THEN
		UPDATE PRODUCT
		SET STOCK = STOCK - :NEW.AMOUNT
		WHERE PCODE = :NEW.PCODE;
	END IF;
END;
/

COMMIT;

INSERT INTO PRODUCT_DETAIL 
VALUES(SEQ_DETAIL.NEXTVAL, 3, SYSDATE, 10,'���');

INSERT INTO PRODUCT_DETAIL 
VALUES(SEQ_DETAIL.NEXTVAL, 1, SYSDATE, 10,'�԰�');

INSERT INTO PRODUCT_DETAIL 
VALUES(SEQ_DETAIL.NEXTVAL, 2, SYSDATE, 7,'�԰�');

INSERT INTO PRODUCT_DETAIL 
VALUES(SEQ_DETAIL.NEXTVAL, 4, SYSDATE, 14,'���');

INSERT INTO PRODUCT_DETAIL 
VALUES(SEQ_DETAIL.NEXTVAL, 4, SYSDATE, 10,'�԰�');

INSERT INTO PRODUCT_DETAIL 
VALUES(SEQ_DETAIL.NEXTVAL, 4, SYSDATE, 10,'�԰�');

SELECT * FROM PRODUCT_DETAIL;
SELECT * FROM PRODUCT;

COMMIT;