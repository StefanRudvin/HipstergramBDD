class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  
  belongs_to :user
  
  validates :image, presence: true
  
  validates :user_id, presence: true
  
  has_attached_file :image, styles: { :medium => "640x" }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  
  #validates :comment, presence: true, length: { minimum: 1, maximum: 100 }
  
end
