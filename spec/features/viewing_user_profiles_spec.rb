require 'rails_helper.rb'

feature 'viewing user profiles' do
  before do
    user = create :user
    user_two = create(:user, id: 2,
                             email: 'hi@hi.com',
                             user_name: 'bigrigoz')
    post = create(:post, user_id: user.id)
    post_two = create(:post, user_id: 2,
                             caption: 'different post yo')
    sign_in_with user

    visit '/'
    first('.user-name').click_link 'bigrigoz', match: :first
  end

  scenario 'visiting a profile page shows the user name in the url' do
    expect(page.current_path).to eq(profile_path('bigrigoz'))
  end

  scenario "a profile page only shows the specified user's posts" do
    expect(page).to_not have_content 'nofilter'
    expect(page).to have_content 'different post yo'
  end
end
