--분류(카탈로그) 테이블 생성
CREATE TABLE CATALOG
 ( CATNO NUMBER NOT NULL, --카탈로그 번호
   CATNAME CHAR(10) UNIQUE, --카탈로그 명
   PRIMARY KEY (CATNO));
   
   INSERT INTO CATALOG VALUES(1, '생필품');
   INSERT INTO CATALOG VALUES(2, '라면');
   INSERT INTO CATALOG VALUES(3, '컵라면');
   INSERT INTO CATALOG VALUES(4, '김밥류');
   INSERT INTO CATALOG VALUES(5, '도시락');
   INSERT INTO CATALOG VALUES(6, '과자');
   INSERT INTO CATALOG VALUES(7, '음료');
   INSERT INTO CATALOG VALUES(8, '주류');

--상품 테이블 생성   
CREATE TABLE PRODUCT
 (PRONO NUMBER NOT NULL, --상품번호
  PRONAME VARCHAR(100) UNIQUE, --상품명
  CNO NUMBER, --분류번호
  PRICE NUMBER, --가격
  PRIMARY KEY (PRONO),
  FOREIGN KEY (CNO) REFERENCES CATALOG(CATNO));
 
    INSERT INTO PRODUCT VALUES(1, '페리오 칫솔', 1, 1900);
    INSERT INTO PRODUCT VALUES(2, '2080 치약세트', 1, 3500);  
    INSERT INTO PRODUCT VALUES(3, '진라면 매운맛', 2, 720);  
    INSERT INTO PRODUCT VALUES(4, '신라면', 2, 830);  
    INSERT INTO PRODUCT VALUES(5, '진라면(매) 컵라면', 3, 950);  
    INSERT INTO PRODUCT VALUES(6, '육개장 사발면', 3, 850);  
    INSERT INTO PRODUCT VALUES(7, '쫄병 매콤한맛', 6, 1000);  
    INSERT INTO PRODUCT VALUES(8, '무뚝뚝 감자칩', 6, 1500);  
    INSERT INTO PRODUCT VALUES(9, '자유시간', 6, 1000);  
    INSERT INTO PRODUCT VALUES(10, '박카스F 120ml', 7, 800);  
    INSERT INTO PRODUCT VALUES(11, '블랙보리', 7, 1600);  

--이벤트 테이블 생성 
CREATE TABLE EVENT
 (ENO NUMBER NOT NULL, --이벤트 번호
  EVENT_NAME VARCHAR(50), --이벤트 명
  PRIMARY KEY (ENO));
  
  INSERT INTO EVENT VALUES(1, '1+1');
  INSERT INTO EVENT VALUES(2, '2+1');
  INSERT INTO EVENT VALUES(3, '2+2');
  INSERT INTO EVENT VALUES(4, '500원 할인');

--실판매상품 테이블 생성    
CREATE TABLE REALPROD
 ( REALNO NUMBER NOT NULL, --상풍번호
   REALNAME CHAR(50), --상품명
   CREALNO NUMBER, --분류번호
   REAL_PRICE NUMBER, --가격
   REAL_ENO NUMBER, --이벤트 번호
   EVENTPERIOD VARCHAR(20), --이벤트 기간
   STOCK NUMBER, --재고
   EXPI VARCHAR(20), -- 유통기한
   PRIMARY KEY (REALNO),
   FOREIGN KEY (CREALNO) REFERENCES CATALOG(CATNO),
   FOREIGN KEY (REAL_ENO) REFERENCES EVENT(ENO)
            ON DELETE CASCADE);
                  
    INSERT INTO REALPROD VALUES(1, '페리오 칫솔', 1, 950, 1, '2020-12-09', 10, NULL);
    INSERT INTO REALPROD VALUES(2, '2080 치약세트', 1, 3500, NULL, NULL, 10, NULL);  
    INSERT INTO REALPROD VALUES(3, '진라면 매운맛', 2, 720, NULL, NULL, 50, '2021-01-30');
    INSERT INTO REALPROD VALUES(4, '신라면', 2, 830, NULL, NULL, 20, '2020-01-30'); 
    INSERT INTO REALPROD VALUES(5, '진라면(매) 컵라면', 3, 475, 1, '2020-12-10', 46, '2021-01-30');  
    INSERT INTO REALPROD VALUES(6, '육개장 사발면', 3, 850, NULL, NULL, 50, '2021-01-30');  
    INSERT INTO REALPROD VALUES(7, '쫄병 매콤한맛', 6, 1000, NULL, NULL, 2, '2020-12-11');  
    INSERT INTO REALPROD VALUES(8, '무뚝뚝 감자칩', 6, 1500, NULL, NULL, 20, '2020-12-31');
    INSERT INTO REALPROD VALUES(9, '자유시간', 6, 1000, NULL, NULL, 20, '2020-12-31');  
    INSERT INTO REALPROD VALUES(10, '박카스F 120ml', 7, 800, NULL, NULL, 20, '2020-12-31');  
    INSERT INTO REALPROD VALUES(11, '블랙보리', 7, 1100, 4, '2020-12-20', 6, '2020-12-31');  
   
