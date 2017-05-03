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
        [115, 40],
        [114, 40],
        [113, 40],
        [102, 40]
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
            // hide geoMarker if animation is active
//            if (animating && feature.get('type') === 'geoMarker') {
//                return null;
//            }
            return styles[feature.get('type')];
        }
    });

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
            }),
            routeVectorLayer
        ],
        view: new ol.View({
            center: ol.proj.fromLonLat([116, 40]),
//            center: ol.proj.fromLonLat([116, 40],'EPSG:4326'),
            zoom: 6,
            maxZoom: 8,
            minZoom: 5,
            extent: [11588560.105894227, 3580577.211859674, 14085910.694027465, 5745273.852895829]
        }),
        controls: ol.control.defaults().extend([
            new ol.control.FullScreen(),
            new ol.control.MousePosition()
        ])
    });
    /**
     * Add a click handler to the map to render the popup.
     */
    map.on('singleclick', function (evt) {
        var coordinate = evt.coordinate;
        var hdms = ol.coordinate.toStringHDMS(ol.proj.transform(
                coordinate, 'EPSG:3857', 'EPSG:4326'));
        console.log('hdms:' + hdms);
        var xy = ol.coordinate.toStringXY(coordinate, 9);
        console.log('xy:' + xy);
    });
</script>
</body>
</html>
