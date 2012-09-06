var Dish = Backbone.Model.extend({
  initialize: function() {},
  url : '/admin/dishes'
});

var DishList = Backbone.Collection.extend({
  url : '/admin/dishes'
});

var DishView = Backbone.View.extend({
  template : Templates.dish(),

  render : function() {
    this.$el.html(this.template(this.model.toJSON()));
    return this;
  }
});

var DishListView = Backbone.View.extend({
  initialize : function(options) {
    this.collection = new DishList();
    this.collection.bind("reset", this.render, this);
    this.collection.bind("change", this.render, this);
    if (options && options.el) {
      this.el = options.el;
    }
    var self = this;
    this.collection.fetch({
      success : function() {
        self.render();

      }
    });
  },
  events : {
    "click .view-button" : "view",
    "click .edit-button" : "edit",
    "click .new-button"  : "new_dish"
    
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
    this.el.append(Templates.dish_view(model));
    this.showModal();

  },
  edit : function(e) {
    var id = $(e.currentTarget).data("id");
    console.log("edit event triggered - " + id);
    var dish = this.collection.get(id);
    dish.schema = {
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
      model : dish
    }).render();
    this.el.append(Templates.dish_edit(dish));
    $('.modal-body').append(form.el);
    this.showModal();
    $('#dish-save').click(function(e){
      form.commit();
      $('.modal').remove();
      $('.modal-backdrop').remove();
      dish.save();
    });
  },
  
  new_dish : function(e) {
    var id = $(e.currentTarget).data("id");
    console.log("edit event triggered - " + id);
    var dish = new Dish({title: "New Dish"});
    dish.schema = {
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
      model : dish
    }).render();
    this.el.append(Templates.dish_edit(dish));
    $('.modal-body').append(form.el);
    this.showModal();
    var collection = this.collection;
    $('#dish-save').click(function(e){
      form.commit();
      $('.modal').remove();
      $('.modal-backdrop').remove();
      dish.save();
      collection.fetch();
    });
  },

  render : function() {

    var self = this;
    this.$el.html("<h1>List of Dishes</h1><table id=\"dishes\" class=\"table\"><thead><tr><th>ID</th><th>Title</th><th></th></thead></table>");
    this.collection.each(function(model) {
      self.addOne(model);
    });
    $('#dishes').append("<p align'right'><button class='btn btn-small btn-primary new-button' type='button'>New Dish</button></p>");

  },
  addOne : function(the_model) {
    var view = new PageView({
      model : the_model
    });

    $('#dishes').append(view.render().$el.html());

  }
});
