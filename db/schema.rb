# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160522211032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "meme_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id"
  end

  add_index "comments", ["group_id"], name: "index_comments_on_group_id", using: :btree
  add_index "comments", ["meme_id"], name: "index_comments_on_meme_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "title"
    t.integer  "group_creator_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "group_slug"
  end

  add_index "groups", ["group_creator_id"], name: "index_groups_on_group_creator_id", using: :btree
  add_index "groups", ["group_slug"], name: "index_groups_on_group_slug", using: :btree

  create_table "invites", force: :cascade do |t|
    t.integer  "sender_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "group_id"
    t.string   "recipient_email"
    t.string   "token"
    t.integer  "recipient_id"
  end

  add_index "invites", ["group_id"], name: "index_invites_on_group_id", using: :btree
  add_index "invites", ["recipient_id"], name: "index_invites_on_recipient_id", using: :btree
  add_index "invites", ["sender_id"], name: "index_invites_on_sender_id", using: :btree

  create_table "memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "user_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "memberships", ["group_id"], name: "index_memberships_on_group_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "meme_tags", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "meme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id"
  end

  add_index "meme_tags", ["group_id"], name: "index_meme_tags_on_group_id", using: :btree
  add_index "meme_tags", ["meme_id"], name: "index_meme_tags_on_meme_id", using: :btree
  add_index "meme_tags", ["tag_id"], name: "index_meme_tags_on_tag_id", using: :btree

  create_table "memes", force: :cascade do |t|
    t.integer  "creator_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "group_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "reactions", force: :cascade do |t|
    t.integer  "meme_id"
    t.integer  "user_id"
    t.string   "reaction_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "group_id"
  end

  add_index "reactions", ["group_id"], name: "index_reactions_on_group_id", using: :btree
  add_index "reactions", ["meme_id"], name: "index_reactions_on_meme_id", using: :btree
  add_index "reactions", ["user_id"], name: "index_reactions_on_user_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id"
  end

  add_index "tags", ["group_id"], name: "index_tags_on_group_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
