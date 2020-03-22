5.times do |n|
  name  = Faker::Name.name
  email = "bao#{n+1}@gmail.com"
  User.create(name:  name,
               email: email,
               password: "123456",
               password_confirmation: "123456",
               birthday: Time.zone.now,
               phone: "0388967331",
               skill: "Khong co ki nang chi",
               role: 2)
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