--매출 테이블 생성  
CREATE TABLE SALES
 (SNO NUMBER NOT NULL, --판매번호
  SALE_DAY VARCHAR(20), --판매일자
  SALE_TIME VARCHAR(10), --판매시간
  SALE_PRONO NUMBER, --상품번호
  SALE_QUAN NUMBER, --판매개수
  SALE_MONEY NUMBER, --매출
  SALE_PAY VARCHAR(10), --결제방식
  PRIMARY KEY (SNO),
  FOREIGN KEY (SALE_PRONO) REFERENCES REALPROD(REALNO));
 
 INSERT INTO SALES VALUES(1, '2020-11-06', '12:26', 1, 2, 1900,'카드');
 INSERT INTO SALES VALUES(2, '2020-11-06', '16:26', 3, 3, 2160,'카드');
 INSERT INTO SALES VALUES(3, '2020-11-15', '13:50', 6, 2, 2000,'현금');
 INSERT INTO SALES VALUES(4, '2020-11-20', '17:48', 2, 1, 3500,'현금');
 INSERT INTO SALES VALUES(5, '2020-11-28', '08:26', 7, 2, 1600,'카드');
 INSERT INTO SALES VALUES(6, '2020-11-28', '12:25', 1, 2, 1900,'카드');
 INSERT INTO SALES VALUES(7, '2020-12-03', '13:34', 9, 2, 2200,'현금');
 INSERT INTO SALES VALUES(8, '2020-12-04', '12:22', 7, 6, 9000,'카드');
 INSERT INTO SALES VALUES(9, '2020-12-06', '12:58', 1, 2, 1900,'현금');    
 
--발주 테이블 생성  
CREATE TABLE ORD
 (ORD_NO NUMBER NOT NULL, --발주번호
  ORD_DAY VARCHAR(15), --발주일자
  ORD_PROD NUMBER, -- 주문 상품
  ORD_QUAN NUMBER, --발주량
  ORD_MONEY NUMBER, --금액
  PRIMARY KEY (ORD_NO),
  FOREIGN KEY (ORD_NO) REFERENCES REALPROD(REALNO));
  
  INSERT INTO ORD VALUES(1, '2020-12-06', 1, 20, 10000);
  INSERT INTO ORD VALUES(2, '2020-12-06', 9, 20, 20000);
  
--직원 테이블 생성
CREATE TABLE EMPLOYEE
 (EMPNO NUMBER NOT NULL, --직원번호
  EMP_NAME VARCHAR(10), --이름
  EMP_PHONE CHAR(15) UNIQUE, --전화번호
  TITLE VARCHAR(10), --직급
  SALARY NUMBER, --월급
  WORK_TIME NUMBER, --근무시간
  WORK_EVAL VARCHAR(100), --근무평가
  PRIMARY KEY (EMPNO));
  
  INSERT INTO EMPLOYEE VALUES(1, '김민지', '010-8260-9999', '매니저', 600000, 50, '친절함');
  INSERT INTO EMPLOYEE VALUES(2, '나다라', '010-1111-3498', '알바', 400000, 40, '친절함');
  INSERT INTO EMPLOYEE VALUES(3, '마바사', '010-1234-9576', '알바', 300000, 30, '친절함');
  INSERT INTO EMPLOYEE VALUES(4, '홍길동', '010-2353-0000', '알바', 400000, 40, '불친절함');
 
--기자재 테이블 생성
CREATE TABLE TOOL
 (MAN_DAY VARCHAR(10), --확인날짜
  TOOL_NO NUMBER NOT NULL, --기자재번호
  TOOL_NAME VARCHAR(20), --기자재명
  TOOL_ROUND NUMBER, --개수
  TOOL_NOTE VARCHAR(100), --비고(기자재상태)
  MAN_NO NUMBER, --관리자 번호
  PRIMARY KEY (TOOL_NO),
  FOREIGN KEY (MAN_NO) REFERENCES EMPLOYEE(EMPNO));
  
  INSERT INTO TOOL VALUES('2020-11-30', 1, '의자', 8, NULL, 1);
  INSERT INTO TOOL VALUES('2020-11-30', 2, '책상', 8, '다리가 망가짐', 2);
  INSERT INTO TOOL VALUES('2020-11-30', 3, '주전자', 1, NULL, 3);
  INSERT INTO TOOL VALUES('2020-11-30', 4, '전자레인지', 3, NULL, 4);
  
