--�з�(īŻ�α�) ���̺� ����
CREATE TABLE CATALOG
 ( CATNO NUMBER NOT NULL, --īŻ�α� ��ȣ
   CATNAME CHAR(10) UNIQUE, --īŻ�α� ��
   PRIMARY KEY (CATNO));
   
   INSERT INTO CATALOG VALUES(1, '����ǰ');
   INSERT INTO CATALOG VALUES(2, '���');
   INSERT INTO CATALOG VALUES(3, '�Ŷ��');
   INSERT INTO CATALOG VALUES(4, '����');
   INSERT INTO CATALOG VALUES(5, '���ö�');
   INSERT INTO CATALOG VALUES(6, '����');
   INSERT INTO CATALOG VALUES(7, '����');
   INSERT INTO CATALOG VALUES(8, '�ַ�');

--��ǰ ���̺� ����   
CREATE TABLE PRODUCT
 (PRONO NUMBER NOT NULL, --��ǰ��ȣ
  PRONAME VARCHAR(100) UNIQUE, --��ǰ��
  CNO NUMBER, --�з���ȣ
  PRICE NUMBER, --����
  PRIMARY KEY (PRONO),
  FOREIGN KEY (CNO) REFERENCES CATALOG(CATNO));
 
    INSERT INTO PRODUCT VALUES(1, '�丮�� ĩ��', 1, 1900);
    INSERT INTO PRODUCT VALUES(2, '2080 ġ�༼Ʈ', 1, 3500);  
    INSERT INTO PRODUCT VALUES(3, '����� �ſ��', 2, 720);  
    INSERT INTO PRODUCT VALUES(4, '�Ŷ��', 2, 830);  
    INSERT INTO PRODUCT VALUES(5, '�����(��) �Ŷ��', 3, 950);  
    INSERT INTO PRODUCT VALUES(6, '������ ��߸�', 3, 850);  
    INSERT INTO PRODUCT VALUES(7, '�̺� �����Ѹ�', 6, 1000);  
    INSERT INTO PRODUCT VALUES(8, '���Ҷ� ����Ĩ', 6, 1500);  
    INSERT INTO PRODUCT VALUES(9, '�����ð�', 6, 1000);  
    INSERT INTO PRODUCT VALUES(10, '��ī��F 120ml', 7, 800);  
    INSERT INTO PRODUCT VALUES(11, '������', 7, 1600);  

--�̺�Ʈ ���̺� ���� 
CREATE TABLE EVENT
 (ENO NUMBER NOT NULL, --�̺�Ʈ ��ȣ
  EVENT_NAME VARCHAR(50), --�̺�Ʈ ��
  PRIMARY KEY (ENO));
  
  INSERT INTO EVENT VALUES(1, '1+1');
  INSERT INTO EVENT VALUES(2, '2+1');
  INSERT INTO EVENT VALUES(3, '2+2');
  INSERT INTO EVENT VALUES(4, '500�� ����');

