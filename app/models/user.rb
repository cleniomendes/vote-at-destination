class User < ApplicationRecord
    has_many :votes
    
    validates_presence_of :name

    validates_presence_of :email
    validates_uniqueness_of :email
    validates_format_of :email, :with => Devise::email_regexp
end
