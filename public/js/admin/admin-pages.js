var Page = Backbone.Model.extend({

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
  template : _.template('<tr><td><%= id %></td><td><%= title %></td><td><button data-id="<%= id %>" class="btn btn-small btn-primary edit-button"' + ' type="button">Edit</button></td><td><button data-id="<%= id %>" class="btn btn-small view-button" type="button">View</button></td></tr>'),

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
  events : {
    "click .view-button" : "view",
    "click .edit-button" : "edit"
  },
  showModal : function() {
    $('.modal').modal('show');
    $('button.close, .modal button.btn').click(function() {
      $('.modal').remove();
      $('.modal-backdrop').remove();
    });
  },
  view : function(e) {
    var id = $(e.currentTarget).data("id");
    console.log("view event triggered - " + id);
    var model = this.collection.get(id);
    this.el.append("<div class='modal' role='dialog' aria-labelledby='modal-label' aria-hidden='true'>" + "<div class='modal-header'><button type=\"button\" class=\"close\" data-dismiss=\"modal\" >×</button><h3 align='center'>" + model.get('title') + "</h3></div>" + "<div class='modal-body'><table class='table'><tr><td><h5>Text</h5></td><td>" + model.get('text') + "</td></tr></table></div><div class='modal-footer'><button class='btn' data-dismiss='modal'>Close</button></div></div>");
    this.showModal();

  },
  edit : function(e) {
    var id = $(e.currentTarget).data("id");
    console.log("edit event triggered - " + id);
    var page = this.collection.get(id);
    page.schema = {
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

    };
    var form = new Backbone.Form({
      model : page
    }).render();
    this.el.append("<div class='modal' role='dialog' aria-labelledby='modal-label' aria-hidden='true'>" 
    + "<div class='modal-header'><button type=\"button\" class=\"close\" data-dismiss=\"modal\" >×</button><h3 align='center'>" + page.get('title') 
    + "</h3></div>" + "<div class='modal-body'></div><div class='modal-footer'> <button id='page-save' class='btn btn-primary'>Save changes</button><button class='btn' data-dismiss='modal'>Cancel</button></div></div>");
    $('.modal-body').append(form.el);
    this.showModal();
    $('#page-save').click(function(e){
      form.commit();
      $('.modal').remove();
      $('.modal-backdrop').remove();
      page.save();
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
