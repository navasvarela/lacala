var Page = Backbone.Model.extend({

  schema : {
    section : {
      type : 'Text'
    },
    title : {
      type : 'Text',
      validators : ['required']
    },
    text : {
      type : 'TextArea',
      validators : ['required']
    }
  }
});

var PageList = Backbone.Collection.extend({
  url : '/admin/pages'
});

var PagesRouter = Backbone.Router.extend({
  routes : {
    "pages/:id" : "getPage"
  },

  getPage : function(id) {
    console.log('Retrieve page with ID: ' + id);
    var page = Pages.get(id);
  }
});

var PageView = Backbone.View.extend({
  template : _.template('<tr><td><%= id %></td><td><%= title %></td><td><button data-id="<%= id %>" class="btn btn-small btn-primary edit-button"'
  +' type="button">Edit</button></td><td><button data-id="<%= id %>" class="btn btn-small view-button" type="button">View</button></td></tr>'),
  events: {
    "click button.view-button" : "view",
    "click button.edit-button" : "edit"
  },
  view: function(e) {
    console.log("view event triggered - "+$(e.currentTarget).data("id"));
  },
  edit: function(e) {
    console.log("edit event triggered - "+$(e.currentTarget).data("id"));
  },
  render : function() {
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }
});

var PageListView = Backbone.View.extend({
  initialize : function(options) {
    this.collection = new PageList();
    this.collection.bind("reset", this.render, this);
    this.collection.bind("change", this.render, this);
    this.el = options.el;
    var self = this
    this.collection.fetch({
      success : function() {
        self.render();

      }
    });
  },
  render : function() {

    var self = this;
    this.el.html("<h1>List of Pages</h1><table id=\"pages\" class=\"table\"><thead><tr><th>ID</th><th>Title</th><th></th></thead></table>");
    this.collection.each(function(model) {
      self.addOne(model);
    });
   
  },
  addOne : function(the_model) {
    var view = new PageView({
      model : the_model
    });

    $('#pages').append(view.render().$el.html());
    

  }
});
