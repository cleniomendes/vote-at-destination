require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:destination) }
  it { should belong_to(:user) }
end
