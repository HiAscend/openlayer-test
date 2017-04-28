<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>xyz-esri</title>
    <link rel="stylesheet" href="resources/frame/openlayers/css/ol.css" type="text/css">
    <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
    <%--<script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>--%>
    <script src="resources/frame/openlayers/js/ol-debug.js"></script>
    <script src="resources/js/comment/itelluro.ol.js"></script>
</head>
<body>
<div id="map" class="map"></div>
<script>
    /*var map = new NewLocalTilesMap(
            'map',
            15,
            115.4224,
            117.5070,
            39.4574,
            41.0504,
            'resources/tiles',
            256,
            256
    );*/
    var attribution = new ol.Attribution({
        html: 'Tiles © <a href="https://services.arcgisonline.com/ArcGIS/' +
        'rest/services/World_Topo_Map/MapServer">ArcGIS</a>'
    });

    var map = new ol.Map({
        target: 'map',
        layers: [
            new ol.layer.Tile({
                source: new ol.source.XYZ({
                    attributions: [attribution],
                    url: 'http://localhost:8080/resources/map/city/{z}/{x}/{y}.png'
                })
            })
        ],
        view: new ol.View({
            center: ol.proj.fromLonLat([116, 40],'EPSG:3857'),
//            center: ol.proj.fromLonLat([116, 40],'EPSG:4326'),
            zoom: 4
        }),
        controls:ol.control.defaults().extend([
                new ol.control.FullScreen(),
                new ol.control.MousePosition()
        ])
    });
</script>
</body>
</html>
