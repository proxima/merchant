var sector_print_callback = function(sector) {
  if(sector != null) {
    console.log(sector);
  }
}

var sector_loader = {

  sectors : new Array(),

  fetch_sector : function(id, sectors_array, cb) {
    if(sectors_array.length < id && sectors_array[id] != null) {
      cb(sectors_array[id]);
    } else {
      $.get("sectors/" + id + ".json", function(data, status) {
        if(status == "success") {
          var sector = data.sector;
          console.log(sector);
          sectors_array[sector.id] = {};
          sectors_array[sector.id] = sector;
          cb(sectors_array[sector.id]);
        } else {
          cb(null);
        }
      });
    }
  }
};

var fetch_sector = function(id, cb) {
  sector_loader.fetch_sector(id, sector_loader.sectors, cb);
}

