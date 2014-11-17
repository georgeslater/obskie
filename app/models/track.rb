class Track < ActiveRecord::Base
  belongs_to :album
  has_many :ratings

  def avgUserRating
  	
  	return self.ratings.average('score')
  end

end
