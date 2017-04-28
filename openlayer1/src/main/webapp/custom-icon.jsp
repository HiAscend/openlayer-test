<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>bing-maps</title>
    <link rel="stylesheet" href="resources/frame/openlayers/css/ol.css" type="text/css">
    <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
    <%--<script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>--%>
    <script src="resources/frame/openlayers/js/ol-debug.js"></script>
</head>
<body>
<div id="map" class="map">
    <div id="popup"></div>
</div>
<script>
    var logoElement = document.createElement('a');
    logoElement.href = 'https://www.osgeo.org/';
    logoElement.target = '_blank';

    var logoImage = document.createElement('img');
    logoImage.src = 'https://www.osgeo.org/sites/all/themes/osgeo/logo.png';

    logoElement.appendChild(logoImage);

    var map = new ol.Map({
        layers: [
            new ol.layer.Tile({
                source: new ol.source.OSM()
            })
        ],
        target: 'map',
        view: new ol.View({
            center: [0, 0],
            zoom: 2
        }),
        logo: 'https://www.osgeo.org/sites/all/themes/osgeo/logo.png'
    });
</script>
</body>
</html>
