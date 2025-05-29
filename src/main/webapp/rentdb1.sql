INSERT INTO grade (gradeNo, gradeName, gradeRate, gradeCount)
VALUES
  (1, '브론즈',    5.00,  0.00),
  (2, '실버',      4.85, 10.00),
  (3, '골드',      4.70, 20.00),
  (4, '플래티넘',  4.50, 30.00),
  (5, '다이아',    4.25, 40.00),
  (6, 'Re:NT',     3.50, 50.00);


INSERT INTO member
(no, gradeId, id, password, name, nickname, phone, address1, address2, address3, region1, region2, region3, location, profileImage, orderCount, adminNo, regDate, fcmToken, latitude, longitude)
VALUES
(1, 1, 'user1', '123', '사용자1', 'usernick1', '010-0001-0001', '배송지1@@00001@@충북 청주시 서원구 1순환로 627@@상세주소1', NULL, NULL, '서울특별시 중랑구', NULL, NULL, '서울시 중랑구', '/CSS/img/profileImage2.png', 1, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.501, 127.001),
(2, 1, 'user2', '123', '사용자2', 'usernick2', '010-0002-0002', '배송지2@@00002@@충북 청주시 서원구 1순환로 627@@상세주소2', NULL, NULL, '서울특별시 용산구', NULL, NULL, '서울시 용산구', '/CSS/img/profileImage2.png', 2, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.502, 127.002),
(3, 1, 'user3', '123', '사용자3', 'usernick3', '010-0003-0003', '배송지3@@00003@@충북 청주시 서원구 1순환로 627@@상세주소3', NULL, NULL, '서울특별시 구로구', NULL, NULL, '서울시 구로구', '/CSS/img/profileImage2.png', 3, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.503, 127.003),
(4, 1, 'user4', '123', '사용자4', 'usernick4', '010-0004-0004', '배송지4@@00004@@충북 청주시 서원구 1순환로 627@@상세주소4', NULL, NULL, '서울특별시 종로구', NULL, NULL, '서울시 종로구', '/CSS/img/profileImage2.png', 4, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.504, 127.004),
(5, 1, 'user5', '123', '사용자5', 'usernick5', '010-0005-0005', '배송지5@@00005@@충북 청주시 서원구 1순환로 627@@상세주소5', NULL, NULL, '서울특별시 용산구', NULL, NULL, '서울시 용산구', '/CSS/img/profileImage2.png', 5, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.505, 127.005),
(6, 1, 'user6', '123', '사용자6', 'usernick6', '010-0006-0006', '배송지6@@00006@@충북 청주시 서원구 1순환로 627@@상세주소6', NULL, NULL, '서울특별시 서초구', NULL, NULL, '서울시 서초구', '/CSS/img/profileImage2.png', 6, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.506, 127.006),
(7, 1, 'user7', '123', '사용자7', 'usernick7', '010-0007-0007', '배송지7@@00007@@충북 청주시 서원구 1순환로 627@@상세주소7', NULL, NULL, '서울특별시 강남구', NULL, NULL, '서울시 강남구', '/CSS/img/profileImage2.png', 7, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.507, 127.007),
(8, 1, 'user8', '123', '사용자8', 'usernick8', '010-0008-0008', '배송지8@@00008@@충북 청주시 서원구 1순환로 627@@상세주소8', NULL, NULL, '서울특별시 성동구', NULL, NULL, '서울시 성동구', '/CSS/img/profileImage2.png', 8, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.508, 127.008),
(9, 1, 'user9', '123', '사용자9', 'usernick9', '010-0009-0009', '배송지9@@00009@@충북 청주시 서원구 1순환로 627@@상세주소9', NULL, NULL, '서울특별시 강서구', NULL, NULL, '서울시 강서구', '/CSS/img/profileImage2.png', 9, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.509, 127.009),
(10, 1, 'user10', '123', '사용자10', 'usernick10', '010-0010-0010', '배송지10@@00010@@충북 청주시 서원구 1순환로 627@@상세주소10', NULL, NULL, '서울특별시 구로구', NULL, NULL, '서울시 구로구', '/CSS/img/profileImage2.png', 10, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.51, 127.01),
(11, 2, 'user11', '123', '사용자11', 'usernick11', '010-0011-0011', '배송지11@@00011@@충북 청주시 서원구 1순환로 627@@상세주소11', NULL, NULL, '서울특별시 강남구', NULL, NULL, '서울시 강남구', '/CSS/img/profileImage2.png', 11, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.511, 127.011),
(12, 2, 'user12', '123', '사용자12', 'usernick12', '010-0012-0012', '배송지12@@00012@@충북 청주시 서원구 1순환로 627@@상세주소12', NULL, NULL, '서울특별시 구로구', NULL, NULL, '서울시 구로구', '/CSS/img/profileImage2.png', 12, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.512, 127.012),
(13, 2, 'user13', '123', '사용자13', 'usernick13', '010-0013-0013', '배송지13@@00013@@충북 청주시 서원구 1순환로 627@@상세주소13', NULL, NULL, '서울특별시 용산구', NULL, NULL, '서울시 용산구', '/CSS/img/profileImage2.png', 13, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.513, 127.013),
(14, 2, 'user14', '123', '사용자14', 'usernick14', '010-0014-0014', '배송지14@@00014@@충북 청주시 서원구 1순환로 627@@상세주소14', NULL, NULL, '서울특별시 도봉구', NULL, NULL, '서울시 도봉구', '/CSS/img/profileImage2.png', 14, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.514, 127.014),
(15, 2, 'user15', '123', '사용자15', 'usernick15', '010-0015-0015', '배송지15@@00015@@충북 청주시 서원구 1순환로 627@@상세주소15', NULL, NULL, '서울특별시 강남구', NULL, NULL, '서울시 강남구', '/CSS/img/profileImage2.png', 15, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.515, 127.015),
(16, 2, 'user16', '123', '사용자16', 'usernick16', '010-0016-0016', '배송지16@@00016@@충북 청주시 서원구 1순환로 627@@상세주소16', NULL, NULL, '서울특별시 용산구', NULL, NULL, '서울시 용산구', '/CSS/img/profileImage2.png', 16, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.516, 127.016),
(17, 2, 'user17', '123', '사용자17', 'usernick17', '010-0017-0017', '배송지17@@00017@@충북 청주시 서원구 1순환로 627@@상세주소17', NULL, NULL, '서울특별시 서대문구', NULL, NULL, '서울시 서대문구', '/CSS/img/profileImage2.png', 17, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.517, 127.017),
(18, 2, 'user18', '123', '사용자18', 'usernick18', '010-0018-0018', '배송지18@@00018@@충북 청주시 서원구 1순환로 627@@상세주소18', NULL, NULL, '서울특별시 광진구', NULL, NULL, '서울시 광진구', '/CSS/img/profileImage2.png', 18, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.518, 127.018),
(19, 2, 'user19', '123', '사용자19', 'usernick19', '010-0019-0019', '배송지19@@00019@@충북 청주시 서원구 1순환로 627@@상세주소19', NULL, NULL, '서울특별시 송파구', NULL, NULL, '서울시 송파구', '/CSS/img/profileImage2.png', 19, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.519, 127.019),
(20, 2, 'user20', '123', '사용자20', 'usernick20', '010-0020-0020', '배송지20@@00020@@충북 청주시 서원구 1순환로 627@@상세주소20', NULL, NULL, '서울특별시 강동구', NULL, NULL, '서울시 강동구', '/CSS/img/profileImage2.png', 20, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.52, 127.02),
(21, 3, 'user21', '123', '사용자21', 'usernick21', '010-0021-0021', '배송지21@@00021@@충북 청주시 서원구 1순환로 627@@상세주소21', NULL, NULL, '서울특별시 영등포구', NULL, NULL, '서울시 영등포구', '/CSS/img/profileImage2.png', 21, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.521, 127.021),
(22, 3, 'user22', '123', '사용자22', 'usernick22', '010-0022-0022', '배송지22@@00022@@충북 청주시 서원구 1순환로 627@@상세주소22', NULL, NULL, '서울특별시 용산구', NULL, NULL, '서울시 용산구', '/CSS/img/profileImage2.png', 22, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.522, 127.022),
(23, 3, 'user23', '123', '사용자23', 'usernick23', '010-0023-0023', '배송지23@@00023@@충북 청주시 서원구 1순환로 627@@상세주소23', NULL, NULL, '서울특별시 성동구', NULL, NULL, '서울시 성동구', '/CSS/img/profileImage2.png', 23, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.523, 127.023),
(24, 3, 'user24', '123', '사용자24', 'usernick24', '010-0024-0024', '배송지24@@00024@@충북 청주시 서원구 1순환로 627@@상세주소24', NULL, NULL, '서울특별시 구로구', NULL, NULL, '서울시 구로구', '/CSS/img/profileImage2.png', 24, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.524, 127.024),
(25, 3, 'user25', '123', '사용자25', 'usernick25', '010-0025-0025', '배송지25@@00025@@충북 청주시 서원구 1순환로 627@@상세주소25', NULL, NULL, '서울특별시 송파구', NULL, NULL, '서울시 송파구', '/CSS/img/profileImage2.png', 25, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.525, 127.025),
(26, 3, 'user26', '123', '사용자26', 'usernick26', '010-0026-0026', '배송지26@@00026@@충북 청주시 서원구 1순환로 627@@상세주소26', NULL, NULL, '서울특별시 동대문구', NULL, NULL, '서울시 동대문구', '/CSS/img/profileImage2.png', 26, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.526, 127.026),
(27, 3, 'user27', '123', '사용자27', 'usernick27', '010-0027-0027', '배송지27@@00027@@충북 청주시 서원구 1순환로 627@@상세주소27', NULL, NULL, '서울특별시 도봉구', NULL, NULL, '서울시 도봉구', '/CSS/img/profileImage2.png', 27, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.527, 127.027),
(28, 3, 'user28', '123', '사용자28', 'usernick28', '010-0028-0028', '배송지28@@00028@@충북 청주시 서원구 1순환로 627@@상세주소28', NULL, NULL, '서울특별시 성북구', NULL, NULL, '서울시 성북구', '/CSS/img/profileImage2.png', 28, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.528, 127.028),
(29, 3, 'user29', '123', '사용자29', 'usernick29', '010-0029-0029', '배송지29@@00029@@충북 청주시 서원구 1순환로 627@@상세주소29', NULL, NULL, '서울특별시 서초구', NULL, NULL, '서울시 서초구', '/CSS/img/profileImage2.png', 29, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.529, 127.029),
(30, 3, 'user30', '123', '사용자30', 'usernick30', '010-0030-0030', '배송지30@@00030@@충북 청주시 서원구 1순환로 627@@상세주소30', NULL, NULL, '서울특별시 영등포구', NULL, NULL, '서울시 영등포구', '/CSS/img/profileImage2.png', 30, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.53, 127.03),
(31, 4, 'user31', '123', '사용자31', 'usernick31', '010-0031-0031', '배송지31@@00031@@충북 청주시 서원구 1순환로 627@@상세주소31', NULL, NULL, '서울특별시 성북구', NULL, NULL, '서울시 성북구', '/CSS/img/profileImage2.png', 31, 1, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.531, 127.031),
(32, 4, 'user32', '123', '사용자32', 'usernick32', '010-0032-0032', '배송지32@@00032@@충북 청주시 서원구 1순환로 627@@상세주소32', NULL, NULL, '서울특별시 강남구', NULL, NULL, '서울시 강남구', '/CSS/img/profileImage2.png', 32, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.532, 127.032),
(33, 4, 'user33', '123', '사용자33', 'usernick33', '010-0033-0033', '배송지33@@00033@@충북 청주시 서원구 1순환로 627@@상세주소33', NULL, NULL, '서울특별시 성동구', NULL, NULL, '서울시 성동구', '/CSS/img/profileImage2.png', 33, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.533, 127.033),
(34, 4, 'user34', '123', '사용자34', 'usernick34', '010-0034-0034', '배송지34@@00034@@충북 청주시 서원구 1순환로 627@@상세주소34', NULL, NULL, '서울특별시 강북구', NULL, NULL, '서울시 강북구', '/CSS/img/profileImage2.png', 34, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.534, 127.034),
(35, 4, 'user35', '123', '사용자35', 'usernick35', '010-0035-0035', '배송지35@@00035@@충북 청주시 서원구 1순환로 627@@상세주소35', NULL, NULL, '서울특별시 양천구', NULL, NULL, '서울시 양천구', '/CSS/img/profileImage2.png', 35, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.535, 127.035),
(36, 4, 'user36', '123', '사용자36', 'usernick36', '010-0036-0036', '배송지36@@00036@@충북 청주시 서원구 1순환로 627@@상세주소36', NULL, NULL, '서울특별시 금천구', NULL, NULL, '서울시 금천구', '/CSS/img/profileImage2.png', 36, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.536, 127.036),
(37, 4, 'user37', '123', '사용자37', 'usernick37', '010-0037-0037', '배송지37@@00037@@충북 청주시 서원구 1순환로 627@@상세주소37', NULL, NULL, '서울특별시 동작구', NULL, NULL, '서울시 동작구', '/CSS/img/profileImage2.png', 37, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.537, 127.037),
(38, 4, 'user38', '123', '사용자38', 'usernick38', '010-0038-0038', '배송지38@@00038@@충북 청주시 서원구 1순환로 627@@상세주소38', NULL, NULL, '서울특별시 관악구', NULL, NULL, '서울시 관악구', '/CSS/img/profileImage2.png', 38, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.538, 127.038),
(39, 4, 'user39', '123', '사용자39', 'usernick39', '010-0039-0039', '배송지39@@00039@@충북 청주시 서원구 1순환로 627@@상세주소39', NULL, NULL, '서울특별시 동대문구', NULL, NULL, '서울시 동대문구', '/CSS/img/profileImage2.png', 39, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.539, 127.039),
(40, 4, 'user40', '123', '사용자40', 'usernick40', '010-0040-0040', '배송지40@@00040@@충북 청주시 서원구 1순환로 627@@상세주소40', NULL, NULL, '서울특별시 중구', NULL, NULL, '서울시 중구', '/CSS/img/profileImage2.png', 40, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.54, 127.04),
(41, 5, 'user41', '123', '사용자41', 'usernick41', '010-0041-0041', '배송지41@@00041@@충북 청주시 서원구 1순환로 627@@상세주소41', NULL, NULL, '서울특별시 종로구', NULL, NULL, '서울시 종로구', '/CSS/img/profileImage2.png', 41, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.541, 127.041),
(42, 5, 'user42', '123', '사용자42', 'usernick42', '010-0042-0042', '배송지42@@00042@@충북 청주시 서원구 1순환로 627@@상세주소42', NULL, NULL, '서울특별시 서초구', NULL, NULL, '서울시 서초구', '/CSS/img/profileImage2.png', 42, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.542, 127.042),
(43, 5, 'user43', '123', '사용자43', 'usernick43', '010-0043-0043', '배송지43@@00043@@충북 청주시 서원구 1순환로 627@@상세주소43', NULL, NULL, '서울특별시 양천구', NULL, NULL, '서울시 양천구', '/CSS/img/profileImage2.png', 43, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.543, 127.043),
(44, 5, 'user44', '123', '사용자44', 'usernick44', '010-0044-0044', '배송지44@@00044@@충북 청주시 서원구 1순환로 627@@상세주소44', NULL, NULL, '서울특별시 관악구', NULL, NULL, '서울시 관악구', '/CSS/img/profileImage2.png', 44, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.544, 127.044),
(45, 5, 'user45', '123', '사용자45', 'usernick45', '010-0045-0045', '배송지45@@00045@@충북 청주시 서원구 1순환로 627@@상세주소45', NULL, NULL, '서울특별시 강동구', NULL, NULL, '서울시 강동구', '/CSS/img/profileImage2.png', 45, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.545, 127.045),
(46, 5, 'user46', '123', '사용자46', 'usernick46', '010-0046-0046', '배송지46@@00046@@충북 청주시 서원구 1순환로 627@@상세주소46', NULL, NULL, '서울특별시 양천구', NULL, NULL, '서울시 양천구', '/CSS/img/profileImage2.png', 46, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.546, 127.046),
(47, 5, 'user47', '123', '사용자47', 'usernick47', '010-0047-0047', '배송지47@@00047@@충북 청주시 서원구 1순환로 627@@상세주소47', NULL, NULL, '서울특별시 송파구', NULL, NULL, '서울시 송파구', '/CSS/img/profileImage2.png', 47, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.547, 127.047),
(48, 5, 'user48', '123', '사용자48', 'usernick48', '010-0048-0048', '배송지48@@00048@@충북 청주시 서원구 1순환로 627@@상세주소48', NULL, NULL, '서울특별시 관악구', NULL, NULL, '서울시 관악구', '/CSS/img/profileImage2.png', 48, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.548, 127.048),
(49, 5, 'user49', '123', '사용자49', 'usernick49', '010-0049-0049', '배송지49@@00049@@충북 청주시 서원구 1순환로 627@@상세주소49', NULL, NULL, '서울특별시 광진구', NULL, NULL, '서울시 광진구', '/CSS/img/profileImage2.png', 49, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.549, 127.049),
(50, 5, 'user50', '123', '사용자50', 'usernick50', '010-0050-0050', '배송지50@@00050@@충북 청주시 서원구 1순환로 627@@상세주소50', NULL, NULL, '서울특별시 서초구', NULL, NULL, '서울시 서초구', '/CSS/img/profileImage2.png', 50, 0, NOW(), 'fVR2Tn_TBp_5YKfIlfqmfh:APA91bEl7gV-dB3YaBjB-PbZIMXNBuJ7qC-TpDQ7KHTDv3mNSL-iziTT_lYu61pBzPc_AggI_anEGnf41_GDMvNyOSp2j-nvaar6QfUUAL1IvEzcsz3IdZc', 37.55, 127.05);

