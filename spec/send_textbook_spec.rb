describe 'sending textbook' do

  before do
    visit 'https://www.amazon.com/ap/signin'
    fill_in :email, with: ENV['AMAZON_USERNAME'] 
    fill_in :password, with: ENV['AMAZON_PASSWORD']
    click_button 'Sign in using our secure server'
    expect(page).to have_content ', Armando'
  end

  it 'should send textbook' do
    visit 'http://www.amazon.com/Engineering-Software-Service-Approach-Computing-ebook/dp/B00CCEHNUM/'
    click_button 'give-as-gift'
    fill_in 'email-address', with: 'test@email.com'
  end

  it 'should add to mailing list'
  # https://groups.google.com/forum/#!managemembers/esaas-instructors/add - captchas ...
  it 'should send welcome email'
end