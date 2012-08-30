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
      type: 'TextArea',
      validators : ['required']
    }
  }
});


var Pages = Backbone.Collection.extend({
  model: Page,
  url: '/admin/pages'
});

var PagesRouter = Backbone.Router.extend({
  routes: {
    "pages/:id" : "getPage"
  },
  
  getPage: function(id) {
    console.log('Retrieve page with ID: '+id);
    var page = Pages.get(id); 
  }
  
});
