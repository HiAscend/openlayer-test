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
</head>
<body>
<div id="map" class="map"></div>
<script>
    var attribution = new ol.Attribution({
        html: 'Tiles © <a href="https://services.arcgisonline.com/ArcGIS/' +
        'rest/services/World_Topo_Map/MapServer">ArcGIS</a>'
    });

    var layer = new ol.layer.Tile({
        source: new ol.source.XYZ({
            attributions: [attribution],
            url: 'https://server.arcgisonline.com/ArcGIS/rest/services/' +
            'World_Topo_Map/MapServer/tile/{z}/{y}/{x}'
        })
    });

    var layer1 = new ol.layer.Tile({
        source:new ol.source.TileArcGISRest({
            attributions:[attribution],
            url:'http://localhost:9009/arctiler/arcgis/services/beijing/MapServer'
        })
    });

    var layer2 = new ol.layer.Tile({
        source:new ol.source.WMTS({
            attributions:[attribution],
            url:'http://localhost:9009/arctiler/ogc/services/beijing/WMTS'
        })
    });

    var map = new ol.Map({
        target: 'map',
        layers: [
            layer
        ],
        view: new ol.View({
            center: ol.proj.fromLonLat([116, 40]),

            zoom: 0
        })
    });

    //http://localhost:9009/arctiler/arcgis/services/beijing/MapServer
</script>
</body>
</html>
