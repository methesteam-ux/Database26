-- ============================================
-- 테이블 삭제 (순서 중요)
-- ============================================
DROP TABLE 예약;
DROP TABLE 상영관;
DROP TABLE 고객;
DROP TABLE 극장;

-- ============================================
-- 테이블 생성
-- ============================================
-- 극장 테이블
CREATE TABLE 극장 (
극장번호 NUMBER PRIMARY KEY,
극장이름 VARCHAR2(100) NOT NULL,
위치 VARCHAR2(100)
);

-- 상영관 테이블 (복합 PK)
CREATE TABLE 상영관 (
극장번호 NUMBER,
상영관번호 NUMBER,
영화제목 VARCHAR2(200) NOT NULL,
가격 NUMBER,
좌석수 NUMBER,
CONSTRAINT pk_상영관 PRIMARY KEY (극장번호, 상영관번호),
CONSTRAINT fk_상영관_극장 FOREIGN KEY (극장번호) REFERENCES 극장(극장번호)
);

-- 고객 테이블
CREATE TABLE 고객 (
고객번호 NUMBER PRIMARY KEY,
이름 VARCHAR2(100) NOT NULL,
주소 VARCHAR2(200)
);

-- 예약 테이블 (복합 PK)
CREATE TABLE 예약 (
극장번호 NUMBER,
상영관번호 NUMBER,
고객번호 NUMBER,
좌석번호 NUMBER,
날짜 DATE,
CONSTRAINT pk_예약 PRIMARY KEY (극장번호, 상영관번호, 고객번호),
CONSTRAINT fk_예약_상영관 FOREIGN KEY (극장번호, 상영관번호)
REFERENCES 상영관(극장번호, 상영관번호),
CONSTRAINT fk_예약_고객 FOREIGN KEY (고객번호) REFERENCES 고객(고객번호)
);

-- ============================================
-- 예시 데이터 삽입
-- ============================================
-- 극장 데이터 (5개 극장)
INSERT INTO 극장 VALUES (1, '강남극장', '강남');
INSERT INTO 극장 VALUES (2, '강동극장', '강동');
INSERT INTO 극장 VALUES (3, '홍대극장', '마포');
INSERT INTO 극장 VALUES (4, '신촌극장', '서대문');
INSERT INTO 극장 VALUES (5, '잠실극장', '송파');

-- 상영관 데이터 (극장별 2~3개 상영관)
INSERT INTO 상영관 VALUES (1, 1, '아바타', 12000, 150);
INSERT INTO 상영관 VALUES (1, 2, '범죄도시4', 11000, 120);
INSERT INTO 상영관 VALUES (1, 3, '파묘', 9000, 80);
INSERT INTO 상영관 VALUES (2, 1, '듄2', 13000, 200);
INSERT INTO 상영관 VALUES (2, 2, '건국전쟁', 8000, 60);
INSERT INTO 상영관 VALUES (3, 1, '오펜하이머', 12000, 180);
INSERT INTO 상영관 VALUES (3, 2, '서울의봄', 10000, 100);
INSERT INTO 상영관 VALUES (3, 3, '밀수', 9000, 90);
INSERT INTO 상영관 VALUES (4, 1, '콘크리트유토피아', 11000, 130);
INSERT INTO 상영관 VALUES (4, 2, '외계+인', 7000, 70);
INSERT INTO 상영관 VALUES (5, 1, '탑건매버릭', 13000, 250);
INSERT INTO 상영관 VALUES (5, 2, '앤트맨', 10000, 110);

-- 고객 데이터 (8명)
INSERT INTO 고객 VALUES (1, '김철수', '서울시 강남구 역삼동');
INSERT INTO 고객 VALUES (2, '이영희', '서울시 강동구 천호동');
INSERT INTO 고객 VALUES (3, '박민준', '서울시 마포구 홍대동');
INSERT INTO 고객 VALUES (4, '최수연', '서울시 서대문구 신촌동');
INSERT INTO 고객 VALUES (5, '정하늘', '서울시 송파구 잠실동');
INSERT INTO 고객 VALUES (6, '한지민', '서울시 강북구 수유동');
INSERT INTO 고객 VALUES (7, '강감찬', '서울시 용산구 이태원동');
INSERT INTO 고객 VALUES (8, '장내윤', '서울시 성동구 왕십리동');

