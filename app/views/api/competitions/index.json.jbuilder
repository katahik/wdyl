# competitionsコントローラーのindexアクションから送られてきた配列をjsonにする
json.array! @competitions, :name,:period_start,:period_end
