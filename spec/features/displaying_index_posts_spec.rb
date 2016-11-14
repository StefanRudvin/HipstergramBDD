require 'rails_helper.rb'

feature 'Index displays a list of posts' do
  before do
    user = create :user
    post_one = create(:post, caption: 'This is post one',
                            user_id: user.id)
    post_two = create(:post, caption: 'This is the second post',
                            user_id: user.id)

    sign_in_with user
  end
  
  scenario 'the index displays correct created post information' do
    
    expect(page).to have_content("This is post one")
    expect(page).to have_content("This is the second post")
    expect(page).to have_css("img[src*='coffee']")
  end
end