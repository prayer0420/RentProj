CREATE TABLE `FAQ` (
	`no`	INT	NOT NULL auto_increment,
	`category`	VARCHAR(50)	NOT NULL,
	`title`	VARCHAR(200)	NOT NULL,
	`content`	TEXT	NOT NULL,
	`created_at`	DATETIME	NOT NULL,
	`updated_at`	DATETIME	NOT NULL,
	`img_url`	VARCHAR(255)	NULL
);

CREATE TABLE `settlement` (
	`settlement_no`	INT	NOT NULL auto_increment,
	`member_no`	varchar(50)	NOT NULL,
	`order_no`	int	NOT NULL	DEFAULT 1,
	`product_no`	int	NOT NULL	DEFAULT 1,
	`fee_amount`	DECIMAL(10,2)	NULL,
	`order_status`	VARCHAR(20)	NOT NULL,
	`settlement_request_at`	DATETIME	NULL,
	`settlement_completed_at`	DATETIME	NULL,
	`fee_status`	VARCHAR(20)	NOT NULL,
	`revenue_type`	VARCHAR(30)	NOT NULL,
	`pay_time`	DATETIME	NOT NULL
);

CREATE TABLE `member` (
	`no`	int NOT NULL auto_increment,
	`grade_id`	varchar(50)	NOT NULL,
	`name`	varchar(100)	NOT NULL,
	`id`	varchar(100)	NOT NULL,
	`password`	varchar(50)	NOT NULL,
	`nickname`	varchar(30)	NOT NULL,
	`phone`	int	NOT NULL,
	`bankname`	varchar(20)	NOT NULL,
	`accountnum`	int	NOT NULL,
	`address1`	varchar(100)	NOT NULL,
	`address2`	varchar(100)	NULL,
	`address3`	varchar(100)	NULL,
	`location1`	varchar(100)	NOT NULL,
	`location2`	varchar(100)	NULL,
	`location3`	varchar(100)	NULL,
	`profileimage`	varchar(100)	NOT NULL,
	`orderCount`	int	NULL,
	`admin_no`	int	NOT NULL	DEFAULT 0,
	`reg_date`	Date	NOT NULL
);




CREATE TABLE `announce` (
	`no`	int	NOT NULL auto_increment,
	`title`	varchar(100)	NOT NULL,
	`content`	varchar(1000)	NOT NULL,
	`reg_date`	Date	NOT NULL,
	`view_count`	int	NOT NULL	DEFAULT 0,
	`img_url`	varchar(255)	NULL
);

CREATE TABLE `note` (
	`note_no`	int	NOT NULL auto_increment,
	`product_no`	int	NOT NULL	DEFAULT 1,
	`member_id`	varchar(50)	NOT NULL,
	`note_content`	varchar(1000)	NULL,
	`receiver`	varchar(100)	NOT NULL,
	`curdate`	date	NULL
);

CREATE TABLE `grade` (
	`grade_no`	int	NOT NULL auto_increment,
	`grade_name`	varchar(20)	NOT NULL,
	`grade_rate`	double	NOT NULL,
	`grade_count`	dec	NOT NULL	DEFAULT 0
);

CREATE TABLE `product` (
	`no`	int	NOT NULL auto_increment,
	`category_no`	int	NOT NULL	DEFAULT 1,
	`create_date`	Date	NOT NULL,
	`title`	varchar(100)	NOT NULL,
	`content`	varchar(255)	NOT NULL,
	`state`	varchar(100)	NULL,
	`img`	varchar(100)	NOT NULL,
	`delivery_addr`	varchar(100)	NOT NULL,
	`delivery_price`	int	NULL,
	`trade_type`	VARCHAR(255)	NULL,
	`sec_price`	int	NULL,
	`member_no`	varchar(50)	NOT NULL,
	`start_date`	VARCHAR(255)	NULL,
	`end_date`	VARCHAR(255)	NULL,
	`sale_price`	int	NULL	DEFAULT 0,
	`rent_price`	int	NULL,
	`isHide`	bool	NULL	DEFAULT true	COMMENT '상품 숨김여부'
);

CREATE TABLE `order` (
	`order_no`	int	NOT NULL auto_increment,
	`member_no`	varchar(50)	NOT NULL,
	`order_date`	datetime	NOT NULL,
	`order_type`	VARCHAR(255)	NULL,
	`price`	int	NULL,
	`sec_price`	int	NULL,
	`delivery_addr`	varchar(100)	NULL,
	`delivery_price`	int	NULL,
	`order_status`	varchar(50)	NULL,
	`end_date`	date	NULL,
	`product_no`	int	NOT NULL	DEFAULT 1,
	`start_date`	date	NULL,
	`payment_type`	varchar(20)	NOT NULL,
	`invoice_no`	varchar(20)	NULL	COMMENT '송장번호',
	`delivery_comp`	varchar(20)	NULL	COMMENT '택배사'
);

