<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Accessible Map</title>

</head>
<body>
<a href="accessible.jsp">初步访问地图</a><br>
<a href="animation.jsp">查看动画</a><br>

</body>
</html>
