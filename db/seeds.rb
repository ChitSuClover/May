User.create!(name: 'Ha Ha', email: "u1@email.com", password: "password",role: "user")
User.create!(name: 'Admin', email: "admin@email.com", password: "password",role: "admin")
User.create!(name: 'user3', email: "u3@email.com", password: "password",role: "user")
User.create!(name: 'user4', email: "u4@email.com", password: "password",role: "user")
User.create!(name: 'user5', email: "u5@email.com", password: "password",role: "user")

Task.create!(title: "title", content: "content", expired_at: "2021.06.30", status: "unstarted", pripority: "low", user_id:1, label_ids: 1)
Task.create!(title: "title2", content: "content2", expired_at: "2021.06.30", status: "in_progress", pripority: "low", user_id:1, label_ids: 2)
Task.create!(title: "title3", content: "content3", expired_at: "2021.06.30", status: "unstarted", pripority: "low", user_id:1, label_ids: 3)
Task.create!(title: "title4", content: "content4", expired_at: "2021.06.30", status: "in_progress", pripority: "low", user_id:1, label_ids: 3)

Label.create!(name: "Apple")
Label.create!(name: "Orange")
Label.create!(name: "Papaya")