CREATE TABLE `category` (
	`no`	int	NOT NULL	 auto_increment,
	`name`	varchar(50)	NOT NULL,
	`sort_order`	INT	NOT NULL	COMMENT '낮을수록 먼저',
	`is_active`	BOOLEAN	NOT NULL	DEFAULT TRUE
);

CREATE TABLE `report` (
	`no`	int	NOT NULL	 auto_increment,
	`member_id`	varchar(50)	NOT NULL,
	`contents`	varchar(1000)	NULL,
	`type`	varchar(100)	NOT NULL,
	`date`	date	NOT NULL,
	`title`	varchar(100)	NOT NULL,
	`product_no`	int	NOT NULL	DEFAULT 1,
	`Field`	VARCHAR(255)	NULL
);

CREATE TABLE `review` (
	`no`	int	NOT NULL auto_increment,
	`member_no`	varchar(50)	NOT NULL,
	`title`	varchar(100)	NULL,
	`contents`	varchar(1000)	NOT NULL,
	`score`	int	NULL,
	`date`	date	NOT NULL,
	`product_no`	int	NOT NULL	DEFAULT 1
);

CREATE TABLE `advertise` (
	`no`	int	NOT NULL	 auto_increment,
	`name`	varchar(100)	NOT NULL,
	`price`	int	NOT NULL	DEFAULT 0,
	`period`	int	NOT NULL	DEFAULT 1,
	`img`	varchar(255)	NOT NULL,
	`content`	varchar(1000)	NOT NULL,
	`no2`	int	NOT NULL	DEFAULT 1
);

CREATE TABLE `mark` (
	`no`	int	NOT NULL	 auto_increment,
	`product_no`	int	NOT NULL	DEFAULT 1,
	`member_id`	varchar(50)	NOT NULL
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
    is_active BOOLEAN DEFAULT TRUE,      
    title VARCHAR(200) NOT NULL,         
    content TEXT NOT NULL,               
    rcv_id INT NOT NULL,                 
    sent_at DATETIME                    
);

CREATE TABLE prof (
    no INT AUTO_INCREMENT PRIMARY KEY,          
    prof_type VARCHAR(20),                      
    order_type VARCHAR(20) NOT NULL,            
    order_date DATETIME,                        
    order_no INT NOT NULL,                      
    settlement_no INT NOT NULL,                  
    fee_rate DOUBLE                               
);

ALTER TABLE `FAQ` ADD CONSTRAINT `PK_FAQ` PRIMARY KEY (
	`no`
);

ALTER TABLE `settlement` ADD CONSTRAINT `PK_settlement` PRIMARY KEY (
	`settlement_no`,
	`member_no`
);

ALTER TABLE `member` ADD CONSTRAINT `PK_member` PRIMARY KEY (
	`no`,
	`grade_no`
);

ALTER TABLE `announce` ADD CONSTRAINT `PK_announce` PRIMARY KEY (
	`no`
);

ALTER TABLE `note` ADD CONSTRAINT `PK_note` PRIMARY KEY (
	`note_no`
);

ALTER TABLE `grade` ADD CONSTRAINT `PK_grade` PRIMARY KEY (
	`grade_no`
);

ALTER TABLE `alarmmessage` ADD CONSTRAINT `PK_alarmmessage` PRIMARY KEY (
	`no`
);

ALTER TABLE `product` ADD CONSTRAINT `PK_product` PRIMARY KEY (
	`no`,
	`category_no`
);

ALTER TABLE `order` ADD CONSTRAINT `PK_order` PRIMARY KEY (
	`order_no`
);

ALTER TABLE `category` ADD CONSTRAINT `PK_category` PRIMARY KEY (
	`no`
);

ALTER TABLE `report` ADD CONSTRAINT `PK_report` PRIMARY KEY (
	`no`
);

ALTER TABLE `review` ADD CONSTRAINT `PK_review` PRIMARY KEY (
	`no`
);

ALTER TABLE `advertise` ADD CONSTRAINT `PK_advertise` PRIMARY KEY (
	`no`
);

ALTER TABLE `mark` ADD CONSTRAINT `PK_mark` PRIMARY KEY (
	`no`
);

ALTER TABLE `settlement` ADD CONSTRAINT `FK_member_TO_settlement_1` FOREIGN KEY (
	`member_no`
)
REFERENCES `member` (
	`no`
);

ALTER TABLE `member` ADD CONSTRAINT `FK_grade_TO_member_1` FOREIGN KEY (
	`grade_id`
)
REFERENCES `grade` (
	`grade_no`
);

ALTER TABLE `product` ADD CONSTRAINT `FK_category_TO_product_1` FOREIGN KEY (
	`category_no`
)
REFERENCES `category` (
	`no`
);

ALTER TABLE member ADD fcm_token VARCHAR(255) NOT NULL;


