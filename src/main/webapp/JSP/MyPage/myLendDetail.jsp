<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<c:set var="contextPath" value="${pageContext.request.contextPath }" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Lend Detail</title>
<link rel="stylesheet" href="${contextPath}/CSS/mypage/myLendDetail.css">
</head>
<body>
<!-- 헤더 (로고 + 검색창 + 카테고리) -->
  <jsp:include page="/JSP/Header/header.jsp" />
  
	<div class="wrapper">
      <div class="container">
        <!-- 사이드바 -->
        <jsp:include page="/JSP/MyPage/mypageSidebar.jsp" />
        
        <!-- 콘텐츠 영역 -->
        <section class="content">
          <h2>대여 상세</h2>
          <div class="divider"></div>
          
          <c:choose>
			<c:when test="${id eq null }">
				<span> 로그인이 필요한 페이지입니다.</span>
			</c:when>
			
			<c:otherwise>
          
          <div class="section product-box">
                <img src="https://via.placeholder.com/120x100?text=🚲" alt="자전거">
                <div class="product-info">
                    <div style="font-size: 13px; color: gray;">상품번호 98765432134567</div>
                    <div class="product-title">성인용 자전거 (일반주행용, 3년 전 구입)</div>
                    <div class="price">1일 100,000원</div>
                </div>
                <span class="status-text">상품배송중</span>
            </div>

            <div class="info-grid">
                <div class="info-box">
                    <h4>대여 배송 정보</h4>
                    <p>송장번호: 23456789123</p>
                    <p>택배사: 롯데택배</p>
                    <p>배송지: (04020) 서울시 관악구 문성동</p>
                </div>
                <div class="info-box">
                    <h4>대여회원 정보</h4>
                    <p>deoksoo1243</p>
                    <p>010-1234-5678</p>
                    <p>(04020) 서울시 관악구 문성동</p>
                    
                </div>
            </div>

            <div class="info-grid" style="margin-top: 20px;">
                <div class="info-box">
                    <h4>대여 기간</h4>
                    <p>대여 신청일 2025-03-04</p>
                    <p>대여 시작일 2025-03-06</p>
                    <p><strong>대여 종료일 2025-03-09</strong></p>
                    <p><strong>상품 회수일 2025-03-11</strong></p>
                    
                </div>
                <div class="info-box">
                    <h4>결제정보</h4>
                    <p><strong>총 결제금액:</strong> 400,000원</p>
                    <p>1일 이용금액: 100,000원 &nbsp;&nbsp;<strong>총 3일 이용</strong></p>
                    <p>보증금: 100,000원</p>
                    <p>배송비: 0원</p>
                </div>
            </div>
            
             <div class="rental-table-wrapper">
                <h3>이 상품의 대여 거래 이력</h3>
                <div class="divider"></div>
                <table class="rental-table">
                    <thead>
                        <tr>
                            <th>이용자ID</th>
                            <th>대여기간</th>
                            <th>이용일</th>
                            <th>이용금액</th>
                            <th>상품훼손/연체</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="highlight">
                            <td><strong>deoksoo1243</strong></td>
                            <td><strong>2025-03-04 ~ 2025-03-07</strong></td>
                            <td><strong>3일</strong></td>
                            <td><strong>300,000원</strong></td>
                            <td>없음</td>
                        </tr>
                        <tr>
                            <td>dong</td>
                            <td>2025-02-11 ~ 2025-02-12</td>
                            <td>3일</td>
                            <td>300,000원</td>
                            <td>없음</td>
                        </tr>
                        <tr>
                            <td>honggil</td>
                            <td>2025-03-01 ~ 2025-03-04</td>
                            <td>3일</td>
                            <td>300,000원</td>
                            <td>없음</td>
                        </tr>
                        <tr>
                            <td>honggil</td>
                            <td>2025-03-01 ~ 2025-03-04</td>
                            <td>3일</td>
                            <td>300,000원</td>
                            <td>없음</td>
                        </tr>
                        <tr>
                            <td>honggil</td>
                            <td>2025-03-01 ~ 2025-03-04</td>
                            <td>3일</td>
                            <td>300,000원</td>
                            <td>없음</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            </c:otherwise>
            </c:choose>
            
          </section>
        </div>
    </div>
    
    <!-- 푸터 -->
	<jsp:include page="/JSP/Header/footer.jsp" />
		  
</body>
</html>