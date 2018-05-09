var _sc_unitDetails_GET = (function() {
  function _sc_unitDetails_GET (data) {
    this.data = data;
    this.latLong = {lat: data.lat, lng: data.long};

    this.div = document.createElement('div');

    this.header = document.createElement('h2');
    this.header.innerHTML = data.name;

    this.paragraph = document.createElement("p");
    this.paragraph.innerHTML = data.description;

    this.mapDiv = document.createElement('div');
    this.mapDiv.style = "width: 100%; height: 80%;"

    this.div.appendChild(this.header);
    this.div.appendChild(this.paragraph);
    this.div.appendChild(this.mapDiv);
    this.loadMap();
  }

  _sc_unitDetails_GET.prototype.loadMap = function() {
    const self = this;
    self.map = new google.maps.Map(self.mapDiv, {
      zoom: 12,
      center: self.latLong
    });

    marker = new google.maps.Marker({
      position: self.latLong,
      map: self.map,
      title: self.data.name
    });
  }

  return _sc_unitDetails_GET;
})();

function _sc_getUnitDetails(data) {
  if(data == undefined) {
    throw new Error('Request to get data returned nothing');
  }
  return _sc_loadJavaScript('https://maps.googleapis.com/maps/api/js?key=AIzaSyBzDdYK1oag2pqwqZNBvQ6r2i4VCbQUi5E&libraries=visualization,geometry')
  .then(() => {
    return Promise.resolve(new _sc_unitDetails_GET(data).div);
  });
}
