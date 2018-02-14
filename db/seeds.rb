# create_table "groups", force: :cascade do |t|
#   t.string "name"
#   t.integer "creator_id"
#   t.integer "owner_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#
# create_table "items", force: :cascade do |t|
#   t.string "type"
#   t.integer "creator_id"
#   t.integer "group_id"
#   t.integer "owner_id"
#   t.integer "parent_id"
#   t.string "title"
#   t.string "description"
#   t.string "status"
#   t.text "notes"
#   t.datetime "starts_at"
#   t.datetime "ends_at"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#
# create_table "memberships", force: :cascade do |t|
#   t.integer "user_id"
#   t.integer "group_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false

User.create(name: "John Smith", password: "hello")
User.create(name: "Jane Doe", password: "hello")

Group.find_or_create_by(name: "Blue", creator_id: 1, owner_id: 1)
Group.find_or_create_by(name: "Red", creator_id: 1, owner_id: 2)

Membership.find_or_create_by(user_id: 1, group_id: 1)
Membership.find_or_create_by(user_id: 2, group_id: 1)
Membership.find_or_create_by(user_id: 1, group_id: 2)

Task.find_or_create_by(title: "Get Stuff", group_id: 1, creator_id: 1, description: "Hello")
Task.find_or_create_by(title: "Get More Stuff", group_id: 1, creator_id: 2, description: "Hello")
Task.find_or_create_by(title: "Get Stuff Done", group_id: 2, creator_id: 1, description: "Hello")

Event.find_or_create_by(title: "Get Stuff", group_id: 1, creator_id: 1, owner_id: 1, description: "Hello")
Event.find_or_create_by(title: "Get More Stuff", group_id: 1, creator_id: 2, owner_id: 1, description: "Hello")
Event.find_or_create_by(title: "Get Stuff Done", group_id: 2, creator_id: 1, owner_id: 1, description: "Hello")
