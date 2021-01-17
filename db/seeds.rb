
User.create!(
    email: 'mail@gmail.com',
    username: 'foo',
    password: '00000000'
)

# competition作成

# competitionsページ作成用
Competition.create!(name:  "my favorite monster third",
                    period_start: "2021-1-11",
                    period_end:   "2021-1-18",
                    )
Competition.create!(name:  "my favorite monster second",
                    period_start: "2021-1-3",
                    period_end:   "2021-1-10",
                    )
Competition.create!(name:  "my favorite monster",
                    period_start: "2020-12-27",
                    period_end:   "2021-1-2",
                    )
Competition.create!(name:  "my favorite drink",
                    period_start: "2020-12-20",
                    period_end:   "2020-12-26",
                    )
Competition.create!(name:  "my favorite Sumo Wrestler",
                    period_start: "2020-12-13",
                    period_end:   "2020-12-19",
                    )
Competition.create!(name:  "my favorite movie",
                    period_start: "2020-12-06",
                    period_end:   "2020-12-12",
                    )
Competition.create!(name:  "my favorite food",
                    period_start: "2020-11-29",
                    period_end:   "2020-12-05",
                    )
Competition.create!(name:  "my favorite color",
                    period_start: "2020-11-22",
                    period_end:   "2020-11-28",
                    )
Competition.create!(name:  "my favorite book",
                    period_start: "2020-11-15",
                    period_end:   "2020-11-21",
                    )


# item作成

# top画面検証用
# 4枚の画像
4.times do |n|
    name  = "monster#{n+1}"
    image = "monster#{n+1}.jpeg"
    Item.create!(name:  name,
                 image: image,
                 points: 1,
                 competition_id: 1,
    )
end




# show画面検証用
4.times do |n|
    name  = "monster#{n+1}"
    image = "monster#{n+1}.jpeg"
    Item.create!(name:  name,
                 image: image,
                 points: 1,
                 competition_id: 2
    )
end
10.times do |n|
    name  = "drink#{n+1}"
    image = "drink_sample.jpeg"
    points = Faker:: Number.between(from: 1, to: 100)
    Item.create!(name:  name,
                 image: image,
                 points: points,
                 competition_id: 3
    )
end
10.times do |n|
    name  = "sumo_wrestler#{n+1}"
    image = "sumo_wrestler_sample.jpeg"
    points = Faker:: Number.between(from: 1, to: 100)
    Item.create!(name:  name,
                 image: image,
                 points: points,
                 competition_id: 4
    )
end
10.times do |n|
    name  = "movie#{n+1}"
    image = "movie_sample.jpeg"
    points = Faker:: Number.between(from: 1, to: 100)
    Item.create!(name:  name,
                 image: image,
                 points: points,
                 competition_id: 5
    )
end
10.times do |n|
    name  = "food#{n+1}"
    image = "food_sample.jpeg"
    points = Faker:: Number.between(from: 1, to: 100)
    Item.create!(name:  name,
                 image: image,
                 points: points,
                 competition_id: 6
    )
end
10.times do |n|
    name  = "color#{n+1}"
    image = "color_sample.jpeg"
    points = Faker:: Number.between(from: 1, to: 100)
    Item.create!(name:  name,
                 image: image,
                 points: points,
                 competition_id: 7
    )
end
10.times do |n|
    name  = "book#{n+1}"
    image = "book_sample.jpeg"
    points = Faker:: Number.between(from: 1, to: 100)
    Item.create!(name:  name,
                 image: image,
                 points: points,
                 competition_id: 8
    )
end

# session作成
5.times do |n|
    session_id  = "#{n+1}"
    data = "#{n+1}"
    Session.create!(session_id:  session_id,
                    data: data
    )
end

# itemに紐ついたchosenitemsテーブルを作成
# これでitemシーダーで作った、itemのidをchosenitemテーブルへ流し込める
# そうすることで、competition_idが取得できる
# session数が5つで、それぞれのsessionでitemを10個ランダムに選択する
5.times do |n|
    Item.order("RANDOM()").limit(10).each do |item|
        item.chosenitems.create!(
            session_id: "#{n+1}",
            item_id: rand(item.id)
        )
    end
end