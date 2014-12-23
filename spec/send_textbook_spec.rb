require 'dotenv'
Dotenv.load

require 'capybara/rspec'
require 'byebug'

Capybara.default_driver = :selenium

describe 'sending textbook', :type => :feature do

  before do
    visit 'https://www.amazon.com/ap/signin?_encoding=UTF8&openid.assoc_handle=usflex&openid.claimed_id=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.identity=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0%2Fidentifier_select&openid.mode=checkid_setup&openid.ns=http%3A%2F%2Fspecs.openid.net%2Fauth%2F2.0&openid.ns.pape=http%3A%2F%2Fspecs.openid.net%2Fextensions%2Fpape%2F1.0&openid.pape.max_auth_age=0&openid.return_to=https%3A%2F%2Fwww.amazon.com%2Fgp%2Fyourstore%2Fhome%3Fie%3DUTF8%26action%3Dsign-out%26path%3D%252Fgp%252Fyourstore%252Fhome%26ref_%3Dnav_youraccount_signout%26signIn%3D1%26useRedirectOnSuccess%3D1'
    fill_in :ap_email, with: ENV['AMAZON_USERNAME'] 
    fill_in :ap_password, with: ENV['AMAZON_PASSWORD']
    click_button 'Sign in using our secure server'
    expect(page).to have_content ', Armando'
  end

  it 'should send textbook' do
    visit 'http://www.amazon.com/Engineering-Software-Service-Approach-Computing-ebook/dp/B00CCEHNUM/'
    click_button 'Give as a gift'
    fill_in 'giftRecipient', with: 'instructor@example.com'
    first(:button, 'Place your order').click
  end

  it 'should add to mailing list'
  # https://groups.google.com/forum/#!managemembers/esaas-instructors/add - captchas ...
  it 'should send welcome email'
end