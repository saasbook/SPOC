require 'textbook_email'

describe 'SendTextbookEmail' do

  it 'reads in requests and generates textbooks' do
    generate_mobis
  end
 
  it 'launches thunderbird for sending emails' do
    send_textbook_email
  end
end

=begin
/Applications/Thunderbird.app/Contents/MacOS/thunderbird -compose "to='tansaku@gmail.com',bcc='sjoseph@hpu.edu',subject='test',body='test'"
=end