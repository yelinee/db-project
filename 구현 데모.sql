--<�̺�Ʈ ǰ�� ���� ���� ���>
--���� ���� �� �̺�Ʈ ���� ����
UPDATE REALPROD SET REAL_PRICE =(SELECT PRICE FROM PRODUCT
                                    WHERE PRONO = (SELECT REALNO 
                                    FROM REALPROD
                                    WHERE EVENTPERIOD = '2020-12-09')), REAL_ENO = NULL, EVENTPERIOD = NULL 
                WHERE REALNO = (SELECT REALNO FROM REALPROD
                                    WHERE EVENTPERIOD = '2020-12-09');
SELECT * FROM REALPROD WHERE EVENTPERIOD = '2020-12-09';
SELECT * FROM REALPROD WHERE REALNO = 1;

                
                                       
--<�ù� ���� ���>
--�ù� �߼� �� ������ �߰�
INSERT INTO PARCEL VALUES(3, '���ù�', '�����', 300, 2000);
INSERT INTO SERVICECOMPANY VALUES(3,235324248434,'��ż�');

--�ù� ���� ������������ �ù� �߼� ���� �˻�
SELECT * FROM PARCEL, SERVICECOMPANY WHERE SERNO = PARCEL_NO ORDER BY WEIGHT DESC;



 --<���� ���� ���>
 --����ݾ��� ���� ���� ��ǰ �˻�
SELECT SALE_PRONO, SUM(SALE_MONEY) FROM SALES GROUP BY SALE_PRONO;                             
SELECT * FROM REALPROD WHERE REALNO = (SELECT SALE_PRONO FROM SALES 
                                        WHERE SALE_PRONO = (SELECT SALE_PRONO 
                                                                FROM SALES 
                                                                GROUP BY SALE_PRONO 
                                                                HAVING SUM(SALE_QUAN) >= ALL(SELECT SUM(SALE_QUAN) 
                                                                                                FROM SALES 
                                                                                                GROUP BY SALE_PRONO))
                                        GROUP BY SALE_PRONO);       
            
--��ǰ ���� �� ���� ���� ����
    INSERT INTO SALES VALUES(10, '2020-12-09', '16:00', 6, 2, 2000,'ī��');
    
--���ǸŻ�ǰ���� �ش� ǰ�� ���� ������ŭ ������� ����
    UPDATE REALPROD SET STOCK = STOCK - (SELECT SALE_QUAN 
                                            FROM SALES 
                                            WHERE SNO >= ALL(SELECT SNO FROM SALES)) 
                    WHERE REALNO = (SELECT SALE_PRONO 
                                            FROM SALES 
                                            WHERE SNO >= ALL(SELECT SNO FROM SALES));
    SELECT * FROM REALPROD;

--<���⿡ ���� ���� ���>
SELECT SALE_PRONO, SUBSTR(SALE_DAY, 1, 7) AS MONTH, SUM(SALE_QUAN) FROM SALES GROUP BY SALE_PRONO, SUBSTR(SALE_DAY, 1, 7) ORDER BY SALE_PRONO;
INSERT INTO ORD VALUES(3, '2020-12-09', 7, 20, 10000);
SELECT * FROM ORD;
                                            
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
INSERT INTO ORD VALUES(4, '2020-12-09', 6, 20, 10000);
SELECT * FROM ORD;


DROP TABLE MONTHPROFIT;
DROP TABLE SERVICECOMPANY;
DROP TABLE PARCEL;
DROP TABLE TOOL;
DROP TABLE EMPLOYEE;
DROP TABLE ORD;
DROP TABLE SALES;
DROP TABLE REALPROD;
DROP TABLE PRODUCT;
DROP TABLE EVENT;
DROP TABLE CATALOG;