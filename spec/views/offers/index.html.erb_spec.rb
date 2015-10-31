require 'rails_helper'

RSpec.describe "offers/index", type: :view do
  before(:each) do
    assign(:offers, [
      Offer.create!(
        :shop => "Shop",
        :price => "9.99",
        :url => "Url"
      ),
      Offer.create!(
        :shop => "Shop",
        :price => "9.99",
        :url => "Url"
      )
    ])
  end

  it "renders a list of offers" do
    render
    assert_select "tr>td", :text => "Shop".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
