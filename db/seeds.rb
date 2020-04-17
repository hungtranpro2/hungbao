Division.create!(name: "Project Department", is_project: true, image: "project.jpg")
Division.create!(name: "Design Department", image: "design.png")
Division.create!(name: "Android Department", image: "android.png")
Division.create!(name: "IOS Department", image: "ios.png")

list = ListMessage.create!(name: "MyChat", type_mes: 2)

user1 = User.create!(name:  "HR",
               email: "hung@gmail.com",
               password: "123456",
               password_confirmation: "123456",
               birthday: Faker::Date.birthday,
               phone: "0388967331",
               division_id: 4,
               skill: "Khong co ki nang chi",
               role: 2)

Message.create!(content: "Hi #{user1.name}", list_message_id: list.id, user_id: user1.id)

user2 = User.create!(name:  "GD Du AN",
               email: "bao0@gmail.com",
               password: "123456",
               password_confirmation: "123456",
               birthday: Faker::Date.birthday,
               phone: "0388967331",
               division_id: 1,
               avatar: "avatar.png",
               skill: "Khong co ki nang chi",
               role: 1)

Message.create!(content: "Hi #{user2.name}", list_message_id: list.id, user_id: user2.id)

user3 = User.create!(name:  "GD Design",
               email: "bao1@gmail.com",
               password: "123456",
               password_confirmation: "123456",
               birthday: Faker::Date.birthday,
               phone: "0388967331",
               division_id: 2,
               avatar: "avatar.png",
               skill: "Khong co ki nang chi",
               role: 1)

Message.create!(content: "Hi #{user3.name}", list_message_id: list.id, user_id: user3.id)


user4 = User.create!(name:  "GD Android",
               email: "bao2@gmail.com",
               password: "123456",
               password_confirmation: "123456",
               birthday: Faker::Date.birthday,
               phone: "0388967331",
               division_id: 3,
               avatar: "avatar.png",
               skill: "Khong co ki nang chi",
               role: 1)

Message.create!(content: "Hi #{user4.name}", list_message_id: list.id, user_id: user4.id)


user5 = User.create!(name:  "GD IOS",
               email: "bao3@gmail.com",
               password: "123456",
               password_confirmation: "123456",
               birthday: Faker::Date.birthday,
               phone: "0388967331",
               division_id: 4,
               avatar: "avatar.png",
               skill: "Khong co ki nang chi",
               role: 1)

Message.create!(content: "Hi #{user5.name}", list_message_id: list.id, user_id: user5.id)

5.times do |n|
  name  = Faker::Name.name
  email = "bao#{n +4}@gmail.com"
  userx = User.create!(name:  name,
               email: email,
               password: "123456",
               password_confirmation: "123456",
               birthday: Faker::Date.birthday,
               phone: "0388967331",
               division_id: 1,
               avatar: "avatar.png",
               skill: "Khong co ki nang chi",
               role: 0)
  Message.create!(content: "Hi #{userx.name}", list_message_id: list.id, user_id: userx.id)
end

50.times do |n|
  name  = Faker::Name.name
  email = "bao#{n + 9}@gmail.com"
  usery = User.create!(name:  name,
           email: email,
           password: "123456",
           password_confirmation: "123456",
           birthday: Faker::Date.birthday,
           phone: "0388967331",
           division_id: rand(2..4),
           avatar: "avatar.png",
           skill: "Khong co ki nang chi",
           role: 0)
  Message.create!(content: "Hi #{usery.name}", list_message_id: list.id, user_id: usery.id)
end

# 3.times do |n|
#   name  = Faker::Name.name
#   ListMessage.create(name: name)
# end

# 200.times do |n|
#   content = "This is Message #{n+1}"

#   Message.create(
#     list_message_id: rand(ListMessage.count),
#     user_id: rand(0..(User.count-1)),
#     content: content
#   )
# end

