require 'csv'
require 'byebug'
require 'ostruct'


THUNDERBIRD = '/Applications/Thunderbird.app/Contents/MacOS/thunderbird'

MAKE_MOBI_PREFIX = 'make mobi WATERMARK="'
MOBI_ESCAPE_CHARS = '\\\\\\\\\\\\\\\\'
MAKE_MOBI_SUFFIX = '" ; mv saasbook.mobi ~/Dropbox/Public/saasbook_prof_'
MOBI_FILE_EXTENSION = '.mobi'

LASTNAME_INDEX = 0
FIRSTNAME_INDEX = 1
EMAIL_INDEX = 2
LANGUAGE_INDEX = 3

def send_textbook_email
  preselectid = 'id2'
  bcc = ''
  subject = 'Engineering Software as a Service Community Welcome!'
  attachment = '/Users/tansaku/Documents/Documents/AgileVentures/LocalSupport/WelcomeLetter.docx.pdf'

  requestors = CSV.read("requests.ssv", { col_sep: "\s", skip_lines: ';' })
  requestors.each do |requestor|
    
    lastname = requestor[LASTNAME_INDEX]
    language = requestor[LANGUAGE_INDEX]
    email = requestor[EMAIL_INDEX]
    to = email
    template = language == 'Español' ? 'email_spanish.erb' : 'email.erb'
    file_path = File.join(File.dirname(__FILE__),template)
    link = "https://dl.dropboxusercontent.com/u/13196858/saasbook_prof_#{lastname.downcase}.mobi"
    namespace = OpenStruct.new(lastname: lastname, link: link)
    body = ERB.new(File.read(file_path)).result(namespace.instance_eval { binding })
    options = %Q{"to='#{to}',preselectid='#{preselectid}',bcc='#{bcc}',subject='#{subject}',body='#{body}',attachment='#{attachment}'"}
    command = "#{THUNDERBIRD} -compose #{options}"
    puts command
    `#{command}`
  end
end

def generate_mobis
  requestors = CSV.read("requests.ssv", { col_sep: "\s", skip_lines: ';' })
  Dir.chdir('/Users/tansaku/Documents/GitHub/armandofox/saasbook') do
    requestors.each do |requestor|
      lastname = requestor[LASTNAME_INDEX]
      firstname = requestor[FIRSTNAME_INDEX]
      email = requestor[EMAIL_INDEX]
      language = requestor[LANGUAGE_INDEX]
      `#{MAKE_MOBI_PREFIX}#{firstname} #{lastname}#{MOBI_ESCAPE_CHARS}#{email}#{MAKE_MOBI_SUFFIX}#{lastname.downcase}#{MOBI_FILE_EXTENSION}`
    end
  end 
end