--���ǸŻ�ǰ ���̺� ����    
CREATE TABLE REALPROD
 ( REALNO NUMBER NOT NULL, --��ǳ��ȣ
   REALNAME CHAR(50), --��ǰ��
   CREALNO NUMBER, --�з���ȣ
   REAL_PRICE NUMBER, --����
   REAL_ENO NUMBER, --�̺�Ʈ ��ȣ
   EVENTPERIOD VARCHAR(20), --�̺�Ʈ �Ⱓ
   STOCK NUMBER, --���
   EXPI VARCHAR(20), -- �������
   PRIMARY KEY (REALNO),
   FOREIGN KEY (CREALNO) REFERENCES CATALOG(CATNO),
   FOREIGN KEY (REAL_ENO) REFERENCES EVENT(ENO)
            ON DELETE CASCADE);
                  
    INSERT INTO REALPROD VALUES(1, '�丮�� ĩ��', 1, 950, 1, '2020-12-09', 10, NULL);
    INSERT INTO REALPROD VALUES(2, '2080 ġ�༼Ʈ', 1, 3500, NULL, NULL, 10, NULL);  
    INSERT INTO REALPROD VALUES(3, '����� �ſ��', 2, 720, NULL, NULL, 50, '2021-01-30');
    INSERT INTO REALPROD VALUES(4, '�Ŷ��', 2, 830, NULL, NULL, 20, '2020-01-30'); 
    INSERT INTO REALPROD VALUES(5, '�����(��) �Ŷ��', 3, 475, 1, '2020-12-10', 46, '2021-01-30');  
    INSERT INTO REALPROD VALUES(6, '������ ��߸�', 3, 850, NULL, NULL, 50, '2021-01-30');  
    INSERT INTO REALPROD VALUES(7, '�̺� �����Ѹ�', 6, 1000, NULL, NULL, 2, '2020-12-11');  
    INSERT INTO REALPROD VALUES(8, '���Ҷ� ����Ĩ', 6, 1500, NULL, NULL, 20, '2020-12-31');
    INSERT INTO REALPROD VALUES(9, '�����ð�', 6, 1000, NULL, NULL, 20, '2020-12-31');  
    INSERT INTO REALPROD VALUES(10, '��ī��F 120ml', 7, 800, NULL, NULL, 20, '2020-12-31');  
    INSERT INTO REALPROD VALUES(11, '������', 7, 1100, 4, '2020-12-20', 6, '2020-12-31');  
   
--���� ���̺� ����  
CREATE TABLE SALES
 (SNO NUMBER NOT NULL, --�ǸŹ�ȣ
  SALE_DAY VARCHAR(20), --�Ǹ�����
  SALE_TIME VARCHAR(10), --�ǸŽð�
  SALE_PRONO NUMBER, --��ǰ��ȣ
  SALE_QUAN NUMBER, --�ǸŰ���
  SALE_MONEY NUMBER, --����
  SALE_PAY VARCHAR(10), --�������
  PRIMARY KEY (SNO),
  FOREIGN KEY (SALE_PRONO) REFERENCES REALPROD(REALNO));
 
 INSERT INTO SALES VALUES(1, '2020-11-06', '12:26', 1, 2, 1900,'ī��');
 INSERT INTO SALES VALUES(2, '2020-11-06', '16:26', 3, 3, 2160,'ī��');
 INSERT INTO SALES VALUES(3, '2020-11-15', '13:50', 6, 2, 2000,'����');
 INSERT INTO SALES VALUES(4, '2020-11-20', '17:48', 2, 1, 3500,'����');
 INSERT INTO SALES VALUES(5, '2020-11-28', '08:26', 7, 2, 1600,'ī��');
 INSERT INTO SALES VALUES(6, '2020-11-28', '12:25', 1, 2, 1900,'ī��');
 INSERT INTO SALES VALUES(7, '2020-12-03', '13:34', 9, 2, 2200,'����');
 INSERT INTO SALES VALUES(8, '2020-12-04', '12:22', 7, 6, 9000,'ī��');
 INSERT INTO SALES VALUES(9, '2020-12-06', '12:58', 1, 2, 1900,'����');    
 
--���� ���̺� ����  
CREATE TABLE ORD
 (ORD_NO NUMBER NOT NULL, --���ֹ�ȣ
  ORD_DAY VARCHAR(15), --��������
  ORD_PROD NUMBER, -- �ֹ� ��ǰ
  ORD_QUAN NUMBER, --���ַ�
  ORD_MONEY NUMBER, --�ݾ�
  PRIMARY KEY (ORD_NO),
  FOREIGN KEY (ORD_NO) REFERENCES REALPROD(REALNO));
  
  INSERT INTO ORD VALUES(1, '2020-12-06', 1, 20, 10000);
  INSERT INTO ORD VALUES(2, '2020-12-06', 9, 20, 20000);
  
