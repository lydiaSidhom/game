var app = window.app = {};

app.BusStops = function(elm) {
  this._input = elm;
  this._initAutocomplete();
};

app.BusStops.prototype = {
  _initAutocomplete: function() {
    this._input
      .autocomplete({
        source: '/bus_stops/search.json',
        appendTo: '#bus-stops-search-results',
        select: $.proxy(this._select, this)
      })
      .autocomplete('instance')._renderItem = $.proxy(this._render, this);
  },
  _select: function(e, ui) {
    this._input.val(ui.item.name);
    return false;
  },
  _render: function(ul, item) {
    var markup = [
      '<span class="name">' + item.name + '</span>'
    ];
    return $('<li>')
      .append(markup.join(''))
      .appendTo(ul);
  }
};