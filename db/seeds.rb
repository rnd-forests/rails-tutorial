User.create!(name: 'Vinh Nguyen',
             email: 'ngocvinh.nnv@gmail.com',
             password: '123456789', password_confirmation: '123456789',
             admin: true, activated: true, activated_at: Time.zone.now)

User.create!(name: 'Hang Dang',
             email: 'hangdt.aa@gmail.com',
             password: '123456789', password_confirmation: '123456789',
             admin: true, activated: true, activated_at: Time.zone.now)

50.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@gmail.com"
    password = 'secretsecret'
    User.create!(name: name, email: email, password: password, password_confirmation: password,
                 activated: true, activated_at: Time.zone.now)
end

300.times {
    title = Faker::Name.title
    content = Faker::Lorem.paragraphs(4)
    user_id = Random.new.rand(1..50)
    Article.create!(title: title, content: content, user_id: user_id)
}

users = User.all
user1 = users.first
user2 = users.second
user3 = users.third
following = users[2..35]
followers1 = users[3..20]
followers2 = users[1..30]
followers3 = users[1..10]
following.each { |followed| user1.follow(followed) }
followers1.each { |follower| follower.follow(user1) }
followers2.each { |follower| follower.follow(user2) }
followers3.each { |follower| follower.follow(user3) }

tags = %w(general personal social technology creative gaming programming)
tags.each do |tag|
    Tag.create!(name: tag)
end

articles = Article.all
tags_list = Tag.all
articles.each do |article|
    rand = Random.new.rand(2..Tag.all.count)
    tags = tags_list[1..rand]
    tags.each do |tag|
        article.attach_tag(tag)
    end
end