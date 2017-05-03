<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Accessible Map</title>
    <link rel="stylesheet" href="resources/frame/openlayers/css/ol.css" type="text/css">
    <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
    <%--<script src="https://cdn.polyfill.io/v2/polyfill.min.js?features=requestAnimationFrame,Element.prototype.classList,URL"></script>--%>
    <script src="resources/frame/openlayers/js/ol-debug.js"></script>
    <style>
        a.skiplink {
            position: absolute;
            clip: rect(1px, 1px, 1px, 1px);
            padding: 0;
            border: 0;
            height: 1px;
            width: 1px;
            overflow: hidden;
        }
        a.skiplink:focus {
            clip: auto;
            height: auto;
            width: auto;
            background-color: #fff;
            padding: 0.3em;
        }
        #map:focus {
            outline: #4A74A8 solid 0.15em;
        }
    </style>
</head>
<body>
<a class="skiplink" href="#map">Go to map</a>
<div id="map" class="map" tabindex="0"></div>
<button id="zoom-out">Zoom out</button>
<button id="zoom-in">Zoom in</button>
<script>


    var styles = {
        'route': new ol.style.Style({
            stroke: new ol.style.Stroke({
                width: 6, color: [237, 212, 0, 0.8]
            })
        }),
        'icon': new ol.style.Style({
            image: new ol.style.Icon({
                anchor: [0.5, 1],
                src: 'https://openlayers.org/en/v4.1.0/examples/data/icon.png'
            })
        }),
        'geoMarker': new ol.style.Style({
            image: new ol.style.Circle({
                radius: 7,
                snapToPixel: false,
                fill: new ol.style.Fill({color: 'black'}),
                stroke: new ol.style.Stroke({
                    color: 'white', width: 2
                })
            })
        })
    };
    var pointList = [
        ol.proj.fromLonLat([116,40]),
        ol.proj.fromLonLat([115,40]),
        ol.proj.fromLonLat([114,40]),
        ol.proj.fromLonLat([113,39]),
        ol.proj.fromLonLat([112,38]),
        ol.proj.fromLonLat([111,39]),
        ol.proj.fromLonLat([110,41])
    ];
    var lineString = new ol.geom.LineString(pointList,'XY');
    var routeFeature = new ol.Feature({
        type: 'route',
        geometry: lineString
    });
    var routeVectorLayer = new ol.layer.Vector({
        source: new ol.source.Vector({
            features: [routeFeature]
        }),
        style: function (feature) {
            return styles[feature.get('type')];
        }
    });

    var map = new ol.Map({
        layers: [
            new ol.layer.Tile({
                source: new ol.source.OSM()
            }),
            routeVectorLayer
        ],
        target: 'map',
        controls: ol.control.defaults({
            attributionOptions: /** @type {olx.control.AttributionOptions} */ ({
                collapsible: false
            })
        }),
        view: new ol.View({
//            center: [116.49, 39.91],
            center: ol.proj.fromLonLat([116,40]),
            zoom: 5
        })
    });

    document.getElementById('zoom-out').onclick = function() {
        var view = map.getView();
        var zoom = view.getZoom();
        console.log(zoom);
        view.setZoom(zoom - 1);
    };

    document.getElementById('zoom-in').onclick = function() {
        var view = map.getView();
        var zoom = view.getZoom();
        console.log(zoom);
        view.setZoom(zoom + 1);
    };
</script>
</body>
</html>