-- 예약 데이터 (다양한 날짜와 좌석)
INSERT INTO 예약 VALUES (1, 1, 1, 15, TO_DATE('2024-10-01', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (1, 1, 2, 23, TO_DATE('2024-10-01', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (1, 2, 3, 7, TO_DATE('2024-10-05', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (1, 3, 4, 11, TO_DATE('2024-10-05', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (2, 1, 1, 50, TO_DATE('2024-10-10', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (2, 1, 5, 88, TO_DATE('2024-10-10', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (2, 2, 6, 3, TO_DATE('2024-10-12', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (3, 1, 2, 77, TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (3, 2, 7, 45, TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (3, 3, 8, 62, TO_DATE('2024-10-18', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (4, 1, 3, 19, TO_DATE('2024-10-20', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (4, 2, 4, 33, TO_DATE('2024-10-20', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (5, 1, 5, 100, TO_DATE('2024-10-22', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (5, 1, 6, 120, TO_DATE('2024-10-22', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (5, 2, 7, 55, TO_DATE('2024-10-25', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (5, 2, 8, 67, TO_DATE('2024-10-25', 'YYYY-MM-DD'));

COMMIT;

-- 전체 데이터 확인
SELECT * FROM 극장;
SELECT * FROM 상영관;
SELECT * FROM 고객;
SELECT * FROM 예약;

-- 4개 테이블 전체 조인 확인
SELECT t.극장이름,
s.상영관번호,
s.영화제목,
s.가격,
c.이름 AS 고객이름,
r.좌석번호,
r.날짜
FROM 극장 t
JOIN 상영관 s ON t.극장번호 = s.극장번호
JOIN 예약 r ON s.극장번호 = r.극장번호
AND s.상영관번호 = r.상영관번호
JOIN 고객 c ON r.고객번호 = c.고객번호
ORDER BY r.날짜, t.극장번호;

SELECT 극장이름, 위치 FROM 극장;
SELECT 극장이름 FROM 극장 WHERE 위치 = '서울';
SELECT 극장번호, 상영관번호, 영화제목 FROM 상영관 WHERE 가격 >= 10000;
SELECT 영화제목, COUNT(*) AS 상영관수 FROM 상영관 GROUP BY 영화제목;
SELECT * FROM 예약 WHERE 날짜 = TO_DATE('2024-01-01', 'YYYY-MM-DD');

SELECT 주소, COUNT(*) AS 고객수 FROM 고객 GROUP BY 주소;
SELECT 극장번호, 상영관번호 FROM 상영관 WHERE 좌석수 = (SELECT MAX(좌석수) FROM 상영관);
SELECT 고객번호, COUNT(*) AS 예약횟수 FROM 예약 GROUP BY 고객번호;
SELECT 극장번호, AVG(가격) AS 평균가격 FROM 상영관 GROUP BY 극장번호;
SELECT 이름, 주소 FROM 고객 WHERE 이름 LIKE '김%';

SELECT 극장.극장이름, 상영관.영화제목 FROM 극장 JOIN 상영관 ON 극장.극장번호 = 상영관.극장번호;
SELECT 극장.극장이름, 상영관.영화제목, 예약.날짜 FROM 극장 JOIN 상영관 ON 극장.극장번호 = 상영관.극장번호 JOIN 예약 ON 상영관.극장번호 = 예약.극장번호 AND 상영관.상영관번호 = 예약.상영관번호;
SELECT 고객.이름, 예약.날짜 FROM 고객 JOIN 예약 ON 고객.고객번호 = 예약.고객번호;
SELECT 극장.극장이름, 상영관.영화제목, 고객.이름, 예약.좌석번호 FROM 극장 JOIN 상영관 ON 극장.극장번호 = 상영관.극장번호 JOIN 예약 ON 상영관.극장번호 = 예약.극장번호 AND 상영관.상영관번호 = 예약.상영관번호 JOIN 고객 ON 예약.고객번호 = 고객.고객번호;
SELECT 상영관.영화제목, COUNT(*) AS 총예약수 FROM 상영관 JOIN 예약 ON 상영관.극장번호 = 예약.극장번호 AND 상영관.상영관번호 = 예약.상영관번호 GROUP BY 상영관.영화제목;

SELECT 상영관.영화제목, 상영관.가격 FROM 극장 JOIN 상영관 ON 극장.극장번호 = 상영관.극장번호 WHERE 극장.위치 = '서울';
SELECT 고객.이름 FROM 고객 LEFT JOIN 예약 ON 고객.고객번호 = 예약.고객번호 WHERE 예약.극장번호 IS NULL;
SELECT 극장.극장이름, COUNT(*) AS 총예약수 FROM 극장 JOIN 상영관 ON 극장.극장번호 = 상영관.극장번호 JOIN 예약 ON 상영관.극장번호 = 예약.극장번호 AND 상영관.상영관번호 = 예약.상영관번호 GROUP BY 극장.극장이름;
SELECT 예약.고객번호, 상영관.영화제목 FROM 상영관 JOIN 예약 ON 상영관.극장번호 = 예약.극장번호 AND 상영관.상영관번호 = 예약.상영관번호 WHERE 상영관.가격 >= 15000;
SELECT 고객.이름, COUNT(*) AS 총예약횟수 FROM 고객 JOIN 예약 ON 고객.고객번호 = 예약.고객번호 GROUP BY 고객.이름;
