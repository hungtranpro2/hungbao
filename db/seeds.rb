Division.create!(name: "Project Department", is_project: true, image: "project.png")
Division.create!(name: "Design Department", image: "design.jpg")
Division.create!(name: "Android Department", image: "android.png")
Division.create!(name: "IOS Department", image: "ios.png")


User.create!(name:  "GD Du AN",
               email: "bao0@gmail.com",
               password: "123456",
               password_confirmation: "123456",
               birthday: Faker::Date.birthday,
               phone: "0388967331",
               status: rand(0..2),
               division_id: 1,
               avatar: "avatar.png",
               skill: "Khong co ki nang chi",
               role: 1)

User.create!(name:  "GD Design",
               email: "bao1@gmail.com",
               password: "123456",
               password_confirmation: "123456",
               birthday: Faker::Date.birthday,
               phone: "0388967331",
               status: rand(0..2),
               division_id: 2,
               avatar: "avatar.png",
               skill: "Khong co ki nang chi",
               role: 1)

User.create!(name:  "GD Android",
               email: "bao2@gmail.com",
               password: "123456",
               password_confirmation: "123456",
               birthday: Faker::Date.birthday,
               phone: "0388967331",
               status: rand(0..2),
               division_id: 3,
               avatar: "avatar.png",
               skill: "Khong co ki nang chi",
               role: 1)

User.create!(name:  "GD IOS",
               email: "bao3@gmail.com",
               password: "123456",
               password_confirmation: "123456",
               birthday: Faker::Date.birthday,
               phone: "0388967331",
               status: rand(0..2),
               division_id: 4,
               avatar: "avatar.png",
               skill: "Khong co ki nang chi",
               role: 1)

5.times do |n|
  name  = Faker::Name.name
  email = "bao#{n +4}@gmail.com"
  User.create!(name:  name,
               email: email,
               password: "123456",
               password_confirmation: "123456",
               birthday: Faker::Date.birthday,
               phone: "0388967331",
               status: rand(0..2),
               division_id: 1,
               avatar: "avatar.png",
               skill: "Khong co ki nang chi",
               role: 0)
end

50.times do |n|
  name  = Faker::Name.name
  email = "bao#{n + 9}@gmail.com"
  User.create!(name:  name,
               email: email,
               password: "123456",
               password_confirmation: "123456",
               birthday: Faker::Date.birthday,
               phone: "0388967331",
               status: rand(0..2),
               division_id: rand(2..4),
               avatar: "avatar.png",
               skill: "Khong co ki nang chi",
               role: 0)
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

