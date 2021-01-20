require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should have_many(:keywords) }
  it { should have_many(:keywords).dependent(:delete_all) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :asin }
  it { should validate_presence_of :image }

  it { should allow_value("https://www.google.com/").for(:image) }
  it { should_not allow_value("foo").for(:image) }
end
