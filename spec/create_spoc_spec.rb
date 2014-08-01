require 'capybara/rspec'
require 'byebug'

Capybara.default_driver = :selenium

describe 'Creating SPOC', :type => :feature do

  before do
    visit 'https://studio.edge.edx.org/signin'
    fill_in :email, with: ENV['EDGE_STUDIO_USERNAME']
    fill_in :password, with: ENV['EDGE_STUDIO_PASSWORD']
    click_button 'submit'
    expect(page).to have_content 'Welcome, tansaku!'
  end

  xit 'should create course' do
    click_link 'New Course'
    expect(page).to have_content 'Create a New Course'
    fill_in 'new-course-name', with: 'Software Engineering'
    fill_in 'new-course-org', with: 'WesleyanU'
    fill_in 'new-course-number', with: 'COMP342'
    fill_in 'new-course-run', with: '2014_Fall'
    click_button 'Create'
    sleep 3
    puts URI.parse(current_url)
  end

  it 'should create course' do
    click_link 'New Course'
    expect(page).to have_content 'Create a New Course'
    fill_in 'new-course-name', with: 'Software Engineering'
    fill_in 'new-course-org', with: 'UPugetSound'
    fill_in 'new-course-number', with: 'CS240'
    fill_in 'new-course-run', with: '2014_Fall'
    click_button 'Create'
    # I think the course URL is displayed somehow rather than redirected to
    # TODO Will need to check that next time we create something ...
  end

  xit 'should upload 169.1 course' do
    visit 'https://studio.edge.edx.org/course/WesleyanU/COMP342/2014_Fall'
    expect(page).to have_content 'Course Outline'
    visit 'https://studio.edge.edx.org/import/WesleyanU/COMP342/2014_Fall'
    expect(page).to have_content 'Select a .tar.gz File to Replace Your Course Content'
    click_link 'Choose a File to Import'
    byebug
    attach_file('input.file-input','/Users/sam/Dropbox/Public/1T2014.rmjYLw.tar.gz')
    expect(page).to have_content 'Replace my course with the one above'
  end

  it 'should upload 169.1 course' do
    visit 'https://studio.edge.edx.org/course/UPugetSound/CS240/2014_Fall'
    expect(page).to have_content 'Course Outline'
    visit 'https://studio.edge.edx.org/import/UPugetSound/CS240/2014_Fall'
    expect(page).to have_content 'Select a .tar.gz File to Replace Your Course Content'
    click_link 'Choose a File to Import'
    byebug
    attach_file('input.file-input','/Users/sam/Dropbox/Public/1T2014.rmjYLw.tar.gz')
    expect(page).to have_content 'Replace my course with the one above'
  end

  it 'should add instructor to admin' do
    #visit 'https://studio.edge.edx.org/course_team/WesleyanU/COMP342/2014_Fall/'
    visit 'https://studio.edge.edx.org/course_team/UPugetSound/CS240/2014_Fall/'
    click_link 'Add a New Team Member'

    fill_in 'user-email', with: '<instructor-email>'
    click_button 'Add User'
  end

  it 'should reset the course title and number' do
    visit 'https://studio.edge.edx.org/settings/advanced/WesleyanU/COMP342/2014_Fall'
    fill_in 'Course Display Name', with: '"Software Engineering"'
    fill_in 'Course Number Display String', with: '"COMP342"'
    click_link 'Save Changes'
    expect(page).to have_content 'Your policy changes have been saved.'
  end

end