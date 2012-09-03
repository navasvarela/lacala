var Templates = {
  tmpl_cache : {
    dish_tmpl: null,
    page_tmpl: null
  }, 
  
  dish: function() {
    var tmpl = '<tr><td>{{id}}</td><td>{{title}}</td><td><button data-id="{{id}}" class="btn btn-small btn-primary edit-button"' 
    + ' type="button">Edit</button></td><td><button data-id="{{id}" class="btn btn-small view-button" type="button">View</button></td></tr>';
    if (!tmpl_cache.dish_tmpl) {
      tmpl_cache.dish_tmpl = Handlebars.compile(tmpl);
    }
    return tmpl_cache.dish_tmpl;
  }
};
