<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>draw-features</title>
    <link rel="stylesheet" href="resources/frame/openlayers/css/ol.css" type="text/css">
    <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
    <%--<script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>--%>
    <script src="resources/frame/openlayers/js/ol-debug.js"></script>
</head>
<body>
<div id="map" class="map"></div>
<form class="form-inline">
    <label>Geometry type &nbsp;</label>
    <select id="type">
        <option value="Point">Point</option>
        <option value="LineString">LineString</option>
        <option value="Polygon">Polygon</option>
        <option value="Circle">Circle</option>
        <option value="None">None</option>
    </select>
    <button onclick="getSomething()">获取数据</button>
</form>
<script>
    var raster = new ol.layer.Tile({
        source: new ol.source.OSM()
    });

    //测试
    var destFeature = new ol.Feature({
        name: 'testFeature'
    });

    var source = new ol.source.Vector({
        wrapX: false,
        features:[destFeature]
    });

    var vector = new ol.layer.Vector({
        source: source
    });

    var map = new ol.Map({
        layers: [raster, vector],
        target: 'map',
        view: new ol.View({
            center: [-11000000, 4600000],
            zoom: 4
        })
    });

    var typeSelect = document.getElementById('type');





    var draw; // global so we can remove it later
    function addInteraction() {
        var value = typeSelect.value;
        if (value !== 'None') {
            draw = new ol.interaction.Draw({
                features:[destFeature],
                source: source,
                type: /** @type {ol.geom.GeometryType} */ (typeSelect.value)
            });
            map.addInteraction(draw);
            draw.on('drawend',drawEndCallBack,this);
        }
    }


    /**
     * Handle change event.
     */
    typeSelect.onchange = function () {
        map.removeInteraction(draw);
        addInteraction();
    };

    addInteraction();

    //回调
    function drawEndCallBack(event) {
        var destFeature = event.feature;
        var coordinates = destFeature.getGeometry().getCoordinates();
        var list = [];
        for (var i=0;i<coordinates[0].length;i++){
            list.push(ol.proj.transform(coordinates[0][i], 'EPSG:3857', 'EPSG:4326'));
        }
        console.log(JSON.stringify(list));
//        map.removeInteraction(draw);
    }

    function getSomething() {
//        source.clear();
        source.removeFeature(destFeature);
    }
</script>
</body>
</html>
