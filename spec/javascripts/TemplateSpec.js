describe('Templates', function() {
  it('should be able to generate dishes template', function() {
    var expected = '<tr><td>001</td><td>Salmorejo</td><td><button data-id="001" class="btn btn-small btn-primary edit-button"' + ' type="button">Edit</button></td><td><button data-id="001" class="btn btn-small view-button" type="button">View</button></td></tr>';

    var actual = Templates.dish()({
      id : "001",
      title : "Salmorejo"
    });
    jasmine.log("actual: " + actual);
    expect(actual).toEqual(expected);
  });
  it('should be able to generate dish view template', function() {
    var expected = "<div class='modal' role='dialog' aria-labelledby='modal-label' aria-hidden='true'>" + "<div class='modal-header'><button type=\"button\" class=\"close\" data-dismiss=\"modal\" >×</button>" + "<h3 align='center'>Salmorejo</h3></div>" + "<div class='modal-body'><table class='table'><tr><td>Short Desc:</td><td>Short Description</td></tr><tr><td><h5>Text</h5></td><td>This is the text" + "</td></tr></table></div><div class='modal-footer'><button class='btn' data-dismiss='modal'>Close</button></div></div>";

    var dish = new Dish({
      title : "Salmorejo",
      short_desc : "Short Description",
      text : "This is the text"

    });
    var actual = Templates.dish_view(dish);
    jasmine.log("actual: " + actual);
    expect(actual).toEqual(expected);
  });
});
