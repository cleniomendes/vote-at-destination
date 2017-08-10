require 'rails_helper'

RSpec.describe User, type: :model do
    it { should have_many(:votes) }
    
    it { should validate_presence_of(:name) }
    
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should allow_value("clenio.si@gmail.com").for(:email) }
    it { should_not allow_value("cl.").for(:email) }
end