--택배 테이블 생성  
CREATE TABLE PARCEL 
 (PARCEL_NO NUMBER NOT NULL, --택배번호
  CONSIGNOR VARCHAR(10), --발송인
  ADDRESS VARCHAR(30), --주소
  WEIGHT NUMBER, --무게
  PMONEY NUMBER, --요금
  PRIMARY KEY (PARCEL_NO));

    INSERT INTO PARCEL VALUES(1, '김이이', '시흥시', 440, 2900);
    INSERT INTO PARCEL VALUES(2, '홍길동', '서울시', 300, 2000);

--택배회사 테이블 생성  
CREATE TABLE SERVICECOMPANY
 (SERNO NUMBER NOT NULL, --택배번호
  INVOICE NUMBER, --송장번호
  DELMAN VARCHAR (10), --택배기사명
  PRIMARY KEY (SERNO),
  FOREIGN KEY (SERNO) REFERENCES PARCEL(PARCEL_NO));
  
  INSERT INTO SERVICECOMPANY VALUES(1,385066070251,'이총알');
  INSERT INTO SERVICECOMPANY VALUES(2,235324248434,'김신속');
  


--월별 이익 테이블 생성
CREATE TABLE MONTHPROFIT
 (YEAR_MONTH CHAR(10) NOT NULL, --년 월
  PROFIT NUMBER, --수익(월매출액)
  ORDERCOST NUMBER, --발주비용
  PERSON_EX NUMBER, --인건비용
  NET NUMBER, --순이익(=수익-발주비용-인건비용)
  PRIMARY KEY (YEAR_MONTH));
  
  INSERT INTO MONTHPROFIT VALUES('2020-11', 6000000,1000000, 1700000, 3300000);
  
                                            

  
--<이벤트 품목 가격 지정 기능>
--가격 변경 및 이벤트 내역 수정
UPDATE REALPROD SET REAL_PRICE =(SELECT PRICE FROM PRODUCT
                                    WHERE PRONO = (SELECT REALNO 
                                    FROM REALPROD
                                    WHERE EVENTPERIOD = '2020-12-09')), REAL_ENO = NULL, EVENTPERIOD = NULL 
                WHERE REALNO = (SELECT REALNO FROM REALPROD
                                    WHERE EVENTPERIOD = '2020-12-09');

                
                                       
--<택배 관리 기능>
--택배 발송 시 데이터 추가
DELETE FROM ORD WHERE ORD_NO = 3;

--택배 무게 내림차순으로 택배 발송 내역 검색
SELECT * FROM PARCEL, SERVICECOMPANY WHERE SERNO = PARCEL_NO ORDER BY WEIGHT DESC;



 --<매출 관리 기능>
 --매출금액이 가장 많은 상품 검색
SELECT * FROM REALPROD WHERE REALNO = (SELECT SALE_PRONO FROM SALES 
                                        WHERE SALE_PRONO = (SELECT SALE_PRONO 
                                                                FROM SALES 
                                                                GROUP BY SALE_PRONO 
                                                                HAVING SUM(SALE_QUAN) >= ALL(SELECT SUM(SALE_QUAN) 
                                                                                                FROM SALES 
                                                                                                GROUP BY SALE_PRONO))
                                        GROUP BY SALE_PRONO);       
            
--상품 구매 시 매출 내역 생성
    INSERT INTO SALES VALUES(9, '2020-12-09', '16:00', 6, 2, 2000,'카드');
    SELECT * FROM SALES;
    
--실판매상품에서 해당 품목 구매 개수만큼 재고량에서 차감
    UPDATE REALPROD SET STOCK = STOCK - (SELECT SALE_QUAN 
                                            FROM SALES 
                                            WHERE SNO >= ALL(SELECT SNO FROM SALES)) 
                    WHERE REALNO = (SELECT SALE_PRONO 
                                            FROM SALES 
                                            WHERE SNO >= ALL(SELECT SNO FROM SALES));
    SELECT * FROM REALPROD;


                    
                                            
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
INSERT INTO ORD VALUES(3, '2020-12-09', 7, 20, 10000);

