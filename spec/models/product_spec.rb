require 'rails_helper'

RSpec.describe Product, type: :model do
  # setup - create category dependency
  # rspec handles clean up
  before(:each) do
    test_category = Category.new
    test_category.name = 'test'
    test_category.save
  end

  describe 'Saves' do
    it 'should save when all fields are correctly given with no errors' do 
      product = Product.new
      product.name = 'test product'
      product.price = 200
      product.quantity = 2
      product.category_id = Category.find_by(name: 'test').id
      
      expect(product.save).to be true
      expect(product.errors).to be_empty
    end
  end
  
  describe 'Validations' do
      it 'should not save and create an error when name is not given' do 
        product = Product.new
        product.name = nil
        product.price = 200
        product.quantity = 2
        product.category_id = Category.find_by(name: 'test').id
        
        expect(product.save).to be false
        expect(product.errors.messages).to have_key(:name)
      end

      it 'should not save and create an error when price is not given' do 
        product = Product.new
        product.name = 'no price given'
        product.price = nil
        product.quantity = 2
        product.category_id = Category.find_by(name: 'test').id
        
        expect(product.save).to be false
        expect(product.errors.messages).to have_key(:price)
      end
      
      it 'should not save and create an error when quantity is not given' do 
        product = Product.new
        product.name = 'no quantity given'
        product.price = 200
        product.quantity = nil
        product.category_id = Category.find_by(name: 'test').id
        
        expect(product.save).to be false
        expect(product.errors.messages).to have_key(:quantity)
      end
      
      it 'should not save and create an error when category is not given' do 
        product = Product.new
        product.name = 'no category given'
        product.price = 200
        product.quantity = 2
        product.category_id = nil
        
        expect(product.save).to be false
        expect(product.errors.messages).to have_key(:category)
      end
    end
end
