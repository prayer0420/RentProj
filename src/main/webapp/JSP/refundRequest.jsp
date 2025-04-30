<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>환불 요청</title>
</head>
<body>
    <h2>환불 요청</h2>
    <form action="${pageContext.request.contextPath}/refund" method="post">
        <label>Payment Key:</label><br>
        <input type="text" name="paymentKey" required><br><br>

        <label>환불 사유:</label><br>
        <input type="text" name="cancelReason" required><br><br>

        <label>환불 금액(선택):</label><br>
        <input type="text" name="cancelAmount" placeholder="비우면 전체 환불"><br><br>

        <button type="submit">환불 요청하기</button>
    </form>
</body>
</html>