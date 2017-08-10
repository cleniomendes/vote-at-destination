require 'rails_helper'

RSpec.describe Destination, type: :model do
    subject { Destination.new(name: 'Rio de Janeiro') }
    
    it { should have_many(:votes) }
    
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    
    it "Count maximum quantity of records in table" do 
        ['São Paulo', 'Rio de Janeiro', 'Fernando de Noronha', 'Porto Alegre', 'Recife'].each do |c|
            create(:destination, :name => c)
        end
        
        expect {create(:destination, :name => 'Minas Gerais')}.to  raise_error(ActiveRecord::RecordInvalid,'Validation failed: Name Can not more than 5 records')
    end
end
