require 'rails_helper.rb'

feature 'Delete comments - ' do
  before do
    user = create :user
    
    user_two = create(:user, email: 'lol@lol.com',
                             user_name: 'MUFASAyeaH',
                             id: 2)
    post = create :post
    comment = create(:comment, user_id: user_two.id, post_id: post.id, content: "nice")
  
    comment_two = create(:comment, id: 2,
                                   post_id: post.id,
                                   content: 'You guys')
                                   
    sign_in_with user_two
  end
  xscenario 'can delete own comment' do
    visit '/'
    expect(page).to have_content('nice')
    
    # Can't find the delete button
    page.driver.submit :delete, "/comments/#{post.id}", {}
    
    expect(page).to_not have_content('nice')
  end
  
  xscenario 'cannot delete someone elses comment' do
    visit '/'
    expect(page).to have_content('You guys')
    # Can't find the delete css
    expect(page).to_not have_css('#delete-2')
  end
  
  xscenario 'user cannot delete a comment not belonging to them via urls' do
    visit '/'
    expect(page).to have_content('You guys are too kind xo')
    page.driver.submit :delete, "posts/1/comments/2", {}
    expect(page).to have_content("That doesn't belong to you!")
    expect(page).to have_content('You guys are too kind xo')
  end
end
