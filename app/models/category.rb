#created on 29/nov/2016 by prateek darmwal
class Category < ActiveRecord::Base
  has_many :blogs
end
