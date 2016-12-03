#created on 29/nov/2016 by prateek darmwal

class BlogTag < ActiveRecord::Base
  belongs_to :blog
  belongs_to :tag
end
