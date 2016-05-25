# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

#### CREATE USERS
## Return to add in avatar files
jacob = User.create({
  :username =>'jacobshiff',
  :email => 'shiffjacob@gmail.com',
  :password => 'password',
  :avatar => File.new("#{Rails.root}/public/seed-images/avatars/jacob-shiff.jpg")
  }
)

chris = User.create({
  :username =>'xristo',
  :email => 'chris@flatironschool.com',
  :password => 'password',
  :avatar => File.new("#{Rails.root}/public/seed-images/avatars/xristo.jpg")
  }
)

rachel = User.create({
  :username =>'rachelb',
  :email => 'rnbronstein@gmail.com',
  :password => 'password',
  :avatar => File.new("#{Rails.root}/public/seed-images/avatars/rachelb.jpg")
  }
)

kevin = User.create({
  :username =>'kwebster2',
  :email => 'kevin.webster@flatironschool.com',
  :password => 'password',
  :avatar => File.new("#{Rails.root}/public/seed-images/avatars/kevin.webster.jpg")
  }
)



# chris = User.create(username: 'xristo', email: 'chris@flatironschool.com', password: 'password')
# rachel = User.create(username: 'rachelb', email: 'rnbronstein@gmail.com', password: 'password')
# kevin = User.create(username: 'kwebster2', email: 'kevin.webster@flatironschool.com', password: 'password')

#### CREATE GROUPS
flatiron = Group.create(title: "Flatiron School", group_slug: "flatiron-school", group_creator: jacob)
barnard = Group.create(title: "Barnard", group_slug: "barnard", group_creator: rachel)
jpmorgan = Group.create(title: "JPMorgan", group_slug: "jpmorgan", group_creator: kevin)

#### CREATE MEMBERSHIPS
Membership.create(group: flatiron, user: jacob, user_type: 'admin')
Membership.create(group: flatiron, user: rachel, user_type: 'admin')
Membership.create(group: flatiron, user: kevin, user_type: 'member')
Membership.create(group: barnard, user: rachel, user_type: 'admin')
Membership.create(group: jpmorgan, user: kevin, user_type: 'admin')
Membership.create(group: jpmorgan, user: chris, user_type: 'member')

#### CREATE MEMES
chewy = Meme.create({
    :image => File.new("#{Rails.root}/public/seed-images/chewy-rails.gif"),
    :creator => rachel,
    :group => flatiron
  }
)

paired_programming = Meme.create({
    :image => File.new("#{Rails.root}/public/seed-images/paired_programming.gif"),
    :creator => jacob,
    :group => flatiron,
    :title => "When you've been in project mode for way too long"
  }
)

penguin_programming = Meme.create({
    :image => File.new("#{Rails.root}/public/seed-images/penguin_programming.jpg"),
    :creator => kevin,
    :group => flatiron
  }
)

##Remove group ID from reactions, because it has it through images
#### CREATE REACTIONS
Reaction.create(meme: chewy, user: chris)
Reaction.create(meme: chewy, user: jacob)
Reaction.create(meme: paired_programming, user: rachel)
Reaction.create(meme: penguin_programming, user: rachel)
Reaction.create(meme: penguin_programming, user: jacob)


#### CREATE COMMENTS
Comment.create(content: 'Lollllzzzzz', user: chris, meme: chewy)
Comment.create(content: 'Ron Paul 2012', user: kevin, meme: chewy)
Comment.create(content: 'What is this meme?', user: chris, meme: chewy)
Comment.create(content: 'Too true', user: rachel, meme: paired_programming)
Comment.create(content: 'Thanks!', user: jacob, meme: paired_programming)
Comment.create(content: 'Me last night', user: chris, meme: penguin_programming)


#### CREATE TAGS
bangarang = Tag.create(name: 'Bangarangs', group: flatiron, slug: 'bangarang')
random = Tag.create(name: 'Random', group: flatiron, slug: 'random')
rails = Tag.create(name: 'Rails', group: flatiron, slug: 'rails')


#### CREATE MEME_TAG_JOIN
MemeTag.create(tag: bangarang, meme: chewy)
MemeTag.create(tag: bangarang, meme: paired_programming)
MemeTag.create(tag: bangarang, meme: penguin_programming)
MemeTag.create(tag: random, meme: chewy)
MemeTag.create(tag: rails, meme: chewy)

