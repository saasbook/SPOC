require 'byebug'
require 'ostruct'
require_relative 'textbook_config'

THUNDERBIRD = '/Applications/Thunderbird.app/Contents/MacOS/thunderbird'

def send_textbook_email
  preselectid = 'id2'
  bcc = 'fox@cs.berkeley.edu,patterson@cs.berkeley.edu'
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
    link = "#{ENV['DROPBOX_LINK']}/saasbook_prof_#{lastname.downcase}.mobi"
    namespace = OpenStruct.new(lastname: lastname, link: link)
    body = ERB.new(File.read(file_path)).result(namespace.instance_eval { binding })
    options = %Q{"to='#{to}',preselectid='#{preselectid}',bcc='#{bcc}',subject='#{subject}',body='#{body}',attachment='#{attachment}'"}
    command = "#{THUNDERBIRD} -compose #{options}"
    puts command
    `#{command}`
  end
end