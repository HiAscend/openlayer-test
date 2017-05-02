<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "";
    pageContext.setAttribute("basePath", basePath);
%>

<%
//    header
%>
<!DOCTYPE html>
<html>
<head>
    <title>OpenLayers 3 Example</title>
    <%--<link rel="stylesheet" href="${basePath}/resources/frame/openlayers3/css/ol.css" type="text/css">--%>
    <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
    <%--<script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>--%>
    <%--<script src="${basePath}/resources/frame/openlayers3/js/libs/ol-debug.js"></script>--%>
    <%--<script src="${basePath}/resources/js/comment/itelluro.ol.js"></script>--%>

    <link rel="stylesheet" href="http://openlayers.org/en/v3.3.0/css/ol.css" type="text/css">
    <script src="http://openlayers.org/en/v3.3.0/build/ol.js" type="text/javascript"></script>
</head>
<body>
<div id="map" class="map"></div>
<script>
    var map = new ol.Map({
        target: 'map',
        layers: [
            new ol.layer.Tile({
                source: new ol.source.MapQuest({layer: 'sat'})
            })
        ],
        view: new ol.View({
            center: ol.proj.transform([37.41, 8.82], 'EPSG:4326', 'EPSG:3857'),
            zoom: 4
        })
    });

</script>
</body>
</html>
