require File.dirname(__FILE__) + '/../../app'

describe "Admin Routes" do
  
  it "should get all the pages" do
    visit '/admin/pages'
    print response.body
    response.should contain "Masterchef"
  end
end