INSERT INTO product
(categoryNo, createDate, title, content, state, img1, img2, img3, img4, img5,
 deliveryAddr, deliveryPrice, tradeType, secPrice, memberNo, startDate, endDate,
 salePrice, rentPrice, isHide, deliveryStatus, view_cnt, latitude, longitude, deleted)
VALUES
(8, '2025-04-28 20:02:30', '상품1', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 송파구', 3000, '대여', 16000, 3, NULL, NULL, 101000, 3000, 1, '택배거래', 24018, 37.559314, 126.995277, 'N'),
(3, '2025-03-28 23:02:30', '상품2', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 송파구', 2000, '판매', NULL,2, NULL, NULL, NULL, NULL, 1, '택배거래', 84802, 37.545483, 126.984094, 'N'),
(4, '2025-04-03 20:02:30', '상품3', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 마포구', 3000, '판매', NULL,4, NULL, NULL, NULL, NULL, 1, '택배거래', 250407, 37.500983, 127.045416, 'N'),
(6, '2025-04-01 18:02:30', '상품4', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 마포구', 3000, '판매', NULL, 4, NULL, NULL, 197000, NULL, 1, '택배거래', 386946, 37.569719, 127.039403, 'N'),
(6, '2025-03-22 05:02:30', '상품5', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 용산구', 3000, '판매대여', 1000, 5, NULL, NULL, NULL, 6000, 1, '택배거래', 657413, 37.542822, 126.972195, 'N'),
(7, '2025-04-03 15:02:30', '상품6', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 성북구', 3000, '대여', 44000, 3, NULL, NULL, 59000, NULL, 1, '택배거래', 251627, 37.512813, 126.985168, 'N'),
(6, '2025-04-01 20:02:30', '상품7', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 강남구', 3000, '나눔', NULL, 5, NULL, NULL, NULL, NULL, 1, '택배거래', 805273, 37.530013, 126.996346, 'N'),
(5, '2025-04-01 03:02:30', '상품8', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 송파구', 3000, '나눔', NULL, 5, NULL, NULL, NULL, 6000, 1, '택배거래', 177256, 37.568861, 126.993093, 'N'),
(8, '2025-04-13 07:02:30', '상품9', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 노원구', 2000, '나눔', NULL, 1, NULL, NULL, NULL, 7000, 1, '택배거래', 385569, 37.556576, 127.026162, 'N'),
(4, '2025-04-02 20:02:30', '상품10', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 송파구', 3000, '나눔', NULL, 2, NULL, NULL, NULL, 8000, 1, '택배거래', 164625, 37.495806, 126.991816, 'N'),
(1, '2025-04-27 18:02:30', '상품11', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 서초구', 3000, '판매대여', 2000, 3, NULL, NULL, 23000, NULL, 1, '택배거래', 905906, 37.538497, 127.02923, 'N'),
(2, '2025-03-24 11:02:30', '상품12', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 서초구', 3000, '판매', NULL, 3, NULL, NULL, 100000, NULL, 1, '택배거래', 630921, 37.544223, 127.009854, 'N'),
(5, '2025-04-21 21:02:30', '상품13', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 서초구', 3000, '나눔', NULL, 4, NULL, NULL, NULL, 8000, 1, '택배거래', 678759, 37.569205, 127.046919, 'N'),
(1, '2025-04-13 23:02:30', '상품14', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 노원구', 3000, '대여', 13000, 5, NULL, NULL, 140000, 5000, 1, '택배거래', 637966, 37.533982, 126.976703, 'N'),
(4, '2025-03-20 08:02:30', '상품15', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 송파구', 1500, '대여', 25000, 5, NULL, NULL, NULL, NULL, 1, '택배거래', 53893, 37.517383, 126.979488, 'N'),
(5, '2025-03-21 20:02:30', '상품16', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 노원구', 1500, '대여', 32000, 3, NULL, NULL, 60000, 9000, 1, '택배거래', 863233, 37.538014, 126.986873, 'N'),
(7, '2025-03-30 05:02:30', '상품17', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 강서구', 1500, '판매', NULL, 1, NULL, NULL, NULL, NULL, 1, '택배거래', 312163, 37.544183, 127.03793, 'N'),
(1, '2025-04-08 20:02:30', '상품18', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 마포구', 1500, '판매', NULL, 4, NULL, NULL, 100000, 8000, 1, '택배거래', 335492, 37.526024, 127.024509, 'N'),
(8, '2025-04-13 16:02:30', '상품19', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 강서구', 1500, '판매대여', 10000, 5, NULL, NULL, 140000, 7000, 1, '택배거래', 418128, 37.569023, 127.029792, 'N'),
(6, '2025-03-30 15:02:30', '상품20', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 관악구', 1500, '판매대여', 2000, 2, NULL, NULL, 140000, 3000, 1, '택배거래', 128802, 37.547156, 127.020122, 'N'),
(10, '2025-04-25 15:02:30', '상품21', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 강서구', 1500, '판매', NULL, 3, NULL, NULL, 80000, 1000, 1, '택배거래', 846480, 37.495192, 126.992149, 'N'),
(4, '2025-04-21 03:02:30', '상품22', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 서초구', 3000, '대여', 7000, 3, NULL, NULL, 100000, 6000, 1, '택배거래', 168087, 37.525919, 127.043317, 'N'),
(9, '2025-03-21 07:02:30', '상품23', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 강서구', 1500, '나눔', NULL, 2, NULL, NULL, 19000, 9000, 1, '택배거래', 339922, 37.484674, 127.014906, 'N'),
(2, '2025-03-24 08:02:30', '상품24', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 송파구', 1500, '판매대여', 2000, 1, NULL, NULL, NULL, 6000, 1, '택배거래', 372225, 37.578344, 127.035034, 'N'),
(9, '2025-04-06 07:02:30', '상품25', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 서초구', 1500, '판매대여', 10000, 4, NULL, NULL, 110000, 7000, 1, '택배거래', 626789, 37.509567, 127.014762, 'N'),
(5, '2025-04-23 14:02:30', '상품26', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 송파구', NULL, '판매', NULL, 4, NULL, NULL, NULL, 7000, 1, '택배거래', 956835, 37.578574, 126.973604, 'N'),
(8, '2025-03-24 06:02:30', '상품27', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 용산구', NULL, '나눔', NULL,3, NULL, NULL, 140000, NULL, 1, '택배거래', 197507, 37.570256, 127.045665, 'N'),
(1, '2025-04-26 08:02:30', '상품28', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 서초구', NULL, '판매', NULL, 3, NULL, NULL, 160000, 2000, 1, '택배거래', 376043, 37.564683, 127.013591, 'N'),
(7, '2025-03-29 10:02:30', '상품29', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 송파구', 1500, '대여', 10000,4, NULL, NULL, NULL, NULL, 1, '택배거래', 841316, 37.560704, 127.023922, 'N'),
(5, '2025-03-26 15:02:30', '상품30', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 용산구', 1500, '대여', 9000, 4, NULL, NULL, NULL, NULL, 1, '택배거래', 574219, 37.577004, 127.006179, 'N'),
(7, '2025-04-06 18:02:30', '상품31', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 강남구', 1500, '판매대여', 10000, 5, NULL, NULL, 120000, NULL, 1, '택배거래', 888810, 37.537507, 126.97417, 'N'),
(4, '2025-04-04 11:02:30', '상품32', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 성북구', NULL, '대여', 20000,4, NULL, NULL, NULL, NULL, 1, '택배거래', 875699, 37.515671, 127.037204, 'N'),
(2, '2025-04-15 13:02:30', '상품33', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 강남구', 1500, '대여', 1000, 4, NULL, NULL, NULL, 3000, 1, '택배거래', 106293, 37.535481, 127.038999, 'N'),
(2, '2025-04-19 23:02:30', '상품34', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 강남구', 1500, '판매대여', 3000, 2, NULL, NULL, NULL, NULL, 1, '택배거래', 961152, 37.527482, 127.030081, 'N'),
(3, '2025-04-21 12:02:30', '상품35', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 서초구', NULL, '대여', 27000, 4, NULL, NULL, NULL, NULL, 1, '택배거래', 317433, 37.513616, 127.040696, 'N'),
(5, '2025-03-23 16:02:30', '상품36', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 서초구', NULL, '판매대여', 4000, 4, NULL, NULL, 130000, NULL, 1, '택배거래', 619195, 37.526547, 127.014958, 'N'),
(7, '2025-04-28 09:02:30', '상품37', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 서초구', NULL, '대여', 20000, 3, NULL, NULL, NULL, 5000, 1, '택배거래', 877523, 37.503373, 127.02496, 'N'),
(7, '2025-04-25 13:02:30', '상품38', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 송파구', 1500, '판매', NULL, 5, NULL, NULL, NULL, NULL, 1, '택배거래', 566937, 37.555888, 126.99504, 'N'),
(4, '2025-04-16 14:02:30', '상품39', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 마포구', NULL, '대여', 15000, 5, NULL, NULL, 60000, NULL, 1, '택배거래', 763050, 37.515864, 127.002451, 'N'),
(5, '2025-04-01 20:02:30', '상품40', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 강남구', 1500, '대여', 20000, 4, NULL, NULL, 90000, NULL, 1, '택배거래', 262678, 37.530311, 127.038169, 'N'),
(9, '2025-04-09 18:02:30', '상품41', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 서초구', 1500, '판매대여', 1000, 1, NULL, NULL, NULL, 7000, 1, '택배거래', 195646, 37.539106, 126.975174, 'N'),
(4, '2025-04-13 16:02:30', '상품42', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 용산구', 1500, '나눔', NULL,4, NULL, NULL, 190000, NULL, 1, '택배거래', 22637, 37.56483, 127.025106, 'N'),
(5, '2025-04-02 13:02:30', '상품43', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 마포구', 1500, '판매대여', 20000, 4, NULL, NULL, NULL, 5000, 1, '택배거래', 858991, 37.54376, 127.022599, 'N'),
(4, '2025-03-30 12:02:30', '상품44', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 마포구', NULL, '나눔', NULL, 4, NULL, NULL, 10000, 4000, 1, '택배거래', 387489, 37.540762, 126.986122, 'N'),
(7, '2025-03-23 17:02:30', '상품45', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 강서구', NULL, '나눔', NULL, 3, NULL, NULL, 20000, NULL, 1, '택배거래', 908588, 37.546525, 127.004854, 'N'),
(8, '2025-03-21 07:02:30', '상품46', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 관악구', 1500, '판매대여', 4000, 1, NULL, NULL, 190000, 9000, 1, '택배거래', 503542, 37.528953, 126.995456, 'N'),
(2, '2025-03-23 11:02:30', '상품47', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 송파구', 4000, '나눔', NULL, 4, NULL, NULL, NULL, 1000, 1, '택배거래', 202568, 37.505653, 127.031971, 'N'),
(6, '2025-03-21 03:02:30', '상품48', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 성북구', 3000, '판매', NULL, 3, NULL, NULL, 30000, NULL, 1, '택배거래', 7162, 37.567025, 127.014405, 'N'),
(9, '2025-04-28 16:02:30', '상품49', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 용산구', NULL, '나눔', NULL, 4, NULL, NULL, NULL, NULL, 1, '택배거래', 950586, 37.509174, 127.025498, 'N'),
(2, '2025-04-26 07:02:30', '상품50', '설명입니다', '사용감적음', 'img1.jpg', 'img2.jpg', 'img3.jpg', 'img4.jpg', 'img5.jpg', '서울특별시 송파구', 1500, '판매대여', 40000, 4, NULL, NULL, NULL, 6000, 1, '택배거래', 161019, 37.528661, 126.978944, 'N');

INSERT INTO faq_category (no, name) VALUES
(1, '주문/결제'),
(2, '배송'),
(3, '취소/환불'),
(4, '반품/교환'),
(5, '기타');



INSERT INTO category (name, sortOrder, isActive, imgfilename) VALUES
('전체', 1, 1, 'img/category/all.png'),
('의류/패션/악세사리', 2, 1, 'img/category/clothes.png'),
('PC/모바일', 3, 1, 'img/category/packaging.png'),
('가전 제품', 4, 1, 'img/category/homeAppliance.png'),
('뷰티/미용', 5, 1, 'img/category/beauty.png'),
('캠핑/스포츠/레저', 6, 1, 'img/category/etc.png'),
('생활/주방용품', 7, 1, 'img/category/kitchen.png'),
('가구인테리어', 8, 1, 'img/category/cookware.png'),
('유아동/출산', 9, 1, 'img/category/baby.png'),
('애완동물용품', 10, 1, 'img/category/pet.png'),
('기타', 11, 1, 'img/category/profileImage.png');



CREATE TABLE note (
  noteNo INT AUTO_INCREMENT PRIMARY KEY,         -- 쪽지 PK
  productNo INT NOT NULL,                        -- 상품 번호
  memberNo INT NOT NULL,                         -- 보낸 사람 (sender)
  receiverNo INT NOT NULL,                       -- 받는 사람 (receiver)
  noteContent VARCHAR(1000) NOT NULL,            -- 쪽지 내용
  curdate DATETIME DEFAULT CURRENT_TIMESTAMP,    -- 전송 시각

  -- 외래키 설정 (선택)
  CONSTRAINT fk_note_product FOREIGN KEY (productNo) REFERENCES product(no),
  CONSTRAINT fk_note_member FOREIGN KEY (memberNo) REFERENCES member(no),
  CONSTRAINT fk_note_receiver FOREIGN KEY (receiverNo) REFERENCES member(no)
);
