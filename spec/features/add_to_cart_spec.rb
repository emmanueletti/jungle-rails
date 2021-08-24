require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    1.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "user can add to cart and cart increases by 1" do
    # setup
    visit root_path
    expect(page).to have_text 'My Cart (0)'

    click_on 'Add'
    
    expect(page).to have_text 'My Cart (1)'
    
  end
end