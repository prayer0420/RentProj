
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

-- FAQ 테이블 (category_no 참조)
CREATE TABLE faq (
  no INT PRIMARY KEY AUTO_INCREMENT,
  category_no INT NOT NULL,
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

