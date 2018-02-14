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

User.create(name: "unassigned", password: "orange")
User.create(name: "Cristy", password: "red")
User.create(name: "Ray", password: "red")
User.create(name: "Torre", password: "red")

Group.find_or_create_by(name: "Lucke Household", creator_id: 3, owner_id: 2)
Group.find_or_create_by(name: "Flatiron", creator_id: 4, owner_id: 4)

Membership.find_or_create_by(user_id: 2, group_id: 2)
Membership.find_or_create_by(user_id: 3, group_id: 2)
Membership.find_or_create_by(user_id: 4, group_id: 3)

##Lucke Household tasks
### Tasks in "created" status:
Task.find_or_create_by(title: "Laundry", group_id: 1, creator_id: 2, description: "schedule laundry pickup", notes: "use delivery.com for Jane Laundromat")
Task.find_or_create_by(title: "Get Laundry Ready", group_id: 1, creator_id: 2, description: "get laundry ready for pickup", notes: "Gather dirty clothes and drag laundry bags out by door. Get Joshy's cot sheets out of backpack from Friday.", parent_id: 1)
Task.find_or_create_by(title: "Put Garbage Out", group_id: 1, creator_id: 3, description: "Empty garbage and recycling", notes: "Put new bags in all cans")

### Tasks in "in progress" status
Task.find_or_create_by(title: "Get Cashier's Check $45", group_id: 1, creator_id: 2, description: "Get Chase cashier's check for school supplies", notes: "Made out to PS41 PTA and add name and room number to notes section", status: "in progress")
Task.find_or_create_by(title: "Order white bookshelf for kids' room", group_id: 1, creator_id: 2, description: "Find white bookshelf on Amazon", notes: "Budget of about $150. Prime Shipping", status: "in progress")
Task.find_or_create_by(title: "Order groceries", group_id: 1, creator_id: 2, description: "Put in FreshDirect order on Saturday", notes: "See Cristy's account for current cart", status: "in progress")

### Tasks in "blocked" status
Task.find_or_create_by(title: "Paint Wall", group_id: 1, creator_id: 2, description: "paint living room wall wall", notes: "Currently blocked while waiting for landlord approval", status: "blocked")
Task.find_or_create_by(title: "Get matching paint", group_id: 1, creator_id: 2, description: "Get matching paint for wall", notes: "Get paint sample and put in envelope", status: "blocked", parent_id: 7)
Task.find_or_create_by(title: "Go to Home Depot", group_id: 1, creator_id: 2, description: "match paint and painting supplies", notes: "Get paint matched and basic painting supplies", status: "blocked", parent_id: 7)
Task.find_or_create_by(title: "Schedule EEG Appt", group_id: 1, creator_id: 2, description: "Lennox Hill Neurology EEG appointment", notes: "Call 1-866-2400./r/nProblem is I need a weekend appintment and they don't have them yet./r/nSupposedly weekend appointments are coming soon.", status: "blocked")

### Tasks in "completed" status
Task.find_or_create_by(title: "Get Laundry Ready", group_id: 1, creator_id: 2, description: "get laundry ready for pickup", notes: "Gather dirty clothes and drag laundry bags out by door", parent_id: 1, status: "completed")
Task.find_or_create_by(title: "Logan Field Trip Form", group_id: 1, creator_id: 2, description: "complete Logan's field trip form", notes: "Due Friday. Put in backpack.", parent_id: 1, status: "completed")
Task.find_or_create_by(title: "Class Valentines", group_id: 1, creator_id: 2, description: "Buy Valentines for kid classes", notes: "Logan's class: need 28 Valentines/r/nJoshua's class: need 18 Valentines/r/n2 teachers per class", parent_id: 1, status: "completed")
Task.find_or_create_by(title: "Put Garbage Out", group_id: 1, creator_id: 3, description: "Empty garbage and recycling", notes: "Make sure to put new bags in all cans", status: "completed")

##Flatiron Tasks
### Tasks in "created" status:
Task.find_or_create_by(title: "Pick FSP Topic", group_id: 2, creator_id: 4, owner_id: 4, description: "Pick FSP topic after consulting with partner", notes: "Presentation March 6th")
Task.find_or_create_by(title: "Pick FSP Topic", group_id: 2, creator_id: 2, owner_id: 2, description: "Pick FSP topic after consulting with partner", notes: "Presentation March 13th")

### Tasks in "in progress" status
Task.find_or_create_by(title: "Mod2 Final Project", group_id: 2, creator_id: 2, owner_id: 2, description: "Organization App", status: "in progress")
Task.find_or_create_by(title: "Blog Post", group_id: 2, creator_id: 2, owner_id: 2, description: "Create new blog post", status: "in progress")

### Tasks in "completed" status
Task.find_or_create_by(title: "Mod1 Final Project", group_id: 2, creator_id: 2, owner_id: 2, description: "Organization App", status: "completed")

##Lucke Household Events
###Events
Event.find_or_create_by(title: "Ray's Birthday", group_id: 1, creator_id: 2, starts_at: "#{DateTime.new(2018,6,24)}", ends_at: "#{DateTime.new(2018,6,24)}")
Event.find_or_create_by(title: "Cristy's Birthday", group_id: 1, creator_id: 2, starts_at: "#{DateTime.new(2018,11,19)}", ends_at: "#{DateTime.new(2018,11,19)}")
Event.find_or_create_by(title: "Logan's Birthday", group_id: 1, creator_id: 2, starts_at: "#{DateTime.new(2018,11,15)}", ends_at: "#{DateTime.new(2018,11,15)}")
Event.find_or_create_by(title: "Joshua's Birthday", group_id: 1, creator_id: 2, starts_at: "#{DateTime.new(2018,7,20)}", ends_at: "#{DateTime.new(2018,7,20)}")
Event.find_or_create_by(title: "David Arrives!", group_id: 1, creator_id: 3, starts_at: "#{DateTime.new(2018,2,15)}", ends_at: "#{DateTime.new(2018,2,15)}")
Event.find_or_create_by(title: "iPic Comedy Show", group_id: 1, creator_id: 3, starts_at: "#{DateTime.new(2018,2,14,19,30)}", ends_at: "#{DateTime.new(2018,2,14,21,00)}")

##Flatiron Events
###Events
Event.find_or_create_by(title: "FSP Presentation", group_id: 1, creator_id: 2, notes: "Partner is Alex G.", starts_at: "#{DateTime.new(2018,3,13)}", ends_at: "#{DateTime.new(2018,3,13)}")
Event.find_or_create_by(title: "Blog Presentation", group_id: 1, creator_id: 2, starts_at: "#{DateTime.new(2018,2,23)}", ends_at: "#{DateTime.new(2018,2,23)}")
Event.find_or_create_by(title: "FSP Presentation", group_id: 1, creator_id: 4, notes: "Partner is Vic", starts_at: "#{DateTime.new(2018,3,6)}", ends_at: "#{DateTime.new(2018,3,6)}")
Event.find_or_create_by(title: "Blog Presentation", group_id: 1, creator_id: 4, starts_at: "#{DateTime.new(2018,2,20)}", ends_at: "#{DateTime.new(2018,2,20)}")
