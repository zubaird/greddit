class Comment < ActiveRecord::Base

belongs_to :post
belongs_to :user

has_many :responses, class_name: "Comment",
  foreign_key: "response_id"



validates :body, presence: true

end
