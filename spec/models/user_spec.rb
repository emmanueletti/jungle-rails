require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'validations' do 
    it 'saves new user if password and password confirmation match' do 
      user = User.new
      user.name = 'test'
      user.email = 'test@gmail.com'
      user.password = '123456789abcde'
      user.password_confirmation = '123456789abcde'

      expect(user.save).to be true
      expect(user.errors).to be_empty
    end

    it 'does not save if password and password confirmation do not match' do 
      user = User.new
      user.name = 'test'
      user.email = 'test@gmail.com'
      user.password = '123456789abcde'
      user.password_confirmation = 'no match'

      expect(user.save).to be false
      expect(user.errors.messages).to have_key(:password_confirmation)
    end

    it 'does not save if email already in database - case insensitive' do 
      # establish pre-existing user
      pre_existing_user = User.new
      pre_existing_user.name = 'John'
      pre_existing_user.email = 'TEST@TEST.com'
      pre_existing_user.password = '123456789abcde'
      pre_existing_user.password_confirmation = '123456789abcde'
      expect(pre_existing_user.save).to be true

      test_user = User.new
      test_user.name = 'test'
      test_user.email = 'test@test.COM'
      test_user.password = '123456789abcde'
      test_user.password_confirmation = '123456789abcde'

      expect(test_user.save).to be false
      expect(test_user.errors.messages[:email]).to eq(['has already been taken'])
    end

    it 'does not save and gives an error if email is not provided' do 
      user = User.new
      user.name = 'no email'
      user.email = nil
      user.password = '123456789abcde'
      user.password_confirmation = '123456789abcde'

      expect(user.save).to be false
      expect(user.errors.messages).to have_key(:email)
    end

    it 'does not save and gives an error if name is not provided' do 
      user = User.new
      user.name = nil
      user.email = 'noname@gmail.com'
      user.password = '123456789abcde'
      user.password_confirmation = '123456789abcde'

      expect(user.save).to be false
      expect(user.errors.messages).to have_key(:name)
    end

    it 'should not save and create an error when password length is less than 10' do
      user = User.new
      user.name = 'test'
      user.email = 'shortpass@gmail.com'
      user.password = '123456789'
      user.password_confirmation = '123456789'

      expect(user.save).to be false
      expect(user.errors.messages).to have_key(:password)
    end
  end


   describe '.authenticate_with_credentials' do
    it 'should return nil if user is not found' do 
      user = User.authenticate_with_credentials('no_such_user@gmail.com', '123456789abcde')
      expect(user).to be_nil
    end

    it 'returns nil if password is incorrect' do
      pre_existing_user = User.new
      pre_existing_user.name = 'John'
      pre_existing_user.email = 'TEST@TEST.com'
      pre_existing_user.password = '123456789abcde'
      pre_existing_user.password_confirmation = '123456789abcde'
      expect(pre_existing_user.save).to be true

      user = User.authenticate_with_credentials('TEST@TEST.com', 'wrong password')
      expect(user).to be_nil
    end

     it 'returns user if user found and password is correct' do
      pre_existing_user = User.new
      pre_existing_user.name = 'John'
      pre_existing_user.email = 'TEST@TEST.com'
      pre_existing_user.password = '123456789abcde'
      pre_existing_user.password_confirmation = '123456789abcde'
      expect(pre_existing_user.save).to be true

      user = User.authenticate_with_credentials('TEST@TEST.com', '123456789abcde')
      expect(user.email).to eq('TEST@TEST.com')
    end
   end
end
