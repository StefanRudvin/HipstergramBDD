require 'rails_helper.rb'

feature 'User Authentication - ' do
  before do
    user = create :user
  end

  scenario 'Log in user from index' do
    visit '/'
    click_link 'Log in'
    fill_in 'Email', with: 'fancybugger@gmail.com'
    fill_in 'Password', with: 'YEAHMAN'
    click_button 'Log in'

    expect(page).to have_content('Signed in successfully.')
    expect(page).to_not have_content('Register')
    expect(page).to have_content('Logout')

  end

  scenario 'User can log out' do
    visit '/'
    click_link 'Log in'
    fill_in 'Email', with: 'fancybugger@gmail.com'
    fill_in 'Password', with: 'YEAHMAN'
    click_button 'Log in'

    click_link 'Logout'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
  end

  scenario 'cannot view index posts without logging in' do
    visit '/'
    expect(page).to have_content('You need to sign in or sign up before continuing.')
end

scenario ' cannot create a new post without logging in' do
  visit new_post_path
    expect(page).to have_content('You need to sign in or sign up before continuing.')
end


end
