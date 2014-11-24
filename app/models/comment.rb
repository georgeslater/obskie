class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :album, counter_cache: true
end
