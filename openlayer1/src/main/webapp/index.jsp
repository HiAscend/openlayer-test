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
<ol>
    <li><a href="accessible.jsp">初步访问地图</a><br></li>
    <li><a href="animation.jsp">查看动画</a><br></li>
    <li><a href="bing-maps.jsp">Bing地图</a><br></li>
    <li><a href="custom-controls.jsp">显示如何创建自定义控件</a><br></li>
    <li><a href="custom-icon.jsp">显示如何创建自定义控件</a><br></li>
    <li><a href="custom-interactions.jsp">自定义交互</a><br></li>
    <li><a href="draw-and-modify-features.jsp">画点线面</a><br></li>
    <li><a href="draw-features.jsp">绘制插件</a><br></li>
    <li><a href="draw-freehand.jsp">手绘图案</a><br></li>
    <li><a href="earthquake-custom-symbol.jsp">地震自定义符号</a><br></li>
    <li><a href="feature-animation.jsp">自定义动画</a><br></li>
    <li><a href="xyz-esri.jsp">xyz-esri</a><br></li>
    <li><h4><a href="load-local-tile.jsp">load-local-tile</a><br></h4></li>
</ol>

</body>
</html>