--���� ���̺� ����
CREATE TABLE EMPLOYEE
 (EMPNO NUMBER NOT NULL, --������ȣ
  EMP_NAME VARCHAR(10), --�̸�
  EMP_PHONE CHAR(15) UNIQUE, --��ȭ��ȣ
  TITLE VARCHAR(10), --����
  SALARY NUMBER, --����
  WORK_TIME NUMBER, --�ٹ��ð�
  WORK_EVAL VARCHAR(100), --�ٹ���
  PRIMARY KEY (EMPNO));
  
  INSERT INTO EMPLOYEE VALUES(1, '�����', '010-8260-9999', '�Ŵ���', 600000, 50, 'ģ����');
  INSERT INTO EMPLOYEE VALUES(2, '���ٶ�', '010-1111-3498', '�˹�', 400000, 40, 'ģ����');
  INSERT INTO EMPLOYEE VALUES(3, '���ٻ�', '010-1234-9576', '�˹�', 300000, 30, 'ģ����');
  INSERT INTO EMPLOYEE VALUES(4, 'ȫ�浿', '010-2353-0000', '�˹�', 400000, 40, '��ģ����');
 
--������ ���̺� ����
CREATE TABLE TOOL
 (MAN_DAY VARCHAR(10), --Ȯ�γ�¥
  TOOL_NO NUMBER NOT NULL, --�������ȣ
  TOOL_NAME VARCHAR(20), --�������
  TOOL_ROUND NUMBER, --����
  TOOL_NOTE VARCHAR(100), --���(���������)
  MAN_NO NUMBER, --������ ��ȣ
  PRIMARY KEY (TOOL_NO),
  FOREIGN KEY (MAN_NO) REFERENCES EMPLOYEE(EMPNO));
  
  INSERT INTO TOOL VALUES('2020-11-30', 1, '����', 8, NULL, 1);
  INSERT INTO TOOL VALUES('2020-11-30', 2, 'å��', 8, '�ٸ��� ������', 2);
  INSERT INTO TOOL VALUES('2020-11-30', 3, '������', 1, NULL, 3);
  INSERT INTO TOOL VALUES('2020-11-30', 4, '���ڷ�����', 3, NULL, 4);
  
--�ù� ���̺� ����  
CREATE TABLE PARCEL 
 (PARCEL_NO NUMBER NOT NULL, --�ù��ȣ
  CONSIGNOR VARCHAR(10), --�߼���
  ADDRESS VARCHAR(30), --�ּ�
  WEIGHT NUMBER, --����
  PMONEY NUMBER, --���
  PRIMARY KEY (PARCEL_NO));

    INSERT INTO PARCEL VALUES(1, '������', '�����', 440, 2900);
    INSERT INTO PARCEL VALUES(2, 'ȫ�浿', '�����', 300, 2000);

--�ù�ȸ�� ���̺� ����  
CREATE TABLE SERVICECOMPANY
 (SERNO NUMBER NOT NULL, --�ù��ȣ
  INVOICE NUMBER, --�����ȣ
  DELMAN VARCHAR (10), --�ù����
  PRIMARY KEY (SERNO),
  FOREIGN KEY (SERNO) REFERENCES PARCEL(PARCEL_NO));
  
  INSERT INTO SERVICECOMPANY VALUES(1,385066070251,'���Ѿ�');
  INSERT INTO SERVICECOMPANY VALUES(2,235324248434,'��ż�');
  


--���� ���� ���̺� ����
CREATE TABLE MONTHPROFIT
 (YEAR_MONTH CHAR(10) NOT NULL, --�� ��
  PROFIT NUMBER, --����(�������)
  ORDERCOST NUMBER, --���ֺ��
  PERSON_EX NUMBER, --�ΰǺ��
  NET NUMBER, --������(=����-���ֺ��-�ΰǺ��)
  PRIMARY KEY (YEAR_MONTH));
  
  INSERT INTO MONTHPROFIT VALUES('2020-11', 6000000,1000000, 1700000, 3300000);
  
                                            

  
