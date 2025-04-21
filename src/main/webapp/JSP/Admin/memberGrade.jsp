<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원등급</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Admin/common.css">


</head>
<body>
	<%@ include file="header.jsp" %>
  <div class="container">
    <aside>
      <h3>회원관리</h3>
      <div class="menu inactive">회원정보</div>
      <div class="menu active">회원등급</div>
    </aside>
    <main>
      <div class="breadcrumb">HOME > 회원관리 > 회원등급</div>
      <div class="section-title">회원등급설정</div>
      <table>
        <thead>
          <tr>
            <th>no</th>
            <th>등급명</th>
            <th>수수료설정(%)</th>
            <th>비고</th>
          </tr>
        </thead>
        <tbody>
           <c:forEach var="grade" items="${gradeList}">
            <tr>
              <td>
                <input type="text" name="gradeNo" value="${grade.gradeNo}" readonly />
              </td>
              <td>
                <input type="text" name="gradeName" value="${grade.gradeName}" />
              </td>
              <td>
                <input type="text" name="gradeRate" value="${grade.gradeRate}" />
              </td>
              <td>
                <c:choose>
                  <c:when test="${grade.gradeCount == 0}">
                    default
                  </c:when>
                  <c:otherwise>
                    거래횟수 ${grade.gradeCount}회 이상
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      
      <div class="info-note">*등급명, 수수료 수정 가능</div>
      <div class="save-button">
        <button type="button" id="saveGrade">✔ 저장</button>
      </div>
    </main>
  </div>
  
  
  <!-- jQuery + AJAX -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    $(function () {
      $("#saveGrade").click(function () {
        let gradeList = [];

        $("tbody tr").each(function () {
          const gradeNo = $(this).find("input[name='gradeNo']").val();
          const gradeName = $(this).find("input[name='gradeName']").val();
          const gradeRate = $(this).find("input[name='gradeRate']").val();

          gradeList.push({
            gradeNo: gradeNo,
            gradeName: gradeName,
            gradeRate: gradeRate
          });
        });

        $.ajax({
          url: "memberGrade",
          type: "POST",
          contentType: "application/json; charset=utf-8",
          data: JSON.stringify(gradeList),
          success: function (response) {
            alert("등급이 성공적으로 저장되었습니다!");
          },
          error: function () {
            alert("저장 중 오류가 발생했습니다.");
          }
        });
      });
    });
  </script>
</body>
</html>