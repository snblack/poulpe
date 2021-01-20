require 'rails_helper'

RSpec.describe Keyword, type: :model do
  it { should belong_to(:product) }
  it { should validate_presence_of :title }
end
