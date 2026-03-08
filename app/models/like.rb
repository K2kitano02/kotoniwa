class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # 1人が1つの投稿に対して1回しかいいねできないようにする
  validates :user_id, uniqueness: { scope: :post_id }
end
