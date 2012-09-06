var AppRouter = Backbone.Router.extend({
  routes : {
    "pages" : "getPages",
    "menus" : "getMenus",
    "dishes" : "getDishes"
  },
  
  pages: null,
  dishes: null,

  getPages : function() {
    if (this.dishes) {
      this.dishes.undelegateEvents();
    }
    this.pages = new PageListView({ el: $("#content")});
  },
  getDishes: function() {
    if (this.pages) {
      this.pages.undelegateEvents();
    }
    this.dishes = new DishListView({ el: $("#content")});
  }
  
  
});

$(document).ready(function(){
  $('#menu li').click(function(){
    $('#menu li').removeClass("active");
    $(this).addClass("active");
  });
  var app = new AppRouter();
  Backbone.history.start();
  app.navigate('pages',{trigger:true});
});


