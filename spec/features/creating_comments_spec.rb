require 'rails_helper.rb'

feature 'Creating comments - ' do
  before do
    user = create :user
    post = create(:post, user_id: user.id)
    sign_in_with user
  end

  xscenario 'can create comment on post' do
    visit '/'
    #element = page.find("comment")
    #element.set('Yoyoyoyoyoo my man')
    fill_in 'comment[content]', with: 'Yoyoyoyoyoo my man'
    click_button 'Submit'
    expect(page).to have_css("div.comments#{post.id}", text: 'Yoyoyoyoyoo my man')
  end

end
