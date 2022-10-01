
import GeoAssetMap from "./geo-asset-map"
import DateTimePicker from "./datetime-picker"

let Hooks = {};

Hooks.PhxHookDatePicker = {
    mounted(){
        console.log("Flatpickr mounted");
    
        this.datepicker = new DateTimePicker(this.el);
    },
    
    destroyed() {
        console.log("Destroyed", this)
        // this.datepicker.destroy()
    }
}

// This is the client callback 
// this.map refers to the html tag in phoenix where the map will be rendered
Hooks.PhxHookGeoAssetMap = {
    mounted() {
        console.log("GeoAssetMap mounted");

        this.map = new GeoAssetMap(
            this.el, [68.2326783, 14.5468427],
            (event, action) => {
                switch (action) {
                    case "selected-marker": {
                        console.log("selected-marker:" + event.latlng)
                        const geoassetId = event.target.options.geoassetId;
                        this.pushEvent("marker-clicked", geoassetId);
                        break;
                    }
                    case "right-click": {
                        console.log("dropped-new-marker:" + event.latlng)
                        this.pushEvent("dropped-new-marker", event.latlng, (reply, ref) => {
                            if(reply.geoasset == null){
                                // failed to store this new marker on the DB
                                remove(event);
                            }
                            else{
                                this.map.addMarker(reply.geoasset);
                            }
                        })
                        break;
                    }
                }
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
