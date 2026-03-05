module ApplicationHelper
  POST_CATEGORY_LABELS = {
    "anime" => "アニメ",
    "movie" => "映画",
    "music" => "音楽",
    "person" => "人物",
    "other" => "その他"
  }.freeze

  def post_category_label(category_key)
    POST_CATEGORY_LABELS[category_key.to_s] || category_key.to_s
  end
end
