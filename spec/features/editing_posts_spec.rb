require 'rails_helper.rb'

feature 'Editing posts - ' do
  before do
    user = create :user
    
    user_two = create(:user, email: 'lol@lol.com',
                             user_name: 'MUFASAyeaH',
                             id: user.id + 1)
                  
    post = create(:post, user_id: user.id)
    
    post_two = create(:post, user_id: user.id + 1)

    sign_in_with user
    visit '/'
  end
  scenario 'can edit a post as the owner' do
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    expect(page).to have_content('Edit Post')

    click_link 'Edit Post'
    fill_in 'Caption', with: "Oh god, you weren't meant to see this picture!"
    click_button 'Update Post'

    expect(page).to have_content('Post updated hombre')
    expect(page).to have_content("Oh god, you weren't meant to see this picture!")
  end
  
  scenario 'cannot edi a post as another user' do
    find(:xpath, "//a[contains(@href,'posts/2')]").click
    expect(page).to_not have_content('Edit Post')
  end
  
  scenario 'cannot edit a post as another user' do
    visit "/posts/2/edit"
    
    expect(page).to_not have_content('Update Post')
  end
  
  it "won't update a post without an image" do  
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    click_link 'Edit Post'
    attach_file('Image', 'spec/files/coffee.zip')
    click_button 'Update Post'

    expect(page).to have_content('Something is wrong with your form!')
  end  
  
end
