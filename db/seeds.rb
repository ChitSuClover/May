User.create!(name: 'Ha Ha', email: "haha@email.com", password: "password",role: "user")
User.create!(name: 'User_Admin', email: "useradmin@email.com", password: "password",role: "admin")
User.create!(name: 'user3', email: "user3@email.com", password: "password",role: "user")
User.create!(name: 'user4', email: "user4@email.com", password: "password",role: "user")
User.create!(name: 'user5', email: "user5@email.com", password: "password",role: "user")

Task.create!(title: "title", content: "content", experied_at: "2021.06.30", status: "unstarted", pripority: "low", label_ids: 1)
Task.create!(title: "title2", content: "content2", experied_at: "2021.06.30", status: "in_progress", pripority: "low", label_ids: 2)
Task.create!(title: "title3", content: "content3", experied_at: "2021.06.30", status: "unstarted", pripority: "low", label_ids: 3)
Task.create!(title: "title4", content: "content4", experied_at: "2021.06.30", status: "in_progress", pripority: "low", label_ids: 4)

Label.create!(name: "PHP")
Label.create!(name: "Java")
Label.create!(name: "Ruby")
