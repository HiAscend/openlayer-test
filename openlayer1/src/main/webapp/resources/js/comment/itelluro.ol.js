/**
 * Created by Administrator on 2017/4/26.
 */
/**
 * those are for pulling tiles from Itelluro tiles source address, which would return a new layer or map that is access to openlayer3.
 * refer to http://openlayers.org
 */

//
// map

/**
 * @param {string} id The container for the map.
 * @param {number} numLevels The maximum zoom level used to determine the resolution constraint.
 * @param {number} dsEast  MaxX extent coordinates.
 * @param {number} dsWest MinX extent coordinates
 * @param {number} dsSouth MinY extent coordinates
 * @param {numbere} dsNorth MaxY extent coordinates
 * @param {string} sourcePackageKey Source Package Key of tiles' provider.
 * @param {string} url URL address of tiles' provider.
 * @param {number} tileSize The pixel of tile.
 * @param {number} zeroLevelSize  The size of zero level tile.
 * @return {ol.layer.Tile} return map
 */
function NewWebTilesMap(id, numLevels, dsEast, dsWest, dsSouth, dsNorth,
                        sourcePackageKey, url, tileSize, zeroLevelSize) {

    layer1 = newItelluroLayer(sourcePackageKey, url, tileSize, zeroLevelSize);

    var view = new ol.View({
        center: [(dsEast + dsWest) / 2, (dsNorth + dsSouth) / 2], zoom: 0, minZoom: 0, maxZoom: numLevels,
        projection: 'EPSG:4326',
        maxResolution: zeroLevelSize / tileSize,
    });

    var map = new ol.Map({
        layers: [layer1],
        target: id,
        view: view,
        renderer: "dom"
    });

    return map;
}

/**
 * @param {string} id The container for the map.
 * @param {number} numLevels The maximum zoom level used to determine the resolution constraint.
 * @param {number} dsEast  MaxX extent coordinates.
 * @param {number} dsWest MinX extent coordinates
 * @param {number} dsSouth MinY extent coordinates
 * @param {number} dsNorth MaxY extent coordinates
 * @param {string} root Local root directory of tiles' files.
 * @param {number} tileSize The pixel of tile.
 * @param {number} zeroLevelSize The size of zero level tile.
 * @return {ol.layer.Tile} return map
 */
function NewLocalTilesMap(id, numLevels, dsEast, dsWest, dsSouth, dsNorth,
                          root, tileSize, zeroLevelSize){

    layer1 = newLocalTilesLayer(root, tileSize, zeroLevelSize);

    var view = new ol.View({
        center: [(dsEast + dsWest) / 2, (dsNorth + dsSouth) / 2], zoom: 0, minZoom: 0, maxZoom: numLevels,
        projection: 'EPSG:4326',
        maxResolution: zeroLevelSize / tileSize,
    });

    var map = new ol.Map({
        layers: [layer1],
        target: id,
        view: view,
        renderer: "dom"
    });

    return map;
}


//
// layer

/**
 * @param {string} sourcePackageKey The package key address of tiles' provider.
 * @param {string} url URL address of tiles' provider.
 * @param {number} tileSize The pixel of tile.
 * @param {number} zeroLevelSize  The size of zero level tile.
 * @return {ol.layer.Tile} return layer
 */
function newItelluroLayer(sourcePackageKey, url, tileSize, zeroLevelSize) {
    if (url.indexOf("?") > 0)
        url += "&T={t}";
    else
        url += "?T={t}";
    url = url.replace('{t}', sourcePackageKey);
    return newWebTilesLayer(url, tileSize, zeroLevelSize);
}

/**
 * @param {string} root Local root directory of tiles' files.
 * @param {number} tileSize The pixel of tile.
 * @param {number} zeroLevelSize  The size of zero level tile.
 * @return {ol.layer.Tile} return layer
 */
function newLocalTilesLayer(root, tileSize, zeroLevelSize) {
    var imageType = "png";
    // root += "\\{z}\\{y}\\{y}_{x}." + imageType;
    root += "\\{z}\\{y}\\{x}." + imageType;
    return newTilesUrlLayer(root, tileSize, zeroLevelSize);
}

/**
 * @param {string} url URL address of tiles' provider.
 * @param {number} tileSize The pixel of tile.
 * @param {number} zeroLevelSize  The size of zero level tile.
 * @return {ol.layer.Tile} return layer
 */
function newWebTilesLayer(url, tileSize, zeroLevelSize) {
    url = encodeURI(url);
    if (url.indexOf("?") > 0)
        url += "&L={z}&X={x}&Y={y}";
    else
        url += "?L={z}&X={x}&Y={y}";
    return newTilesUrlLayer(url, tileSize, zeroLevelSize);
}

/**
 * @param {string} urlTemplate URL template. Must include {x}, {y} or {-y}.
 * @param {number} tileSize The pixel of tile.
 * @param {number} zeroLevelSize  The size of zero level tile.
 * @return {ol.layer.Tile} return layer
 */
function newTilesUrlLayer(urlTemplate, tileSize, zeroLevelSize) {
    var resolutions = new Array(22);
    for (var i = 0, ii = resolutions.length; i < ii; ++i) {
        resolutions[i] = zeroLevelSize / Math.pow(2, i) / 512;
    }
    var layer = new ol.layer.Tile({
        source: new ol.source.XYZ({
            tileSize: tileSize,
            tileUrlFunction: tileUrlFunctionCallBack,
            projection: 'EPSG:4326',
            //tilePixelRatio: tileSize / 256,
            tileGrid: new ol.tilegrid.TileGrid({
                resolutions: resolutions,
                tileSize: tileSize,
                origin:[-180,-90]
            })
        }),
        name: ''
    });

    function tileUrlFunctionCallBack(tileCoord, pixelRatio, projection) {
        var z = tileCoord[0];
        var x = tileCoord[1];
        var y = tileCoord[2];

        /*var xStr4 = "0000" + x.toString();
        xStr4 = xStr4.substr(xStr4.length - 4, 4);
        var yStr4 = "0000" + y.toString();
        yStr4 = yStr4.substr(yStr4.length - 4, 4);*/

        var url = urlTemplate.replace('{z}', z.toString());
        // url=url.replace('{y}', yStr4);
        // url=url.replace('{y}', yStr4);
        // url = url.replace('{x}', xStr4);
        // url = url.replace('{x}', xStr4);
        url=url.replace('{y}', y);
        url=url.replace('{x}', x);
        return url
    }

    return layer;
}