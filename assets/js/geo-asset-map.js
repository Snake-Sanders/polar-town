import L from "../vendor/leaflet";

class GeoAssetMap {

  // Initializes the Map, view, zoom, title, copyright, etc
  constructor(element, center, mapEventCallback) {
    this.map = L.map(element);
    this.map.setView(center, 13);

    L.tileLayer(
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      {
        maxZoom: 19,
        attribution:
          '©<a href="https://www.openstreetmap.org/copyright/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
      }
    ).addTo(this.map);

    this.mapEventCallback = mapEventCallback;
    this.map.on('contextmenu', e => {
      console.log("pressed right click")
      this.mapEventCallback(e, "right-click")
    });
  }

  // Adds a Marked on the map for a given GeoAsset
  addMarker(geoasset) {
    const marker_options = {
      geoassetId: geoasset.id,
      icon: L.icon({
        iconUrl: 'images/map/marker-icon.png',
        shadowUrl: 'images/map/marker-shadow.png',
        iconSize: [24, 36],
        iconAnchor: [12, 36],
      })
    }

    const marker =
      L.marker([geoasset.lat, geoasset.lng], marker_options)
        .addTo(this.map)
        .bindPopup(geoasset.name)

    marker.on("click", e => {
      console.log("pressed click")
      marker.openPopup();
      this.mapEventCallback(e, "selected-marker");
    });

    return marker;
  }

  // Finds and highlights a Marker on the map
  // when the item is selected somewhere else outside the map.
  highlightMarker(geoasset) {
    const marker = this.getMarkerForGeoAsset(geoasset);

    marker.openPopup();

    this.map.panTo(marker.getLatLng());
  }

  // finds a Marker for a given GeoAsset
  getMarkerForGeoAsset(geoasset) {
    let markerLayer;
    this.map.eachLayer(layer => {
      if (layer instanceof L.Marker) {
        const markerPosition = layer.getLatLng();
        if (markerPosition.lat === geoasset.lat &&
          markerPosition.lng === geoasset.lng) {
          markerLayer = layer;
        }
      }
    });

    return markerLayer;
  }
}

export default GeoAssetMap;
