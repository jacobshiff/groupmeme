class Reaction < ActiveRecord::Base
  #relationships here
  belongs_to :meme
  belongs_to :user
end
