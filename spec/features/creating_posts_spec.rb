require 'rails_helper.rb'

feature 'Creating posts' do
  before do
    user = create :user 
    sign_in_with user
  end
  
  scenario 'can create a post' do
    visit '/'
    click_link 'New Post'
    attach_file('Image', "spec/files/images/coffee.jpg")
    fill_in 'Caption', with: 'nom nom nom #Coffeetime'
    click_button 'Create Post'
    expect(page).to have_content('#Coffeetime')
    expect(page).to have_css("img[src*='coffee.jpg']")
  end
  
  scenario 'needs an image to create a post' do
    visit '/'
    click_link 'New Post'
    fill_in 'Caption', with: 'nom nom nom #Coffeetime'
    click_button 'Create Post'
    expect(page).to have_content('Halt, you fiend! You need an image to post here!')
  end
  
end

