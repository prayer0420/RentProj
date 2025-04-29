
-- DROP TABLE statements if needed (optional)
-- DROP TABLE IF EXISTS FAQ, settlement, member, announce, note, alarmlist, grade, alarmmessage, product, `order`, category, report, review, advertise, mark;

CREATE TABLE `FAQ` (
    `no` INT NOT NULL AUTO_INCREMENT,
    `category` VARCHAR(50) NOT NULL,
    `title` VARCHAR(200) NOT NULL,
    `content` TEXT NOT NULL,
    `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    `updatedAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    `imgUrl` VARCHAR(255) NULL,
    PRIMARY KEY (`no`)
);

CREATE TABLE `settlement` (
    `settlementNo` INT NOT NULL AUTO_INCREMENT,
    `memberNo` INT NOT NULL,
    `orderNo` INT NOT NULL DEFAULT 1,
    `productNo` INT NOT NULL,
    `feeAmount` DECIMAL(10,2) NULL,
    `orderStatus` VARCHAR(20) NOT NULL,
    `settlementRequestAt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
    `settlementCompletedAt` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
    `feeStatus` VARCHAR(20) NOT NULL,
    `revenueType` VARCHAR(30) NOT NULL,
    `payTime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (`settlementNo`)
);

CREATE TABLE `member` (
    `no` INT AUTO_INCREMENT,
    `gradeId` INT  NULL DEFAULT 1,
    `id` VARCHAR(100) NOT NULL,
    `password` VARCHAR(50)  NULL,
    `name` VARCHAR(100)  NULL,
    `nickname` VARCHAR(50)  NOT NULL,
    `phone` VARCHAR(50) NULL,
    `address1` VARCHAR(100)  NULL,
    `address2` VARCHAR(100)  NULL,
    `address3` VARCHAR(100)  NULL,
    `region1` VARCHAR(100)  NULL,
    `region2` VARCHAR(100)  NULL,
    `region3` VARCHAR(100)   NULL,
    `location` VARCHAR(100)   NULL,
    `profileImage` VARCHAR(200)  NULL,
    `orderCount` INT  DEFAULT 0 NULL,
    `adminNo` INT NULL DEFAULT 0,
    `regDate` DATETIME DEFAULT CURRENT_TIMESTAMP() DEFAULT CURRENT_TIMESTAMP(),
    `fcmToken` VARCHAR(255) NULL,
    `
    PRIMARY KEY (`no`)
);

CREATE TABLE `announce` (
    `no` INT NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(100) NOT NULL,
    `content` VARCHAR(1000) NOT NULL,
    `regDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP() DEFAULT CURRENT_TIMESTAMP(),
    `viewCount` INT NOT NULL DEFAULT 0,
    `imgUrl` VARCHAR(255) NULL,
    PRIMARY KEY (`no`)
);

CREATE TABLE `note` (
    `noteNo` INT NOT NULL AUTO_INCREMENT,
    `productNo` INT NOT NULL,
    `memberNo` INT NOT NULL,
    `noteContent` VARCHAR(1000) NULL,
    `receiver` VARCHAR(100) NOT NULL,
    `curdate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP() DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (`noteNo`)
);

CREATE TABLE `grade` (
    `gradeNo` INT NOT NULL AUTO_INCREMENT,
    `gradeName` VARCHAR(20) NOT NULL,
    `gradeRate` DOUBLE NOT NULL,
    `gradeCount` DECIMAL(10,2) NOT NULL DEFAULT 0,
    PRIMARY KEY (`gradeNo`)
);

CREATE TABLE `product` (
    `no` INT NOT NULL AUTO_INCREMENT,
    `categoryNo` INT NOT NULL DEFAULT 1,
    `createDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP() DEFAULT CURRENT_TIMESTAMP(),
    `title` VARCHAR(100) NOT NULL,
    `content` VARCHAR(255) NOT NULL,
    `state` VARCHAR(100) NULL,
    `img` VARCHAR(100) NOT NULL,
    `deliveryAddr` VARCHAR(100) NOT NULL,
    `deliveryprice` INT NULL,
    `tradeType` VARCHAR(255) NULL,
    `secPrice` INT NULL,
    `memberNo` INT NOT NULL,
    `startDate` VARCHAR(255) NULL,
    `endDate` VARCHAR(255) NULL,
    `salePrice` INT NULL DEFAULT 0,
    `rentPrice` INT NULL,
    `isHide` BOOLEAN NULL DEFAULT TRUE COMMENT '상품 숨김여부',
    `deliveryStatus` VARCHAR(100) NOT NULL DEFAULT 0,
    PRIMARY KEY (`no`)
);

CREATE TABLE `order` (
    `orderNo` INT NOT NULL AUTO_INCREMENT,
    `memberNo` INT NOT NULL,
    `orderDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    `orderType` VARCHAR(255) NULL,
    `price` INT NULL,
    `secPrice` INT NULL,
    `deliveryAddr` VARCHAR(100) NULL,
    `deliveryPrice` INT NULL,
    `orderStatus` VARCHAR(50) NULL,
    `endDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP() DEFAULT CURRENT_TIMESTAMP(),
    `productNo` INT NOT NULL,
    `startDate` DATETIME NULL DEFAULT CURRENT_TIMESTAMP() DEFAULT CURRENT_TIMESTAMP(),
    `paymentType` VARCHAR(20) NOT NULL,
    `invoiceNo` VARCHAR(20) NULL COMMENT '송장번호',
    `deliveryComp` VARCHAR(20) NULL COMMENT '택배사',
    PRIMARY KEY (`orderNo`)
);

