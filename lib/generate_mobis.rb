require_relative 'textbook_config'

MAKE_MOBI_PREFIX = 'make mobi WATERMARK="'
MOBI_ESCAPE_CHARS = '\\\\\\\\\\\\\\\\'
MAKE_MOBI_SUFFIX = '" ; mv saasbook.mobi ~/Dropbox/Public/saasbook_prof_'
MOBI_FILE_EXTENSION = '.mobi'

def generate_mobis
  requestors = CSV.read("requests.ssv", { col_sep: "\s", skip_lines: ';' })
  Dir.chdir('/Users/tansaku/Documents/GitHub/armandofox/saasbook') do
    requestors.each do |requestor|
      lastname = requestor[LASTNAME_INDEX]
      firstname = requestor[FIRSTNAME_INDEX]
      email = requestor[EMAIL_INDEX]
      language = requestor[LANGUAGE_INDEX]
      cmd = "#{MAKE_MOBI_PREFIX}#{firstname} #{lastname}#{MOBI_ESCAPE_CHARS}#{email}#{MAKE_MOBI_SUFFIX}#{lastname.downcase}#{MOBI_FILE_EXTENSION}"
      puts cmd
      `#{cmd}`
    end
  end 
end