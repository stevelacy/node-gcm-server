$(document).ready(function() {

  var socket = io();
  mapLoad = 0;
  var marker;
  function initialize() {
    var mapOptions = {
      zoom: 10,
      center: new google.maps.LatLng(40.7903, -73.9597)
    };
    var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

    socket.on('gps', function(data){
      var myLatLng = new google.maps.LatLng(data.lat, data.lon);
      if (mapLoad === 0){
        map.setCenter(myLatLng);
        mapLoad = 1;
      }
      marker = new google.maps.Marker({
          position: myLatLng,
          map: map
      });
    });
    $('.clear').click(function(){
      marker.setMap(null);
    });
  }

  google.maps.event.addDomListener(window, 'load', initialize);

});
