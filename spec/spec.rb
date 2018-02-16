require 'rails_helper'

describe User do

  describe 'User.new' do
    before(:each)  do
      @user = User.new(name: "Mary", password: "red")
    end

    it "has a name" do
      expect(@user.name).to eq("Mary")
    end

    it 'has a password' do
      expect(@user.password_digest.nil?).to be_falsey
    end

    it 'defaults to active' do
      expect(@user.active).to be_truthy
    end

    it 'can be updated to inactive' do
      @user.active = false
      expect(@user.active).to be_falsey
    end

    it 'inherits from ActiveRecord::Base' do
      expect(User.superclass.superclass).to eq(ActiveRecord::Base)
    end
  end





  describe "User.create" do
    describe "given a name and a password" do
      it "creates a new instance" do
        expect(User.create(name: "Timothy", password_digest: "123")).to eql(User.last)
      end
    end

    describe "given only a name" do
      it "will not create a new user" do
        expect(User.create(name: "Timothy")).not_to eql(User.last)
      end
    end

    before do
      User.create(name: "Tommy", password_digest: "123")
    end

    describe "given a name that already exists in the database" do
      it "will not create a new user" do
        expect(User.create(name: "Tommy", password_digest: "123")).not_to eql(User.last)
      end
    end
  end

  describe "User.find" do
    before(:each) do
      @user = User.create(name: "Tommy", password_digest: "123")
    end

    describe "given an id number" do
      it "will find the associated user" do
        expect(User.find(@user.id)).to eql(@user)
      end
    end

    describe "given the name of a user" do
      it "will return that user" do
        expect(User.find_by(name: "Tommy")).to eql(@user)
      end
    end

    describe "given an id that does not exist" do
      it "will raise an error" do
        expect { User.find(2) }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

end
