require 'rails_helper'

RSpec.describe Position, type: :model do
  it { should belong_to(:keyword) }
  it { should validate_presence_of :value }
end
