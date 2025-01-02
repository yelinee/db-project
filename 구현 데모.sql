--<이벤트 품목 가격 지정 기능>
--가격 변경 및 이벤트 내역 수정
UPDATE REALPROD SET REAL_PRICE =(SELECT PRICE FROM PRODUCT
                                    WHERE PRONO = (SELECT REALNO 
                                    FROM REALPROD
                                    WHERE EVENTPERIOD = '2020-12-09')), REAL_ENO = NULL, EVENTPERIOD = NULL 
                WHERE REALNO = (SELECT REALNO FROM REALPROD
                                    WHERE EVENTPERIOD = '2020-12-09');
SELECT * FROM REALPROD WHERE EVENTPERIOD = '2020-12-09';
SELECT * FROM REALPROD WHERE REALNO = 1;

                
                                       
--<택배 관리 기능>
--택배 발송 시 데이터 추가
INSERT INTO PARCEL VALUES(3, '김택배', '서울시', 300, 2000);
INSERT INTO SERVICECOMPANY VALUES(3,235324248434,'김신속');

--택배 무게 내림차순으로 택배 발송 내역 검색
SELECT * FROM PARCEL, SERVICECOMPANY WHERE SERNO = PARCEL_NO ORDER BY WEIGHT DESC;



 --<매출 관리 기능>
 --매출금액이 가장 많은 상품 검색
SELECT SALE_PRONO, SUM(SALE_MONEY) FROM SALES GROUP BY SALE_PRONO;                             
SELECT * FROM REALPROD WHERE REALNO = (SELECT SALE_PRONO FROM SALES 
                                        WHERE SALE_PRONO = (SELECT SALE_PRONO 
                                                                FROM SALES 
                                                                GROUP BY SALE_PRONO 
                                                                HAVING SUM(SALE_QUAN) >= ALL(SELECT SUM(SALE_QUAN) 
                                                                                                FROM SALES 
                                                                                                GROUP BY SALE_PRONO))
                                        GROUP BY SALE_PRONO);       
            
--상품 구매 시 매출 내역 생성
    INSERT INTO SALES VALUES(10, '2020-12-09', '16:00', 6, 2, 2000,'카드');
    
--실판매상품에서 해당 품목 구매 개수만큼 재고량에서 차감
    UPDATE REALPROD SET STOCK = STOCK - (SELECT SALE_QUAN 
                                            FROM SALES 
                                            WHERE SNO >= ALL(SELECT SNO FROM SALES)) 
                    WHERE REALNO = (SELECT SALE_PRONO 
                                            FROM SALES 
                                            WHERE SNO >= ALL(SELECT SNO FROM SALES));
    SELECT * FROM REALPROD;

--<매출에 따른 발주 기능>
SELECT SALE_PRONO, SUBSTR(SALE_DAY, 1, 7) AS MONTH, SUM(SALE_QUAN) FROM SALES GROUP BY SALE_PRONO, SUBSTR(SALE_DAY, 1, 7) ORDER BY SALE_PRONO;
INSERT INTO ORD VALUES(3, '2020-12-09', 7, 20, 10000);
SELECT * FROM ORD;
                                            
--<월별 이익 산출 기능>
INSERT INTO MONTHPROFIT VALUES('2020-12', NULL, NULL, NULL, NULL);
UPDATE MONTHPROFIT SET PROFIT = (SELECT SUM(SALE_MONEY) FROM SALES)  WHERE YEAR_MONTH = '2020-12';
UPDATE MONTHPROFIT SET ORDERCOST = (SELECT SUM(ORD_MONEY) FROM ORD) WHERE YEAR_MONTH = '2020-12';
UPDATE MONTHPROFIT SET PERSON_EX = (SELECT SUM(SALARY) FROM EMPLOYEE) WHERE YEAR_MONTH = '2020-12';
UPDATE MONTHPROFIT SET NET = (PROFIT-ORDERCOST-PERSON_EX) WHERE YEAR_MONTH = '2020-12';

SELECT * FROM MONTHPROFIT;


--<유통기한에 따른 발주 기능>
--유통기한 임박 상품 검색
SELECT REALNO, REALNAME, EXPI
FROM REALPROD
WHERE (TO_DATE(EXPI, 'YYYY-MM-DD') - TO_DATE('2020-12-09', 'YYYY-MM-DD')) <= 3;

--필요품목 20개 추가 주문
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