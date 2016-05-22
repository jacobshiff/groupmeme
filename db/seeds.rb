# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

doge = Meme.create({
  :image => File.new("#{Rails.root}/public/system/memes/images/seeds/doge.jpg")
})

pepe = Meme.create({
  :image => File.new("#{Rails.root}/public/system/memes/images/seeds/pepe.jpeg")
})

y_u_no = Meme.create({
  :image => File.new("#{Rails.root}/public/system/memes/images/seeds/yuno.jpg")
})

beef = Meme.create({
  :image => File.new("#{Rails.root}/public/system/memes/images/seeds/beef.jpg")
})

skeltal = Meme.create({
  :image => File.new("#{Rails.root}/public/system/memes/images/seeds/skeltal.png")
})

# doge = Meme.new
# doge.image = File.open('/Users/pulsifer/Development/projects/groupmeme/web-0416-01-project/public/system/memes/images/seeds/doge.jpg')
# doge.save
# trump = Meme.new
# trump.image = File.open('/Users/pulsifer/Development/projects/groupmeme/web-0416-01-project/public/system/memes/images/seeds/trump-pepe.jpg')
# beef = Meme.new
# beef.image = File.open('/Users/pulsifer/Development/projects/groupmeme/web-0416-01-project/public/system/memes/images/seeds/beef.jpg')

jacob = User.create(username: 'jacobshiff', email: 'jacob@flatironschool.com', password: 'password')
chris = User.create(username: 'xristo', email: 'chris@flatironschool.com', password: 'password')
rachel = User.create(username: 'rachelb', email: 'rachel@flatironschool.com', password: 'password')
kevin = User.create(username: 'kwebster2', email: 'kevin@flatironschool.com', password: 'password')

doge.creator = rachel
pepe.creator = rachel
y_u_no.creator = chris
beef.creator = chris
skeltal.creator = kevin

doge.save
pepe.save
y_u_no.save
beef.save
skeltal.save

flatiron = Group.create(title: "Flatiron School")
google = Group.create(title: "Google")
delta_nu = Group.create(title: "Delta Nu Sorority")
my_friends = Group.create(title: "Friends")

flatiron.group_slug = "flatiron-school"
google.group_slug = "google"
delta_nu.group_slug = "delta-nu"
my_friends.group_slug = "my-friends"

flatiron.group_creator = chris
flatiron.save
google.group_creator = jacob
google.save
delta_nu.group_creator = rachel
delta_nu.save
my_friends.group_creator = rachel
my_friends.save

comment_1 = Comment.create(content: 'Lollllzzzzz')
comment_2 = Comment.create(content: 'This is amazing')
comment_3 = Comment.create(content: 'Ron Paul 2012')
comment_4 = Comment.create(content: 'What is this meme?')
comment_5 = Comment.create(content: 'Haahhahaah. Amazing')

comment_1.user = jacob
comment_1.meme = doge
comment_2.user = jacob
comment_2.meme = pepe
comment_3.user = chris
comment_3.meme = doge
comment_4.user = jacob
comment_4.meme = beef
comment_5.user = jacob
comment_5.meme = doge

comment_1.save
comment_2.save
comment_3.save
comment_4.save
comment_5.save

like_1 = Reaction.create(reaction_type: 'like')
like_2 = Reaction.create(reaction_type: 'like')
like_3 = Reaction.create(reaction_type: 'like')
dislike_1 = Reaction.create(reaction_type: 'dislike')
dislike_2 = Reaction.create(reaction_type: 'dislike')

like_1.user = rachel
like_1.meme = doge
like_2.user = chris
like_2.meme = doge
like_3.user = rachel
like_3.meme = pepe
dislike_1.user = jacob
dislike_1.meme = pepe
dislike_2.user = chris
dislike_2.meme = beef

like_1.save
like_2.save
like_3.save
dislike_1.save
dislike_2.save

ping_pong = Tag.create(name: 'Ping Pong')
doge.tags << ping_pong
pepe.tags << ping_pong
beef.tags << ping_pong
javascript = Tag.create(name: 'JavaScript')
y_u_no.tags << javascript
ruby = Tag.create(name: 'Ruby')
beef.tags << ruby
doge.tags << ruby
lunch = Tag.create(name: 'Lunch')
pepe.tags << lunch

#associate all group-specific objects with their group
doge.group = flatiron
pepe.group = flatiron
y_u_no.group = flatiron
beef.group = flatiron
skeltal.group = google

doge.save
pepe.save
y_u_no.save
beef.save
skeltal.save

comment_1.group = flatiron
comment_2.group = flatiron
comment_3.group = flatiron
comment_4.group = flatiron
comment_5.group = flatiron

comment_1.save
comment_2.save
comment_3.save
comment_4.save
comment_5.save

like_1.group = flatiron
like_2.group = flatiron
like_3.group = flatiron
dislike_1.group = flatiron
dislike_2.group = flatiron

like_1.save
like_2.save
like_3.save
dislike_1.save
dislike_2.save

##ADD MEMBERSHIPS
membership_1 = Membership.create(group_id: 1, user_id: 1, user_type: 'admin')
membership_2 = Membership.create(group_id: 1, user_id: 2, user_type: 'member')
membership_3 = Membership.create(group_id: 1, user_id: 3, user_type: 'member')

##ADD INVITES
invitation_1 = Invite.create(sender_id: 1, recipient_email: 'bob@bob.com', token: 'cheese')
invitation_2 = Invite.create(sender_id: 2, recipient_email: 'memelover@memes.net', token: '12345')


# create_table "comments", force: :cascade do |t|
#     t.integer  "user_id"
#     t.integer  "meme_id"
#     t.text     "content"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#   end

#   create_table "groups", force: :cascade do |t|
#     t.string   "title"
#     t.integer  "group_creator_id"
#     t.datetime "created_at",       null: false
#     t.datetime "updated_at",       null: false
#   end

#   create_table "invites", force: :cascade do |t|
#     t.integer  "inviter_id"
#     t.integer  "invitee_id"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#   end

#   create_table "memberships", force: :cascade do |t|
#     t.integer  "user_id"
#     t.integer  "group_id"
#     t.string   "user_type"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#   end

#   create_table "meme_tags", force: :cascade do |t|
#     t.integer  "tag_id"
#     t.integer  "meme_id"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#   end

#   create_table "memes", force: :cascade do |t|
#     t.string   "file_name"
#     t.integer  "creator_id"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#   end

#   create_table "reactions", force: :cascade do |t|
#     t.integer  "meme_id"
#     t.integer  "user_id"
#     t.string   "type"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#   end

#   create_table "tags", force: :cascade do |t|
#     t.string   "name"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#   end

#   create_table "users", force: :cascade do |t|
#     t.string   "username"
#     t.string   "email"
#     t.string   "password_digest"
#     t.datetime "created_at",      null: false
#     t.datetime "updated_at",      null: false
#   end
