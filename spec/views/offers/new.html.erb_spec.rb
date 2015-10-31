require 'rails_helper'

RSpec.describe "offers/new", type: :view do
  before(:each) do
    assign(:offer, Offer.new(
      :shop => "MyString",
      :price => "9.99",
      :url => "MyString"
    ))
  end

  it "renders new offer form" do
    render

    assert_select "form[action=?][method=?]", offers_path, "post" do

      assert_select "input#offer_shop[name=?]", "offer[shop]"

      assert_select "input#offer_price[name=?]", "offer[price]"

      assert_select "input#offer_url[name=?]", "offer[url]"
    end
  end
end
