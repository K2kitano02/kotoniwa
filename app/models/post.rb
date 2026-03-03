class Post < ApplicationRecord
  belongs_to :user

  #種類を数値ではなく名前で扱う
  enum :category, {  anime: 0, movie: 1, music: 2, person: 3, other: 4 }

  validates :body, presence: true, length: { maximum: 2000 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :work_name, presence: true, length: { maximum: 255 }

  #公開されている投稿だけを取りたい時に使う
  scope :public_post, -> { where(is_public: true) }

end
