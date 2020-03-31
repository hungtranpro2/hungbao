Division.create!(name: "Project Department", is_project: true, image: "project.jpg")
Division.create!(name: "Design Department", image: "design.png")
Division.create!(name: "Android Department", image: "android.png")
Division.create!(name: "IOS Department", image: "ios.png")

10.times do |n|
  name  = Faker::Name.name
  email = "bao#{n+1}@gmail.com"
  User.create(name:  name,
               email: email,
               password: "123456",
               password_confirmation: "123456",
               birthday: Time.zone.now,
               phone: "0388967331",
               division_id: rand(Division.count),
               skill: "Khong co ki nang chi",
               role: 1)
end

3.times do |n|
  name  = Faker::Name.name
  ListMessage.create(name: name)
end

200.times do |n|
  content = "This is Message #{n+1}"

  Message.create(
    list_message_id: rand(ListMessage.count),
    user_id: rand(User.count),
    content: content
  )
end