CREATE TABLE `category` (
    `no` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    `sortOrder` INT NOT NULL COMMENT '낮을수록 먼저',
    `isActive` BOOLEAN NOT NULL DEFAULT TRUE,
    PRIMARY KEY (`no`)
);

CREATE TABLE `report` (
    `no` INT NOT NULL AUTO_INCREMENT,
    `memberNo` INT NOT NULL,
    `contents` VARCHAR(1000) NULL,
    `type` VARCHAR(100) NOT NULL,
    `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP() DEFAULT CURRENT_TIMESTAMP(),
    `title` VARCHAR(100) NOT NULL,
    `productNo` INT NOT NULL,
    PRIMARY KEY (`no`)
);

CREATE TABLE `review` (
    `no` INT NOT NULL AUTO_INCREMENT,
    `memberNo` INT NOT NULL,
    `title` VARCHAR(100) NULL,
    `contents` VARCHAR(1000) NOT NULL,
    `score` INT NULL,
    `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP() DEFAULT CURRENT_TIMESTAMP(),
    `productNo` INT NOT NULL,
    PRIMARY KEY (`no`)
);

CREATE TABLE `advertise` (
    `no` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `price` INT NOT NULL DEFAULT 0,
    `period` INT NOT NULL DEFAULT 1,
    `img` VARCHAR(255) NOT NULL,
    `content` VARCHAR(1000) NOT NULL,
    `no2` INT NOT NULL DEFAULT 1,
    PRIMARY KEY (`no`)
);

CREATE TABLE `mark` (
    `no` INT NOT NULL AUTO_INCREMENT,
    `productNo` INT NOT NULL,
    `memberNo` INT NOT NULL,
    PRIMARY KEY (`no`)
);

CREATE TABLE alarmMessage (
    no INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,        
    content TEXT NOT NULL,               
    type VARCHAR(30) NOT NULL,          
    remark VARCHAR(200)                  
);

CREATE TABLE alarm (
    no INT AUTO_INCREMENT PRIMARY KEY, 
    type VARCHAR(30) NOT NULL,           
    isActive BOOLEAN DEFAULT TRUE,      
    title VARCHAR(200) NOT NULL,         
    content TEXT NOT NULL,               
    rcvId INT NOT NULL,                 
    sentAt DATETIME                    
);rentdb

CREATE TABLE prof (
    no INT AUTO_INCREMENT PRIMARY KEY,          
    profType VARCHAR(20),                      
    orderType VARCHAR(20) NOT NULL,            
    orderDate DATETIME,                        
    orderNo INT NOT NULL,                      
    settlementNo INT NOT NULL,                  
    feeRate DOUBLE                               
);

-- Foreign Keys


ALTER TABLE `member` ADD CONSTRAINT `FK_grade_TO_member_1` FOREIGN KEY (`gradeId`) REFERENCES `grade` (`gradeNo`);

ALTER TABLE `note` ADD CONSTRAINT `FK_product_TO_note_1` FOREIGN KEY (`productNo`) REFERENCES `product`(`no`);
ALTER TABLE `note` ADD CONSTRAINT `FK_member_TO_note_1` FOREIGN KEY (`memberNo`) REFERENCES `member`(`no`);

ALTER TABLE `order` ADD CONSTRAINT `FK_member_TO_order_1` FOREIGN KEY (`memberNo`) REFERENCES `member`(`no`);
ALTER TABLE `order` ADD CONSTRAINT `FK_product_TO_order_1` FOREIGN KEY (`productNo`) REFERENCES `product`(`no`);

ALTER TABLE `product` ADD CONSTRAINT `FK_category_TO_product_1` FOREIGN KEY (`categoryNo`) REFERENCES `category`(`no`);
ALTER TABLE `product` ADD CONSTRAINT `FK_member_TO_product_1` FOREIGN KEY (`memberNo`) REFERENCES `member`(`no`);

ALTER TABLE `report` ADD CONSTRAINT `FK_member_TO_report_1` FOREIGN KEY (`memberNo`) REFERENCES `member`(`no`);
ALTER TABLE `report` ADD CONSTRAINT `FK_product_TO_report_1` FOREIGN KEY (`productNo`) REFERENCES `product`(`no`);

ALTER TABLE `review` ADD CONSTRAINT `FK_member_TO_review_1` FOREIGN KEY (`memberNo`) REFERENCES `member`(`no`);
ALTER TABLE `review` ADD CONSTRAINT `FK_product_TO_review_1` FOREIGN KEY (`productNo`) REFERENCES `product`(`no`);

ALTER TABLE `settlement` ADD CONSTRAINT `FK_member_TO_settlement_1` FOREIGN KEY (`memberNo`) REFERENCES `member`(`no`);
ALTER TABLE `settlement` ADD CONSTRAINT `FK_order_TO_settlement_1` FOREIGN KEY (`orderNo`) REFERENCES `order`(`orderNo`);
ALTER TABLE `settlement` ADD CONSTRAINT `FK_product_TO_settlement_1` FOREIGN KEY (`productNo`) REFERENCES `product`(`no`);

ALTER TABLE `mark` 
ADD CONSTRAINT `FK_mark_product` FOREIGN KEY (`productNo`) REFERENCES `product`(`no`);

