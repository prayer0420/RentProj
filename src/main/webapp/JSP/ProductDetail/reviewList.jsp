<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="review-list">
	<c:forEach var="review" items="${reviewList}">
		<div class="review-item">
			<strong>${review.memberNickname}</strong>
			<c:if test="${review.memberNo == memberNo}">
				<button class="review-edit" type="button">수정</button>
				<button class="review-del" type="button"
					onclick="deleteReview(${review.no})">삭제</button>
			</c:if>
			<div class="stars">
				<c:forEach begin="1" end="5" var="i">
					<c:choose>
						<c:when test="${i <= review.score}">★</c:when>
						<c:otherwise>☆</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
			<p>${review.contents}</p>
		</div>
	</c:forEach>
</div>