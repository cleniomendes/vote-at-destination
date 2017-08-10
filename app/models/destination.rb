class Destination < ApplicationRecord
    has_many :votes
    
    validates_presence_of :name
    validates_uniqueness_of :name
    validate :count_total_records_on_table
    
    def count_total_records_on_table
        Destination.transaction do 
            if Destination.count >= 5
                self.errors.add(:name, "Can not more than 5 records")
            end
        end
    end
end
