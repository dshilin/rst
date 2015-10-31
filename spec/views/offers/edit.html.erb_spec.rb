require 'rails_helper'

RSpec.describe "offers/edit", type: :view do
  before(:each) do
    @offer = assign(:offer, Offer.create!(
      :shop => "MyString",
      :price => "9.99",
      :url => "MyString"
    ))
  end

  it "renders the edit offer form" do
    render

    assert_select "form[action=?][method=?]", offer_path(@offer), "post" do

      assert_select "input#offer_shop[name=?]", "offer[shop]"

      assert_select "input#offer_price[name=?]", "offer[price]"

      assert_select "input#offer_url[name=?]", "offer[url]"
    end
  end
end
