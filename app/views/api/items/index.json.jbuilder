# itemsコントローラーのindexアクションから送られてきた@random_itemsをjsonで返す
# axios.get('/api/items')を実行したときはここでjsonになった@random_itemsが返される
json.array! @random_items, :name, :image,:points,:competition_id