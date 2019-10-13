require 'user'
require 'database_helpers'

describe Users do
  describe '.create' do
    it "creates a new user account" do
      user = Users.create(name: 'name', username: 'user', email: 'user@user.com', password: 'password')
      persisted_data = persisted_data(table: 'users', id: user.id)

      expect(user).to be_a Users
      expect(user.username).to eq 'user'
      expect(user.name).to eq 'name'
      expect(user.email).to eq 'user@user.com'
      expect(user.id).to eq persisted_data.first['id']
    end

    it 'hashes the password using BCrypt' do
      expect(BCrypt::Password).to receive(:create).with('password')

      Users.create(name: 'name', username: 'user', email: 'user@user.com', password: 'password')
    end
  end

  describe '.find' do
    it "finds user by user_id" do
      user = Users.create(name: 'name', username: 'user', email: 'user@user.com', password: 'password')
      result = Users.find(user.id)

      expect(result.id).to eq user.id
      expect(result.name).to eq user.name
      expect(result.username).to eq user.username
      expect(result.email).to eq user.email
    end

    it 'returns nil if there is no ID given' do
      expect(Users.find(nil)).to eq nil
    end
  end
end