ALTER TABLE `mark` 
ADD CONSTRAINT `FK_mark_member` FOREIGN KEY (`memberNo`) REFERENCES `member`(`no`);

ALTER TABLE `product`
ADD COLUMN `view_cnt` INT NOT NULL DEFAULT 0 COMMENT '조회수';

ALTER TABLE report
ADD COLUMN status VARCHAR(20) DEFAULT 'new';

INSERT INTO grade(gradeNo,gradeName,gradeRate,gradeCount)
VALUES(1,"1",1.0,1.0);

INSERT INTO member(NO,gradeId,id,PASSWORD,name,nickname,phone,address1,region1,profileimage,adminNo,fcmToken)
VALUES (1,1,"1","1","1","1",1,"1","1","1",1,"1");

INSERT INTO category (no, name, sortOrder, isActive) VALUES
(1, '의류/패션/악세사리', 1,1),
(2, 'PC/모바일', 2,1),
(3, '가전 제품', 3, 1),
(4, '뷰티/미용', 4, 1),
(5, '캠핑/스포츠/레저', 5, 1),
(6, '생활/주방용품', 6, 1),
(7, '가구인테리어', 7, 1),
(8, '유아동/출산', 8, 1),
(9, '애완동물용품', 9, 1),
(10, '기타', 10, 1);

INSERT INTO member (no, id, password, nickname, phone, address1, region1)
VALUES
(2, 'user2', 'pass2', '유저2', '010-2222-2222', '서울시', '마포구'),
(3, 'user3', 'pass3', '유저3', '010-3333-3333', '부산시', '해운대구'),
(4, 'user4', 'pass4', '유저4', '010-4444-4444', '대전시', '서구'),
(5, 'user5', 'pass5', '유저5', '010-5555-5555', '인천시', '남동구'),
(6, 'user6', 'pass6', '유저6', '010-6666-6666', '대구시', '수성구'),
(7, 'user7', 'pass7', '유저7', '010-7777-7777', '광주시', '북구'),
(8, 'user8', 'pass8', '유저8', '010-8888-8888', '울산시', '남구'),
(9, 'user9', 'pass9', '유저9', '010-9999-9999', '제주시', '제주시'),
(10, 'user10', 'pass10', '유저10', '010-1010-1010', '수원시', '장안구');

INSERT INTO product 
(no, categoryNo, title, content, state, img, deliveryAddr, deliveryPrice, tradeType, secPrice, memberNo, startDate, endDate, salePrice, rentPrice, isHide, view_cnt, deliveryStatus, createDate)
VALUES
(102, 2, '스마트폰', '상태 좋은 스마트폰', 'NEW', 'phone.jpg', '서울 마포구', 4000, '대여', 10000, 2, '2025-04-20', '2025-04-25', NULL, 3000, 0, 80, '가능', NOW() - INTERVAL 2 DAY),
(103, 3, '전자레인지', '전자레인지 팝니다', 'USED', 'micro.jpg', '부산 해운대구', 2000, '판매대여', 5000, 3, '2025-04-21', '2025-04-23', 15000, 2000, 0, 60, '가능', NOW() - INTERVAL 3 DAY),
(104, 4, '화장품세트', '나눔합니다', 'NEW', 'cosmetics.jpg', '대전 서구', 0, '나눔', NULL, 4, NULL, NULL, NULL, NULL, 0, 50, '가능', NOW() - INTERVAL 4 DAY),
(105, 5, '캠핑의자', '편한 캠핑의자', 'USED', 'chair.jpg', '인천 남동구', 2000, '판매', NULL, 5, NULL, NULL, 10000, NULL, 0, 30, '가능', NOW() - INTERVAL 5 DAY),
(106, 6, '프라이팬', '새상품', 'NEW', 'pan.jpg', '대구 수성구', 1500, '판매', NULL, 6, NULL, NULL, 7000, NULL, 0, 20, '가능', NOW() - INTERVAL 6 DAY),
(107, 7, '책상', '심플한 책상', 'USED', 'desk.jpg', '광주 북구', 5000, '판매대여', 5000, 7, '2025-04-22', '2025-04-26', 20000, 3000, 0, 90, '가능', NOW() - INTERVAL 7 DAY),
(108, 8, '아기옷', '귀여운 아기옷', 'USED', 'baby.jpg', '울산 남구', 1000, '판매', NULL, 8, NULL, NULL, 8000, NULL, 0, 15, '가능', NOW() - INTERVAL 8 DAY),
(109, 9, '강아지 장난감', '사용감 거의 없음', 'USED', 'dog.jpg', '제주 제주시', 1000, '대여', 2000, 9, '2025-04-19', '2025-04-22', NULL, 1000, 0, 5, '가능', NOW() - INTERVAL 9 DAY),
(110, 10, '기타 품목', '기타 기타', 'NEW', 'etc.jpg', '경기 수원시', 2500, '판매', NULL, 10, NULL, NULL, 6000, NULL, 0, 200, '가능', NOW() - INTERVAL 10 DAY),
(111, 1, '여름 반팔 티셔츠', '시원하고 가벼움', 'NEW', 'shirt.jpg', '서울시 강남구', 2000, '판매', NULL, 3, NULL, NULL, 15000, NULL, 12, 3, '가능', NOW() - INTERVAL 1 DAY),
(112, 2, '아이폰 12 대여', '생활기스 있음', 'USED', 'iphone.jpg', '부산시  해운대구', 3000, '대여', 50000, 2, '2025-04-22', '2025-04-25', NULL, 8000, 30, 12, '가능', NOW() - INTERVAL 2 DAY),
(113, 3, '에어프라이어', '거의 새상품', 'USED', 'airfryer.jpg', '대구시 달서구', 5000, '판매', NULL, 1, NULL, NULL, 45000, NULL, 7, 1, '가능', NOW() - INTERVAL 3 DAY),
(114, 4, '드라이기 대여', '머리 말릴 때 최고', 'USED', 'dryer.jpg', '서울시 관악구', 1500, '대여', 10000, 5, '2025-04-21', '2025-04-23', NULL, 2000, 9, 5, '가능', NOW() - INTERVAL 4 DAY),
(115, 5, '캠핑 텐트', '3인용, 방수 좋음', 'USED', 'tent.jpg', '경남시 창원시', 3000, '판매대여', 20000, 6, '2025-04-25', '2025-04-28', 70000, 8000, 22, 7, '가능', NOW() - INTERVAL 5 DAY),
(116, 6, '주방용 칼세트', '잘 들어요', 'NEW', 'knife.jpg', '광주시 북구', 2500, '판매', NULL, 4, NULL, NULL, 22000, NULL, 5, 2, '가능', NOW() - INTERVAL 6 DAY),
(117, 7, '책상 세트', '책상 + 의자 포함', 'USED', 'desk.jpg', '서울시 마포구', 10000, '판매', NULL, 7, NULL, NULL, 120000, NULL, 11, 6, '가능', NOW() - INTERVAL 7 DAY),
(118, 8, '아기용 카시트', '깨끗하게 사용함', 'USED', 'carseat.jpg', '전북 전주시', 4000, '대여', 30000, 8, '2025-04-24', '2025-04-27', NULL, 5000, 18, 8, '가능', NOW() - INTERVAL 8 DAY),
(119, 9, '강아지 집', '접이식, 휴대용', 'NEW', 'doghouse.jpg', '인천 미추홀구', 2000, '판매', NULL, 9, NULL, NULL, 35000, NULL, 6, 1, '가능', NOW() - INTERVAL 9 DAY),
(120, 10, '기타 장비 대여', '연습용 장비입니다', 'USED', 'guitar.jpg', '충북 청주시', 3000, '대여', 10000, 10, '2025-04-23', '2025-04-26', NULL, 7000, 14, 3, '가능', NOW() - INTERVAL 10 DAY);


