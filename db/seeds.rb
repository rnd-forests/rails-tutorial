User.create!(name: 'Vinh Nguyen',
             email: 'ngocvinh.nnv@gmail.com',
             password: '123456789', password_confirmation: '123456789',
             admin: true, activated: true, activated_at: Time.zone.now)

User.create!(name: 'Hang Dang',
             email: 'hangdt.aa@gmail.com',
             password: '123456789', password_confirmation: '123456789',
             admin: true, activated: true, activated_at: Time.zone.now)

100.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@gmail.com"
    password = 'secretsecret'
    User.create!(name: name, email: email, password: password, password_confirmation: password,
                 activated: true, activated_at: Time.zone.now)
end

500.times {
    title = Faker::Name.title
    content = Faker::Lorem.paragraphs(5)
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

tags = %w(general java ruby python scala perl pascal php javascript xml ajax json)
tags.each do |tag|
    Tag.create!(name: tag)
end

articles = Article.all
tags_list = Tag.all
articles.each do |article|
    rand1 = Random.new.rand(2..Tag.all.count)
    num = Random.new.rand(5..10)
    tags = tags_list[1..rand1]
    tags.each do |tag|
        article.attach_tag(tag)
    end
    num.times do
        Comment.create!(article_id: article.id, user_id: Random.new.rand(1..User.all.count), body: Faker::Lorem.sentences(2))
    end
end

special_article = Article.create!(
    title: 'Laravel PHP Framework',
    content: "Value elegance, simplicity, and readability? You’ll fit right in. Laravel is designed for people just like you. If you need help getting started, check out Laracasts and our great documentation.
Whether you're a solo developer or a 20 person team, Laravel is a breath of fresh air. Keep everyone in sync using Laravel's database agnostic migrations and schema builder.
An amazing ORM, painless routing, powerful queue library, and simple authentication give you the tools you need for modern, maintainable PHP. We sweat the small stuff to help you deliver amazing applications.",
    user_id: 1)
special_article.attach_tag(Tag.find_by_name('php'))
20.times do
    Comment.create!(article_id: special_article.id, user_id: Random.new.rand(1..User.all.count), body: Faker::Lorem.sentences(2))
end