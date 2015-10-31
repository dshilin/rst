require 'rails_helper'

RSpec.describe Offer, type: :model do
  it { should validate_presence_of :shop }
  it { should validate_presence_of :price }
  it { should validate_presence_of :url }
end
