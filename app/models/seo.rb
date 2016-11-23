class Seo < ActiveRecord::Base
  #sitemappable
  #scope mostrecent to retrieve latest 5 websites checked for validations
  scope :most_recent, -> {order(id: :desc).first(5)}
end
