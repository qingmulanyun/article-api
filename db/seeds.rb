# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

(1..5).map { |n|
  Article.create!(
    title: "title #{n}",
    body: "body #{n}",
    date: Date.current,
    tags: ["tag#{n}"]
  )
}

(6..10).map { |n|
  Article.create!(
    title: "title #{n}",
    body: "body #{n}",
    date: Date.yesterday,
    tags: ["tag#{n}"]
  )
}