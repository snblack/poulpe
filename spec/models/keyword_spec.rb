require 'rails_helper'

RSpec.describe Keyword, type: :model do
  it { should have_many(:positions) }
  it { should have_many(:positions).dependent(:delete_all) }

  it { should belong_to(:product) }
  it { should validate_presence_of :title }
end