--<�̺�Ʈ ǰ�� ���� ���� ���>
--���� ���� �� �̺�Ʈ ���� ����
UPDATE REALPROD SET REAL_PRICE =(SELECT PRICE FROM PRODUCT
                                    WHERE PRONO = (SELECT REALNO 
                                    FROM REALPROD
                                    WHERE EVENTPERIOD = '2020-12-09')), REAL_ENO = NULL, EVENTPERIOD = NULL 
                WHERE REALNO = (SELECT REALNO FROM REALPROD
                                    WHERE EVENTPERIOD = '2020-12-09');

                
                                       
--<�ù� ���� ���>
--�ù� �߼� �� ������ �߰�
DELETE FROM ORD WHERE ORD_NO = 3;

--�ù� ���� ������������ �ù� �߼� ���� �˻�
SELECT * FROM PARCEL, SERVICECOMPANY WHERE SERNO = PARCEL_NO ORDER BY WEIGHT DESC;



 --<���� ���� ���>
 --����ݾ��� ���� ���� ��ǰ �˻�
SELECT * FROM REALPROD WHERE REALNO = (SELECT SALE_PRONO FROM SALES 
                                        WHERE SALE_PRONO = (SELECT SALE_PRONO 
                                                                FROM SALES 
                                                                GROUP BY SALE_PRONO 
                                                                HAVING SUM(SALE_QUAN) >= ALL(SELECT SUM(SALE_QUAN) 
                                                                                                FROM SALES 
                                                                                                GROUP BY SALE_PRONO))
                                        GROUP BY SALE_PRONO);       
            
--��ǰ ���� �� ���� ���� ����
    INSERT INTO SALES VALUES(9, '2020-12-09', '16:00', 6, 2, 2000,'ī��');
    SELECT * FROM SALES;
    
--���ǸŻ�ǰ���� �ش� ǰ�� ���� ������ŭ ������� ����
    UPDATE REALPROD SET STOCK = STOCK - (SELECT SALE_QUAN 
                                            FROM SALES 
                                            WHERE SNO >= ALL(SELECT SNO FROM SALES)) 
                    WHERE REALNO = (SELECT SALE_PRONO 
                                            FROM SALES 
                                            WHERE SNO >= ALL(SELECT SNO FROM SALES));
    SELECT * FROM REALPROD;


                    
                                            
--<���� ���� ���� ���>
INSERT INTO MONTHPROFIT VALUES('2020-12', NULL, NULL, NULL, NULL);
UPDATE MONTHPROFIT SET PROFIT = (SELECT SUM(SALE_MONEY) FROM SALES)  WHERE YEAR_MONTH = '2020-12';
UPDATE MONTHPROFIT SET ORDERCOST = (SELECT SUM(ORD_MONEY) FROM ORD) WHERE YEAR_MONTH = '2020-12';
UPDATE MONTHPROFIT SET PERSON_EX = (SELECT SUM(SALARY) FROM EMPLOYEE) WHERE YEAR_MONTH = '2020-12';
UPDATE MONTHPROFIT SET NET = (PROFIT-ORDERCOST-PERSON_EX) WHERE YEAR_MONTH = '2020-12';
SELECT * FROM MONTHPROFIT;


--<������ѿ� ���� ���� ���>
--������� �ӹ� ��ǰ �˻�
SELECT REALNO, REALNAME, EXPI
FROM REALPROD
WHERE (TO_DATE(EXPI, 'YYYY-MM-DD') - TO_DATE('2020-12-09', 'YYYY-MM-DD')) <= 3;

--�ʿ�ǰ�� 20�� �߰� �ֹ�
INSERT INTO ORD VALUES(3, '2020-12-09', 7, 20, 10000);

