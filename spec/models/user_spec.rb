require 'spec_helper.rb'
require 'rails_helper.rb'

describe 'User' do
  let(:attributes) {{
      name: "Mary",
      password: "red",
  }}

  describe 'inherits from ActiveRecord::Base' do
    expect(User.superclass.superclass).to eq(ActiveRecord::Base)
  end

  context 'User.new' do
    before(:each) do
      @user = User.new(name: "Mary", password: "red")
    end

    describe 'has a name' do
      @user.name = "Mary"
      expect(@user.name).to eq("Mary")
    end

    # describe 'has a password' do
    #   expect(BCrypt::Password.create('red') == 'red').to be_truthy
    # end
    #
    # describe 'defaults to inactive' do
    #   expect(user.active).to be_falsey
    # end
    #
    # describe 'can be updated to active' do
    #   user.active = true
    #   expect(user.active).to be_truthy
    # end

  end

  context '::new' do
    describe 'cannot be instantiated without a name' do
      expect{User.new}.to raise_error
    end

    describe 'can be instantiated with a hash of attributes' do
      expect{User.new(attributes)}.to_not raise_error
    end
  end

  context '#save' do
    describe 'can be saved to the database' do
      user = User.new(attributes)
      user.save
      expect(User.find_by(attributes)).to eq(user)
    end
  end

  context 'basic CRUD' do
    context 'creating' do
      describe 'can be instantiated and then saved' do
        user = User.new
        user.name = "This is a name."
        user.save
        expect(User.find_by(name: "This is a name.").name).to eq("This is a title.")
      end

      describe 'can be created with a hash of attributes' do
        attributes = {
            name: "The Sting",
            password: 1973,
          }
          user = User.create(attributes)

        expect(User.find_by(attributes)).to eq(user)
      end

      describe 'can be created in a block' do

        user =  User.create do |u|
                  u.name = "Home Alone"
                  u.password_digest = 1990
                end

        expect(User.last).to eq(user)
        expect(User.last.name).to eq("Home Alone")
        expect(User.last.password_digest).to eq(BCrypt::Password.create("1990"))
      end
    end

    context 'reading' do
      before do
        5.times do |i|
          User.create(name: "User_#{i}", password: i+2000)
        end
      end

      describe 'can get the first item in the database' do
        user = User.first.title
        expect(user).to eq("User_0")
      end

      describe 'can get the last item in the databse' do
        user = User.last.title
        expect(user).to eq("User_4")
      end

      describe 'can get size of the database' do
        users_size = User.count
        expect(users_size).to eq(5)
      end

      describe 'can retrive the first item from the database by id' do
        expect(User.find_by(id: 1).name).to eq("User_0")
      end

      describe 'can retrieve from the database using different attributes' do
        user = User.create(name: "Name", password: "red")
        expect(User.find_by(name: "Title", password_digest: BCrypt::Password.create("2000"))).to eq(user)
      end

      describe 'can use a where clause and be sorted' do
        expect(User.where("name > ?", "a").order(name: :desc).map{|u| u.name}).to eq(["User_4", "User_3"])
      end
    end

    context 'updating' do
      describe 'can be found, updated, and saved' do
        user = User.create(name: "Awesome Flick", password: "red")
        expect {
          user = User.find_by(name: "Awesome Flick")
          user.update(name: "Even Awesomer Flick")
          user.reload
        }.to change{ user.name }.from("Awesome Flick").to("Even Awesomer Flick")
      end

      describe 'can be updated using #update' do
        User.create(name: "Wat?").update(:name => "Wat, huh?")
        expect(User.find_by(name: "Wat, huh?")).to_not be_nil
      end

      describe 'can update all records at once' do
        5.times do |i|
          User.create(name: "User_#{i}", password_digest: 2000+i)
        end
        User.update_all name: "A User"
        expect(User.where(name: "A User").size).to eq(5)
      end
    end

    context 'destroying' do
      describe 'can destroy a single item' do
        User.create(name: "That One Where the Guy Kicks Another Guy Once").destroy
        expect(User.find_by(name: "That One Where the Guy Kicks Another Guy Once")).to be_nil
      end

      describe 'can destroy all items at once' do
        10.times do |i|
          User.create(name: "User_#{i}")
        end
        User.destroy_all
        expect(User.all.size).to eq(0)
      end
    end
  end
end
