require 'rails_helper.rb'

feature 'Deleting posts - ' do
  before do
    user = create :user
    post = create(:post, caption: 'Abs for days.', user_id: user.id)

    sign_in_with user
  end
  #16 failures
  scenario 'Can delete a single post' do
    visit '/'
    find(:xpath, "//a[contains(@href,'posts/1')]", match: :first).click
    click_link 'Edit Post'
    click_link 'Delete Post'

    expect(page).to have_content('Problem solved!  Post deleted.')
    expect(page).to_not have_content('Abs for days.')
  end
end