ALTER TABLE member
ADD COLUMN latitude DECIMAL(10, 7),
ADD COLUMN longitude DECIMAL(10, 7);



DROP TABLE IF EXISTS alarm;

CREATE TABLE alarm (
  no INT AUTO_INCREMENT PRIMARY KEY,
  type VARCHAR(50) NOT NULL,
  recvId VARCHAR(50) NOT NULL,
  title VARCHAR(100) NOT NULL,
  content VARCHAR(1000),
  isActive BOOLEAN DEFAULT TRUE,
  sentDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO alarm (type, recvId, title, content, isActive)
VALUES
  ('chat', 'ekzm849', '새로운 메시지 도착', '1:1 채팅 메시지가 도착했습니다.', TRUE),
  ('system', 'ekzm849', '상품 등록 완료', '상품이 성공적으로 등록되었습니다.', TRUE),
  ('warning', 'ekzm849', '신고 처리 알림', '회원님이 신고한 내용이 처리되었습니다.', TRUE);


INSERT INTO alarmmessage (title, content, type, remark)
VALUES ('회원가입 환영!', '${id}님, 가입을 환영합니다! 🎉', 'SIGNUP', '회원가입 시 자동 발송 템플릿');

ALTER TABLE `category`
ADD COLUMN `imgfilename` VARCHAR(100);


DROP TABLE IF EXISTS FAQ;

-- 카테고리 테이블
CREATE TABLE faq_category (
  no INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL UNIQUE
);

-- FAQ 테이블 (categoryNo 참조)
CREATE TABLE faq (
  no INT PRIMARY KEY AUTO_INCREMENT,
  categoryNo INT NOT NULL,
  title VARCHAR(200) NOT NULL,
  content TEXT NOT NULL,
  createdAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  updatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  imgUrl VARCHAR(255),
  FOREIGN KEY (category_no) REFERENCES faq_category(no)
);


ALTER TABLE product
ADD COLUMN sortPrice INT GENERATED ALWAYS AS (COALESCE(salePrice, rentPrice)) STORED;

CREATE INDEX idx_sortPrice ON product(sortPrice);

CREATE INDEX idx_categoryNo ON product(categoryNo);
CREATE INDEX idx_tradeType ON product(tradeType);
CREATE INDEX idx_title ON product(title);
CREATE INDEX idx_createDate ON product(createDate);


ALTER TABLE product ADD COLUMN latitude DOUBLE;
ALTER TABLE product ADD COLUMN longitude DOUBLE;

UPDATE product SET latitude = 37.4979, longitude = 127.0276 WHERE no = 111;
UPDATE product SET latitude = 35.1631, longitude = 129.1636 WHERE no = 112;
UPDATE product SET latitude = 35.8264, longitude = 128.5327 WHERE no = 113;
UPDATE product SET latitude = 37.6027, longitude = 126.9291 WHERE no = 114;
UPDATE product SET latitude = 37.5638, longitude = 126.9084 WHERE no = 115;
UPDATE product SET latitude = 35.2285, longitude = 128.6811 WHERE no = 116;
UPDATE product SET latitude = 35.1631, longitude = 129.1636 WHERE no = 117;
UPDATE product SET latitude = 35.1741, longitude = 126.9119 WHERE no = 118;
UPDATE product SET latitude = 36.3258, longitude = 127.4275 WHERE no = 119;
UPDATE product SET latitude = 37.5638, longitude = 126.9084 WHERE no = 120;
UPDATE product SET latitude = 37.4475, longitude = 126.7313 WHERE no = 105;
UPDATE product SET latitude = 35.8242, longitude = 127.1478 WHERE no = 106;
UPDATE product SET latitude = 35.8589, longitude = 128.6302 WHERE no = 107;
UPDATE product SET latitude = 37.4629, longitude = 126.6822 WHERE no = 108;
UPDATE product SET latitude = 35.1741, longitude = 126.9119 WHERE no = 109;
UPDATE product SET latitude = 36.6424, longitude = 127.489 WHERE no = 102;
UPDATE product SET latitude = 36.6424, longitude = 127.489 WHERE no = 103;
UPDATE product SET latitude = 33.4996, longitude = 126.5312 WHERE no = 104;

-- 회원 등급
DELETE FROM grade;

INSERT INTO grade (gradeNo, gradeName, gradeRate, gradeCount) VALUES
(1, '브론즈', 5, 0.0),
(2, '실버', 4.85, 10.0),
(3, '골드', 4.7, 20.0),
(4, '플래티넘', 4.5, 30.0),
(5, '다이아', 4.25, 40.0),
(6, ' Re:NT', 3.5, 50.0);



INSERT INTO product (categoryNo, title, content, state, img, deliveryAddr, deliveryPrice, tradeType, secPrice, memberNo, startDate, endDate, salePrice, rentPrice, deliveryStatus, createDate)
VALUES
(1, '아이폰 13', '최신형 아이폰', '새상품', '/upload/product1.jpg', '서울 강남구', 3000, '판매', NULL, 1, NULL, NULL, 1200000, NULL, '배송가능', NOW()),
(1, '갤럭시 S22', '삼성 플래그십 모델', '새상품', '/upload/product2.jpg', '서울 서초구', 3000, '판매', NULL, 1, NULL, NULL, 1100000, NULL, '배송가능', NOW()),
(2, '닌텐도 스위치', '스위치 풀세트', '중고', '/upload/product3.jpg', '서울 송파구', 2000, '판매', NULL, 1, NULL, NULL, 400000, NULL, '배송가능', NOW()),
(2, 'PS5', '플스5 새제품', '새상품', '/upload/product4.jpg', '서울 마포구', 5000, '판매', NULL, 1, NULL, NULL, 700000, NULL, '배송가능', NOW()),
(3, '맥북 프로', 'M2 칩 탑재', '새상품', '/upload/product5.jpg', '서울 강서구', 5000, '판매', NULL, 1, NULL, NULL, 2500000, NULL, '배송가능', NOW()),
(3, '아이패드 미니6', '아이패드 미니', '중고', '/upload/product6.jpg', '서울 관악구', 3000, '판매', NULL, 1, NULL, NULL, 600000, NULL, '배송가능', NOW()),
(4, '에어팟 프로2', '새제품', '새상품', '/upload/product7.jpg', '서울 동작구', 2000, '판매', NULL, 1, NULL, NULL, 300000, NULL, '배송가능', NOW()),
(4, 'LG 울트라 노트북', '초경량 노트북', '중고', '/upload/product8.jpg', '서울 구로구', 4000, '판매', NULL, 1, NULL, NULL, 800000, NULL, '배송가능', NOW()),
(5, '삼성 모니터 32인치', '커브드 모니터', '중고', '/upload/product9.jpg', '서울 용산구', 3000, '판매', NULL, 1, NULL, NULL, 250000, NULL, '배송가능', NOW()),
(5, '소니 카메라 A6400', '미러리스 카메라', '중고', '/upload/product10.jpg', '서울 중구', 5000, '판매', NULL, 1, NULL, NULL, 900000, NULL, '배송가능', NOW()),
(6, 'DJI 드론', '드론 촬영 장비', '새상품', '/upload/product11.jpg', '서울 강북구', 5000, '판매', NULL, 1, NULL, NULL, 1500000, NULL, '배송가능', NOW()),
(6, '로지텍 키보드', '게이밍 키보드', '중고', '/upload/product12.jpg', '서울 성동구', 2000, '판매', NULL, 1, NULL, NULL, 100000, NULL, '배송가능', NOW()),
(7, '삼성 갤럭시 탭', '태블릿 중고', '중고', '/upload/product13.jpg', '서울 노원구', 3000, '판매', NULL, 1, NULL, NULL, 350000, NULL, '배송가능', NOW()),
(7, '브리츠 스피커', '컴퓨터 스피커', '중고', '/upload/product14.jpg', '서울 은평구', 2000, '판매', NULL, 1, NULL, NULL, 50000, NULL, '배송가능', NOW()),
(8, '나이키 운동화', '에어맥스 한정판', '새상품', '/upload/product15.jpg', '서울 도봉구', 3000, '판매', NULL, 1, NULL, NULL, 180000, NULL, '배송가능', NOW()),
(8, '아디다스 트랙수트', '상의+하의 세트', '새상품', '/upload/product16.jpg', '서울 금천구', 3000, '판매', NULL, 1, NULL, NULL, 120000, NULL, '배송가능', NOW()),
(9, '피파 24', '플스용 피파24', '새상품', '/upload/product17.jpg', '서울 서대문구', 2000, '판매', NULL, 1, NULL, NULL, 70000, NULL, '배송가능', NOW()),
(9, '오큘러스 VR', 'VR 헤드셋', '중고', '/upload/product18.jpg', '서울 종로구', 5000, '판매', NULL, 1, NULL, NULL, 400000, NULL, '배송가능', NOW()),
(10, '샤오미 무선 청소기', '무선 진공 청소기', '중고', '/upload/product19.jpg', '서울 성북구', 4000, '판매', NULL, 1, NULL, NULL, 150000, NULL, '배송가능', NOW()),
(10, '루미큐브', '보드게임 루미큐브', '새상품', '/upload/product20.jpg', '서울 중랑구', 2000, '판매', NULL, 1, NULL, NULL, 40000, NULL, '배송가능', NOW());


INSERT INTO mark (productNo, memberNo)
VALUES
(102, 57), (103, 57), (104, 57), (105, 57), (106, 57),
(107, 57), (108, 57), (109, 57), (110, 57), (111, 57),
(112, 57), (113, 57), (114, 57), (115, 57), (116, 57),
(117, 57), (118, 57), (119, 57), (120, 57), (121, 57);


INSERT INTO review (memberNo, title, contents, score, date, productNo) VALUES
(57, '스마트폰 리뷰', '화질이 아주 좋아요!', 5, NOW(), 102),
(57, '전자레인지 리뷰', '빠르게 잘 데워져요.', 4, NOW(), 103),
(57, '화장품세트 후기', '구성이 훌륭해요.', 5, NOW(), 104),
(57, '캠핑의자', '튼튼하고 편해요.', 5, NOW(), 105),
(57, '프라이팬', '열전도 빠르고 좋아요.', 5, NOW(), 106),
(57, '책상 후기', '튼튼해서 만족합니다.', 4, NOW(), 107),
(57, '아기옷', '색감 예쁘고 질 좋아요.', 5, NOW(), 108),
(57, '강아지 장난감', '강아지가 너무 좋아해요.', 5, NOW(), 109),
(57, '기타 물품', '퀄리티가 괜찮아요.', 4, NOW(), 110),
(57, '여름 반팔 티셔츠', '가볍고 시원해요.', 5, NOW(), 111),
(57, '아이폰 12 대여', '새 제품 같아요.', 5, NOW(), 112),
(57, '에어프라이어', '음식이 잘 구워져요.', 4, NOW(), 113),
(57, '드라이기 대여', '바람 세기 좋아요.', 5, NOW(), 114),
(57, '캠핑 텐트', '설치 쉬워요.', 5, NOW(), 115),
(57, '주방용 칼세트', '날카롭고 좋아요.', 5, NOW(), 116),
(57, '책상 세트', '의자까지 세트라 좋아요.', 5, NOW(), 117),
(57, '아기용 카시트', '아기가 편하게 앉아요.', 5, NOW(), 118),
(57, '강아지 집', '겨울에도 따뜻해요.', 5, NOW(), 119),
(57, '기타 장비 대여', '장비 상태 좋음.', 5, NOW(), 120),
(57, '아이폰 13', '신제품이라 만족!', 5, NOW(), 121),
(57, '갤럭시 S22', '빠른 속도 최고.', 5, NOW(), 122),
(57, '닌텐도 스위치', '게임하기 좋아요.', 5, NOW(), 123),
(57, 'PS5', '플스는 진리.', 5, NOW(), 124),
(57, '맥북 프로', '성능 최강.', 5, NOW(), 125),
(57, '아이패드 미니6', '가볍고 빠르다.', 5, NOW(), 126),
(57, '에어팟 프로', '노이즈 캔슬 짱.', 5, NOW(), 127),
(57, 'LG 울트라 노트북', '가벼운데 성능 좋음.', 5, NOW(), 128),
(57, '삼성 모니터 32인치', '시야각 좋아요.', 5, NOW(), 129),
(57, '소니 카메라 A6400', '사진이 깔끔.', 5, NOW(), 130),
(20, 'DJI 드론', '비행성능 좋아요.', 5, NOW(), 131);


INSERT INTO `order` 
(orderNo, memberNo, orderDate, orderType, price, secPrice, deliveryAddr, deliveryPrice, orderStatus, endDate, productNo, startDate, paymentType, invoiceNo, deliveryComp)
VALUES
(1, 57, '2025-04-16', '구매', 450000, NULL, '서울시 강남구', 3000, '거래완료', NULL, 102, NULL, '카드결제', '123456789012', 'CJ대한통운'),
(2, 57, '2025-04-16', '구매', 300000, NULL, '서울시 강서구', 3000, '거래완료', NULL, 103, NULL, '카드결제', '234567890123', 'CJ대한통운'),
(3, 57, '2025-04-16', '구매', 120000, NULL, '서울시 서초구', 3000, '거래완료', NULL, 104, NULL, '무통장입금', '345678901234', 'CJ대한통운'),
(4, 57, '2025-04-16', '대여', 50000, 20000, '서울시 송파구', 3000, '대여종료', NOW(), 105, NOW(), '카드결제', '456789012345', 'CJ대한통운'),
(5, 57, '2025-04-16', '구매', 650000, NULL, '서울시 중구', 3000, '거래완료', NULL, 106, NULL, '카드결제', '567890123456', 'CJ대한통운'),
(6, 57, '2025-04-16', '구매', 170000, NULL, '서울시 노원구', 3000, '배송중', NULL, 107, NULL, '무통장입금', '678901234567', 'CJ대한통운'),
(7, 57, '2025-04-09', '구매', 40000, NULL, '서울시 강동구', 3000, '거래완료', NULL, 108, NULL, '카드결제', '789012345678', 'CJ대한통운'),
(8, 57, '2025-04-09', '대여', 30000, 10000, '서울시 은평구', 3000, '대여종료', NOW(), 109, NOW(), '무통장입금', '890123456789', 'CJ대한통운'),
(9, 57, '2025-04-08', '구매', 250000, NULL, '서울시 용산구', 3000, '구매확정', NULL, 110, NULL, '카드결제', '901234567890', 'CJ대한통운'),
(10, 57, '2025-04-20', '구매', 80000, NULL, '서울시 동작구', 3000, '거래완료', NULL, 111, NULL, '무통장입금', '012345678901', 'CJ대한통운'),
-- (11) ~ (30)도 비슷하게 추가
(11, 57, '2025-04-20', '구매', 85000, NULL, '서울시 동대문구', 3000, '구매확정', NULL, 112, NULL, '카드결제', '111111111111', 'CJ대한통운'),
(12, 57, '2025-04-18', '구매', 50000, NULL, '서울시 광진구', 3000, '거래완료', NULL, 113, NULL, '무통장입금', '222222222222', 'CJ대한통운'),
(13, 57, '2025-04-18', '대여', 70000, 30000, '서울시 구로구', 3000, '대여종료', NOW(), 114, NOW(), '카드결제', '333333333333', 'CJ대한통운'),
(14, 57, '2025-04-17', '구매', 155000, NULL, '서울시 금천구', 3000, '거래완료', NULL, 115, NULL, '무통장입금', '444444444444', 'CJ대한통운'),
(15, 57, '2025-04-17', '구매', 190000, NULL, '서울시 서대문구', 3000, '거래완료', NULL, 116, NULL, '카드결제', '555555555555', 'CJ대한통운'),
(16, 57, '2025-04-16', '구매', 32000, NULL, '서울시 성동구', 3000, '구매확정', NULL, 117, NULL, '무통장입금', '666666666666', 'CJ대한통운'),
(17, 57, '2025-04-16', '구매', 41000, NULL, '서울시 강북구', 3000, '거래완료', NULL, 118, NULL, '카드결제', '777777777777', 'CJ대한통운'),
(18, 57, '2025-04-16', '구매', 60000, NULL, '서울시 마포구', 3000, '거래완료', NULL, 119, NULL, '무통장입금', '888888888888', 'CJ대한통운'),
(19, 57, '2025-04-16', '대여', 120000, 50000, '서울시 관악구', 3000, '대여종료', NOW(), 120, NOW(), '카드결제', '999999999999', 'CJ대한통운'),
(20, 57, '2025-04-28', '구매', 210000, NULL, '서울시 도봉구', 3000, '거래완료', NULL, 121, NULL, '무통장입금', '000000000000', 'CJ대한통운'),
(21, 57, '2025-04-28', '구매', 150000, NULL, '서울시 성북구', 3000, '배송중', NULL, 122, NULL, '카드결제', '123123123123', 'CJ대한통운'),
(22, 57, '2025-04-28', '구매', 40000, NULL, '서울시 종로구', 3000, '거래완료', NULL, 123, NULL, '무통장입금', '321321321321', 'CJ대한통운'),
(23, 57, '2025-04-28', '구매', 99000, NULL, '서울시 중랑구', 3000, '거래완료', NULL, 124, NULL, '카드결제', '456456456456', 'CJ대한통운'),
(24, 57, '2025-04-28', '구매', 75000, NULL, '서울시 서대문구', 3000, '구매확정', NULL, 125, NULL, '무통장입금', '654654654654', 'CJ대한통운'),
(25, 57, '2025-04-28', '구매', 88000, NULL, '서울시 강남구', 3000, '거래완료', NULL, 126, NULL, '카드결제', '789789789789', 'CJ대한통운'),
(26, 57, '2025-04-28', '구매', 90000, NULL, '서울시 강서구', 3000, '거래완료', NULL, 127, NULL, '무통장입금', '987987987987', 'CJ대한통운'),
(27, 57, '2025-04-28', '구매', 120000, NULL, '서울시 은평구', 3000, '거래완료', NULL, 128, NULL, '카드결제', '741741741741', 'CJ대한통운'),
(28, 57, '2025-04-28', '구매', 180000, NULL, '서울시 송파구', 3000, '거래완료', NULL, 129, NULL, '무통장입금', '852852852852', 'CJ대한통운'),
(29, 57, '2025-04-28', '구매', 220000, NULL, '서울시 강동구', 3000, '배송중', NULL, 130, NULL, '카드결제', '963963963963', 'CJ대한통운'),
(30, 57, '2025-04-28', '구매', 140000, NULL, '서울시 동작구', 3000, '거래완료', NULL, 131, NULL, '무통장입금', '159159159159', 'CJ대한통운');









INSERT INTO product (categoryNo, createDate, title, content, state, img, memberNo)
VALUES
(1, NOW(), '상품1', '상품1 설명입니다.', 'NEW', 'img1.jpg', 57),
(2, NOW(), '상품2', '상품2 설명입니다.', 'NEW', 'img2.jpg', 57),
(3, NOW(), '상품3', '상품3 설명입니다.', 'NEW', 'img3.jpg', 57),
(4, NOW(), '상품4', '상품4 설명입니다.', 'NEW', 'img4.jpg', 57),
(5, NOW(), '상품5', '상품5 설명입니다.', 'NEW', 'img5.jpg', 57),
(6, NOW(), '상품6', '상품6 설명입니다.', 'NEW', 'img6.jpg', 57),
(7, NOW(), '상품7', '상품7 설명입니다.', 'NEW', 'img7.jpg', 57),
(8, NOW(), '상품8', '상품8 설명입니다.', 'NEW', 'img8.jpg', 57),
(9, NOW(), '상품9', '상품9 설명입니다.', 'NEW', 'img9.jpg', 57),
(10, NOW(), '상품10', '상품10 설명입니다.', 'NEW', 'img10.jpg', 57);




INSERT INTO `order` (memberNo, orderDate, orderType, price, secPrice, deliveryAddr, deliveryPrice, orderStatus, endDate, productNo, startDate, paymentType, invoiceNo, deliveryComp)
VALUES
(1, NOW(), '대여', 10000, 1000, '서울', 3000, '거래완료', DATE_ADD(NOW(), INTERVAL 7 DAY), 1, NOW(), '신용카드', '1111', 'CJ대한통운'),
(2, NOW(), '대여', 20000, 2000, '서울', 3000, '거래완료', DATE_ADD(NOW(), INTERVAL 7 DAY), 2, NOW(), '신용카드', '2222', 'CJ대한통운'),
(3, NOW(), '대여', 30000, 3000, '서울', 3000, '거래완료', DATE_ADD(NOW(), INTERVAL 7 DAY), 3, NOW(), '신용카드', '3333', 'CJ대한통운'),
(4, NOW(), '대여', 40000, 4000, '서울', 3000, '거래완료', DATE_ADD(NOW(), INTERVAL 7 DAY), 4, NOW(), '신용카드', '4444', 'CJ대한통운'),
(5, NOW(), '대여', 50000, 5000, '서울', 3000, '거래완료', DATE_ADD(NOW(), INTERVAL 7 DAY), 5, NOW(), '신용카드', '5555', 'CJ대한통운'),
(6, NOW(), '대여', 60000, 6000, '서울', 3000, '거래완료', DATE_ADD(NOW(), INTERVAL 7 DAY), 6, NOW(), '신용카드', '6666', 'CJ대한통운'),
(7, NOW(), '대여', 70000, 7000, '서울', 3000, '거래완료', DATE_ADD(NOW(), INTERVAL 7 DAY), 7, NOW(), '신용카드', '7777', 'CJ대한통운'),
(8, NOW(), '대여', 80000, 8000, '서울', 3000, '거래완료', DATE_ADD(NOW(), INTERVAL 7 DAY), 8, NOW(), '신용카드', '8888', 'CJ대한통운'),
(9, NOW(), '대여', 90000, 9000, '서울', 3000, '거래완료', DATE_ADD(NOW(), INTERVAL 7 DAY), 9, NOW(), '신용카드', '9999', 'CJ대한통운'),
(10, NOW(), '대여', 100000, 10000, '서울', 3000, '거래완료', DATE_ADD(NOW(), INTERVAL 7 DAY), 10, NOW(), '신용카드', '1010', 'CJ대한통운');


INSERT INTO review (memberNo, title, contents, score, date, productNo)
VALUES
(1, '너무 좋아요!', '상품 상태가 정말 좋네요!', 5, NOW(), 1),
(2, '배송 굿', '빠르게 잘 받았습니다.', 5, NOW(), 2),
(3, '대만족입니다.', '잘 사용했습니다.', 5, NOW(), 3),
(4, '좋아요!', '기대 이상이었어요.', 5, NOW(), 4),
(5, '추천합니다.', '다른 사람에게도 추천할게요.', 5, NOW(), 5),
(6, '감사합니다.', '좋은 상품 잘 썼어요.', 5, NOW(), 6),
(7, '깔끔하고 좋아요.', '깨끗해서 좋았습니다.', 5, NOW(), 7),
(8, '정말 편했어요.', '편리하게 이용했습니다.', 5, NOW(), 8),
(9, '아주 만족!', '가격 대비 훌륭합니다.', 5, NOW(), 9),
(10, '다음에도 이용할게요.', '좋은 경험이었습니다.', 5, NOW(), 10);


INSERT INTO report (memberNo, contents, type, date, title, productNo, status) VALUES
(57, '금지된 품목이 올라왔습니다.', '금지품목', NOW(), '금지 품목 신고', 106, 'new'),
(57, '사기 판매가 의심됩니다.', '사기의심', NOW(), '사기 의심 신고', 102, 'new'),
(57, '사진과 설명이 다릅니다.', '콘텐츠부적절', NOW(), '허위 정보 신고', 103, 'new'),
(57, '중복 게시물입니다.', '콘텐츠부적절', NOW(), '중복 게시 신고', 104, 'new'),
(57, '상품 설명에 비속어가 포함되어 있습니다.', '콘텐츠부적절', NOW(), '부적절한 내용 신고', 105, 'new');
