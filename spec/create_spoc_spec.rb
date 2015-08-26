require 'capybara/rspec'
require 'course'
require 'yaml'
#require 'byebug'

Capybara.run_server = false
Capybara.default_driver = :selenium

# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end

describe 'Creating SPOC', :type => :feature do

  let!(:course) do
    courses = YAML.load_file('course.yml')
    courses[:rose_2015_fall]
  end

  before do
    visit 'https://studio.edge.edx.org/signin'
    fill_in :email, with: ENV['EDGE_STUDIO_USERNAME']
    fill_in :password, with: ENV['EDGE_STUDIO_PASSWORD']
    click_button 'submit'
    expect(page).to have_content 'tansaku'
  end

  it 'should create course' do
    click_link 'New Course'
    expect(page).to have_content 'Create a New Course'
    fill_in 'new-course-name', with: course.title
    fill_in 'new-course-org', with: course.institution
    fill_in 'new-course-number', with: course.id
    fill_in 'new-course-run', with: course.date
    click_button 'Create'
    # the course URL is redirected to, but we don't seem to be picking it up ...
    # perhaps it is ajax and taking too long to load
    # run over network in chrome next time and see if we can just format a pseudo-API request?

    # there is a clear page reload although it does take some time - need to click 'preserve log'
    # next time around ...
    sleep 2

    #{"org":"SUNY_Binghamton","number":"CS445-01","display_name":"Software Engineering","run":"2014_Fall"}
    # was sent to https://studio.edge.edx.org/course/ via POST
    # I can't see any redirect - of course the URL can be constructed from the data
    expect(page).not_to have_content "There is already a course defined with the same organization, course number, and course run. Please change either organization or course number to be unique."
  end

  it 'should add instructor to admin' do
    visit course.team_url
    click_link 'Add a New Team Member'

    fill_in 'user-email', with: course.contact
    click_button 'Add User'
    click_link 'Add Admin Access'
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
    #byebug
    attach_file('input.file-input','/Users/sam/Dropbox/Public/1T2014.rmjYLw.tar.gz')
    expect(page).to have_content 'Replace my course with the one above'
    # hmmm, we could just POST to https://studio.edge.edx.org/import/UnionU/CSC397/2014_Fall
    # payload appears to be - although presumably the file itself must be in there somewhere ...
=begin
------WebKitFormBoundaryZq56aT9SO7WjYLSX
Content-Disposition: form-data; name="course-data"; filename="1T2014.rmjYLw.tar.gz"
Content-Type: application/x-gzip


------WebKitFormBoundaryZq56aT9SO7WjYLSX--
=end
  end



  it 'should reset the course title and number' do
    visit 'https://studio.edge.edx.org/settings/advanced/WesleyanU/COMP342/2014_Fall'
    fill_in 'Course Display Name', with: '"Software Engineering"'
    fill_in 'Course Number Display String', with: '"COMP342"'
    click_link 'Save Changes'
    expect(page).to have_content 'Your policy changes have been saved.'
    # could POST directly to https://studio.edge.edx.org/settings/advanced/UnionU/CSC397/2014_Fall
    # payload here is complete JSON of settings ... not sure if all are required
    # would be great to actually be able to talk to engineers about this stuff...
  end

end