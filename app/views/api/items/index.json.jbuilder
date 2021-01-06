# itemsコントローラーのindexアクションから送られてきた@random_itemsをjsonで返す
# axios.get('/api/items')を実行したときはここでjsonになった@random_itemsが返される
# ここにidを持ってきてなかったため、undefinedだった
json.array! @random_items, :id,:name, :image,:points,:competition_id