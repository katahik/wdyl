# competitionsコントローラーのindexアクションから送られてきた配列をjsonにする
json.array! @competitions, :id,:name,:period_start,:period_end
