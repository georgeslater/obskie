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

ActiveRecord::Schema.define(version: 20150114023221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "title",                  limit: 255
    t.string   "album_art",              limit: 255
    t.integer  "year"
    t.text     "body"
    t.string   "spotify_identifier",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "artist_id"
    t.integer  "user_id"
    t.string   "album_art_file_name",    limit: 255
    t.string   "album_art_content_type", limit: 255
    t.integer  "album_art_file_size"
    t.datetime "album_art_updated_at"
    t.string   "slug",                   limit: 255
    t.integer  "impressions_count"
    t.integer  "obscurity_rating"
    t.integer  "comments_count",                     default: 0
    t.string   "itunes_identifier",      limit: 255
    t.string   "itunes_view_url",        limit: 255
    t.boolean  "published",                          default: false, null: false
    t.string   "amazon_url",             limit: 255
    t.string   "spotify_link",           limit: 255
    t.string   "musicbrainz_identifier", limit: 255
    t.string   "upc_barcode",            limit: 255
    t.string   "rdio_url",               limit: 255
    t.string   "status",                 limit: 255
    t.string   "workflow_state",         limit: 255
    t.date     "date_released"
    t.string   "amazon_url_uk"
  end

  add_index "albums", ["artist_id"], name: "index_albums_on_artist_id", using: :btree
  add_index "albums", ["user_id"], name: "index_albums_on_user_id", using: :btree
  add_index "albums", ["workflow_state"], name: "index_albums_on_workflow_state", using: :btree

  create_table "artists", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",                   limit: 255
    t.string   "musicbrainz_identifier", limit: 255
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "album_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "playlist_id"
  end

  add_index "comments", ["album_id"], name: "index_comments_on_album_id", using: :btree
  add_index "comments", ["playlist_id"], name: "index_comments_on_playlist_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "forem_categories", force: :cascade do |t|
    t.string   "name",       limit: 255,             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",       limit: 255
    t.integer  "position",               default: 0
  end

  add_index "forem_categories", ["slug"], name: "index_forem_categories_on_slug", unique: true, using: :btree

  create_table "forem_forums", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.text    "description"
    t.integer "category_id"
    t.integer "views_count",             default: 0
    t.string  "slug",        limit: 255
    t.integer "position",                default: 0
  end

  add_index "forem_forums", ["slug"], name: "index_forem_forums_on_slug", unique: true, using: :btree

  create_table "forem_groups", force: :cascade do |t|
    t.string "name", limit: 255
  end

  add_index "forem_groups", ["name"], name: "index_forem_groups_on_name", using: :btree

  create_table "forem_memberships", force: :cascade do |t|
    t.integer "group_id"
    t.integer "member_id"
  end

  add_index "forem_memberships", ["group_id"], name: "index_forem_memberships_on_group_id", using: :btree

  create_table "forem_moderator_groups", force: :cascade do |t|
    t.integer "forum_id"
    t.integer "group_id"
  end

  add_index "forem_moderator_groups", ["forum_id"], name: "index_forem_moderator_groups_on_forum_id", using: :btree

  create_table "forem_posts", force: :cascade do |t|
    t.integer  "topic_id"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reply_to_id"
    t.string   "state",       limit: 255, default: "pending_review"
    t.boolean  "notified",                default: false
  end

  add_index "forem_posts", ["reply_to_id"], name: "index_forem_posts_on_reply_to_id", using: :btree
  add_index "forem_posts", ["state"], name: "index_forem_posts_on_state", using: :btree
  add_index "forem_posts", ["topic_id"], name: "index_forem_posts_on_topic_id", using: :btree
  add_index "forem_posts", ["user_id"], name: "index_forem_posts_on_user_id", using: :btree

  create_table "forem_subscriptions", force: :cascade do |t|
    t.integer "subscriber_id"
    t.integer "topic_id"
  end

  create_table "forem_topics", force: :cascade do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "subject",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "locked",                   default: false,            null: false
    t.boolean  "pinned",                   default: false
    t.boolean  "hidden",                   default: false
    t.datetime "last_post_at"
    t.string   "state",        limit: 255, default: "pending_review"
    t.integer  "views_count",              default: 0
    t.string   "slug",         limit: 255
  end

  add_index "forem_topics", ["forum_id"], name: "index_forem_topics_on_forum_id", using: :btree
  add_index "forem_topics", ["slug"], name: "index_forem_topics_on_slug", unique: true, using: :btree
  add_index "forem_topics", ["state"], name: "index_forem_topics_on_state", using: :btree
  add_index "forem_topics", ["user_id"], name: "index_forem_topics_on_user_id", using: :btree

  create_table "forem_views", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "viewable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",                         default: 0
    t.string   "viewable_type",     limit: 255
    t.datetime "current_viewed_at"
    t.datetime "past_viewed_at"
  end

  add_index "forem_views", ["updated_at"], name: "index_forem_views_on_updated_at", using: :btree
  add_index "forem_views", ["user_id"], name: "index_forem_views_on_user_id", using: :btree
  add_index "forem_views", ["viewable_id"], name: "index_forem_views_on_viewable_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type", limit: 255
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name",     limit: 255
    t.string   "action_name",         limit: 255
    t.string   "view_name",           limit: 255
    t.string   "request_hash",        limit: 255
    t.string   "ip_address",          limit: 255
    t.string   "session_hash",        limit: 255
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index", using: :btree
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index", using: :btree
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index", using: :btree
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index", using: :btree
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id", using: :btree

  create_table "playlists", force: :cascade do |t|
    t.string   "spotify_uri",    limit: 255
    t.string   "name",           limit: 255
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.integer  "followers"
    t.string   "image_url",      limit: 255
    t.integer  "track_count"
    t.text     "blurb"
    t.integer  "comments_count",             default: 0
    t.string   "deezer_uri",     limit: 255
    t.string   "rdio_uri",       limit: 255
    t.string   "slug",           limit: 255
  end

  add_index "playlists", ["slug"], name: "index_playlists_on_slug", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "track_id"
    t.float    "score"
    t.string   "ip_address", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["track_id"], name: "index_ratings_on_track_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "submitted",  default: false, null: false
    t.boolean  "approved",   default: false, null: false
  end

  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "tracks", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
    t.float    "author_rating"
    t.integer  "duration_milli"
    t.string   "spotify_identifier",     limit: 255
    t.string   "spotify_link",           limit: 255
    t.string   "musicbrainz_identifier", limit: 255
    t.string   "rdio_url",               limit: 255
  end

  add_index "tracks", ["album_id"], name: "index_tracks_on_album_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                   limit: 255, default: "",               null: false
    t.string   "encrypted_password",      limit: 255, default: "",               null: false
    t.string   "reset_password_token",    limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       default: 0,                null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",      limit: 255
    t.string   "last_sign_in_ip",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",                limit: 255
    t.string   "first_name",              limit: 255
    t.string   "last_name",               limit: 255
    t.boolean  "forem_admin",                         default: false
    t.string   "forem_state",             limit: 255, default: "pending_review"
    t.boolean  "forem_auto_subscribe",                default: false
    t.string   "avatar_file_name",        limit: 255
    t.string   "avatar_content_type",     limit: 255
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "admin",                               default: false
    t.boolean  "is_approved_contributor",             default: false
    t.string   "confirmation_token",      limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
