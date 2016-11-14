require 'rails_helper.rb'

feature 'Delete comments - ' do
  before do
    user = create :user
    
    user_two = create(:user, email: 'lol@lol.com',
                             user_name: 'MUFASAyeaH',
                             id: 2)
    post = create :post
    comment = create(:comment, user_id: user_two.id, post_id: post.id, content: "nice")

    sign_in_with user_two
  end
  scenario 'can delete own comment' do
    visit '/'
    expect(page).to have_content('nice')
    click_link 'delete-1' # Dynamically add the id in your view
    expect(page).to_not have_content('nice')
  end
  
end
