$(document).ready(function(){
  $('#menu li').click(function(){
    $('#menu li').removeClass("active");
    $(this).addClass("active");
  });
});

var AppRouter = Backbone.Router.extend({
  routes : {
    "pages/" : "getPages",
    "menus/" : "getMenus",
    "dishes/" : "getDishes"
  },

  getPages : function() {
    new PageListView({ el: $("#content")});
  }
});
