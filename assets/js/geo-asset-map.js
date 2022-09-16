import L from "../vendor/leaflet";

class GeoAssetMap {

  // Initializes the Map, view, zoom, title, copyright, etc
  constructor(element, center, markerClickedCallback) {
    this.map = L.map(element).setView(center, 13);

    L.tileLayer(
      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      {
        maxZoom: 18,
        attribution:
          '©<a href="https://www.openstreetmap.org/copyright/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
      }
    ).addTo(this.map);

    this.markerClickedCallback = markerClickedCallback;
  }

  // Adds a Marked on the map for a given GeoAsset
  addMarker(geoasset) {
    const marker_options = {
      geoassetId: geoasset.id,
      icon: L.icon({
        iconUrl: 'images/map/marker-icon.png',
        shadowUrl: 'images/map/marker-shadow.png'
      })
    }
    
    const marker =
      L.marker([geoasset.lat, geoasset.lng], marker_options)
        .addTo(this.map)
        .bindPopup(geoasset.name)

    marker.on("click", e => {
      marker.openPopup();
      this.markerClickedCallback(e);
    });

    return marker;
  }

  // callback for highlighting a Marker on the map
  // when the item is selected on from the list on the web.
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
