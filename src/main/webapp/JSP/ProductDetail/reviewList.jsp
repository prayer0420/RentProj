<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="review-list">
  <c:forEach var="review" items="${reviewList}">
    <div class="review-item">
      <strong>${review.nickname}</strong>
      <div class="stars">
        <c:forEach begin="1" end="5" var="i">
          <c:choose>
            <c:when test="${i <= review.rating}">★</c:when>
            <c:otherwise>☆</c:otherwise>
          </c:choose>
        </c:forEach>
      </div>
      <p>${review.content}</p>
    </div>
  </c:forEach>
</div>