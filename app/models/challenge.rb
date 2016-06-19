class Challenge < ActiveRecord::Base
	has_many :user_challenges, dependent: :destroy
	has_many :users, :through => :user_challenges
end
