
import GeoAssetMap from "./geo-asset-map"

let Hooks = {};

// This is the client callback 
// this.map refers to the html tag in phoenix where the map will be rendered
Hooks.PhxHookGeoAssetMap = {
    mounted() {
        console.log("GeoAssetMap mounted");

        this.map = new GeoAssetMap(
            this.el, [68.2326783,14.5468427], event => {
                const geoassetId = event.target.options.geoassetId;
                this.pushEvent("marker-clicked", geoassetId, (reply, ref ) => {
                    this.scrollTo(reply.geoasset.id);
                });
            }
        )

        // When mounted, it sends a requests to the server
        // asking for the list of geoassets.
        this.pushEvent("get-geoassets", {}, (reply, ref) => {
            reply.geoassets.forEach(geoasset => {
                this.map.addMarker(geoasset)
            })
        })

        // The server requests to highlight a marker on the map.
        this.handleEvent("highlight-marker", geoasset => {
            this.map.highlightMarker(geoasset)
        })

        // The server request to add a marker on the map.
        this.handleEvent("add-marker", geoasset => {
            this.map.addMarker(geoasset);
            this.map.highlightMarker(geoasset);
            this.scrollTo(geoasset.id)
        })
    }
};

export default Hooks;
