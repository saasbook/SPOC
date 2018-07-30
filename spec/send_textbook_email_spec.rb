require 'textbook_email'

describe 'SendTextbookEmail' do
 
  it 'launches thunderbird for sending emails' do
    send_textbook_email
  end
end

=begin
/Applications/Thunderbird.app/Contents/MacOS/thunderbird -compose "to='tansaku@gmail.com',bcc='sjoseph@hpu.edu',subject='test',body='test'"
=end