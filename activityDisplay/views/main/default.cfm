<cfoutput>
    <cfset rc.pc.addToHTMLHeadQueue('headQueue.cfm')>

    <cfset data = rc.activity />

        <div class="row">
			<div id="map-canvas"></div>
		</div>
        <script>
                function initialize() {
                    var mapOptions = {
                        zoom: 3,
                        center: new google.maps.LatLng(0, -180),
                        mapTypeId: google.maps.MapTypeId.TERRAIN
                      };

                    var map = new google.maps.Map(document.getElementById('map-canvas'),
                      mapOptions);

                    var decodedPolyline = google.maps.geometry.encoding.decodePath('#replace(data.map_summary_polyline, "\", "\\","all")#');
                    // alert(decodedPolyline);
                    var track = new google.maps.Polyline({
                        path: decodedPolyline,
                        geodesic: true,
                        strokeColor: '##FF0000',
                        strokeOpacity: 1.0,
                        strokeWeight: 2
                    });

                    track.setMap(map);

                    //Set bounds based on polyline
                    var bounds = new google.maps.LatLngBounds();
                    for (var i = 0; i < decodedPolyline.length; i++) {
                        bounds.extend(decodedPolyline[i]);
                    }
                    // zoom and center map around bounds
                    map.fitBounds(bounds);
                }

                google.maps.event.addDomListener(window, 'load', initialize);


            </script>
</cfoutput>
