require 'rails_helper'

RSpec.describe "offers/show", type: :view do
  before(:each) do
    @offer = assign(:offer, Offer.create!(
      :shop => "Shop",
      :price => "9.99",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Shop/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Url/)
  end
end
