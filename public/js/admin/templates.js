var Templates = {
  tmpl_cache : {
    dish_tmpl: null,
    dish_view_tmpl: null
  }, 
  
  dish: function() {
    var tmpl = '<tr><td>{{id}}</td><td>{{title}}</td><td><button data-id="{{id}}" class="btn btn-small btn-primary edit-button"' 
    + ' type="button">Edit</button></td><td><button data-id="{{id}}" class="btn btn-small view-button" type="button">View</button></td></tr>';
    if (!this.tmpl_cache.dish_tmpl) {
      this.tmpl_cache.dish_tmpl = Handlebars.compile(tmpl);
    }
    return this.tmpl_cache.dish_tmpl;
  },
  dish_view: function(model) {
    var tmpl = "<div class='modal' role='dialog' aria-labelledby='modal-label' aria-hidden='true'>" 
    + "<div class='modal-header'><button type=\"button\" class=\"close\" data-dismiss=\"modal\" >×</button>"
    + "<h3 align='center'>{{title}}</h3></div>" 
    + "<div class='modal-body'><table class='table'><tr><td>Short Desc:</td><td>{{short_desc}}</td></tr><tr><td><h5>Text</h5></td><td>{{text}}"
    + "</td></tr></table></div><div class='modal-footer'><button class='btn' data-dismiss='modal'>Close</button></div></div>";
    if (!this.tmpl_cache.dish_view_tmpl) {
      this.tmpl_cache.dish_view_tmpl = Handlebars.compile(tmpl);
    }
    return this.tmpl_cache.dish_view_tmpl({title: model.get('title'), short_desc: model.get('short_desc'), text: model.get('text')});
  }
  
};
