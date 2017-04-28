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
    <style>
        .rotate-north {
            top: 65px;
            left: .5em;
        }

        .ol-touch .rotate-north {
            top: 80px;
        }
    </style>
</head>
<body>
<div id="map" class="map"></div>
<script>
    /**
     * Define a namespace for the application.
     */
    window.app = {};
    var app = window.app;


    //
    // Define rotate to north control.
    //


    /**
     * @constructor
     * @extends {ol.control.Control}
     * @param {Object=} opt_options Control options.
     */
    app.RotateNorthControl = function (opt_options) {

        var options = opt_options || {};

        var button = document.createElement('button');
        button.innerHTML = 'N';

        var this_ = this;
        var handleRotateNorth = function () {
            this_.getMap().getView().setRotation(0);
        };

        button.addEventListener('click', handleRotateNorth, false);
        button.addEventListener('touchstart', handleRotateNorth, false);

        var element = document.createElement('div');
        element.className = 'rotate-north ol-unselectable ol-control';
        element.appendChild(button);

        ol.control.Control.call(this, {
            element: element,
            target: options.target
        });

    };
    ol.inherits(app.RotateNorthControl, ol.control.Control);


    //
    // Create map, giving it a rotate to north control.
    //


    var map = new ol.Map({
        controls: ol.control.defaults({
            attributionOptions: /** @type {olx.control.AttributionOptions} */ ({
                collapsible: false
            })
        }).extend([
            new app.RotateNorthControl()
        ]),
        layers: [
            new ol.layer.Tile({
                source: new ol.source.OSM()
            })
        ],
        target: 'map',
        view: new ol.View({
            center: [0, 0],
            zoom: 3,
            rotation: 1
        })
    });
</script>
</body>
</html>
