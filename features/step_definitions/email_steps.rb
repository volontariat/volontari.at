Before do
  ActionMailer::Base.deliveries.clear
end

Given /^I have an empty inbox$/ do
 ActionMailer::Base.deliveries.clear
end

Then /^(an|no) email should have been sent((?: |and|with|from "[^"]+"|to "[^"]+"|the subject "[^"]+"|the body "[^"]+"|the attachments "[^"]+")+)$/ do |mode, query|
  conditions = {}
  conditions[:to] = $1 if query =~ /to "([^"]+)"/
  conditions[:from] = $1 if query =~ /from "([^"]+)"/
  conditions[:subject] = $1 if query =~ /the subject "([^"]+)"/
  conditions[:body] = $1 if query =~ /the body "([^"]+)"/
  conditions[:attachments] = $1 if query =~ /the attachments "([^"]+)"/
  
  @mail = TestMails.find(conditions)
  expectation = mode == 'no' ? 'should_not' : 'should'
  @mail.send(expectation, be_present)
end

When /^I follow the (first|second|third)? ?link in the email$/ do |index_in_words|
  # Caveat: will not only take a-href but also img-src and other http-values
  mail = @mail || ActionMailer::Base.deliveries.last
  # index = { nil => 0, 'first' => 0, 'second' => 1, 'third' => 2 }[index_in_words]
  # visit mail.body.scan(Patterns::URL)[index][2]
  visit mail.body.to_s.scan(/http(?:s?):\/\/[^"\s]+/).send(index_in_words).split(':3000').last
end

Then /^no email should have been sent$/ do
  ActionMailer::Base.deliveries.should be_empty
end
 
Then /^show me the emails$/ do
  #raise ActionMailer::Base.deliveries.length.inspect
  puts "emails count:" + ActionMailer::Base.deliveries.length.inspect
  
  ActionMailer::Base.deliveries.each do |mail|
    p [mail.from, mail.to, mail.subject, mail.body]
  end
end

Then /^that mail should have "([^"]*)" in the body$/ do |word|
  @mail.body.include?(word).should be_true
end
# 
# 
class TestMails
  class << self

    attr_accessor :user_identity

    def find(conditions)
      ActionMailer::Base.deliveries.detect do |mail|
        [ conditions[:to].nil? || mail.to.include?(resolve_email conditions[:to]),
          conditions[:from].nil? || mail.from.include?(resolve_email conditions[:from]),
          conditions[:subject].nil? || mail.subject.include?(conditions[:subject]),
          conditions[:body].nil? || mail.body.include?(conditions[:body]),
          conditions[:attachments].nil? || conditions[:attachments].split(/\s*,\s*/).sort == Array(mail.attachments).collect(&:original_filename).sort
        ].all?
      end.tap do |mail|
        puts "Die Mail: #{mail}" 
        log(mail)
      end
    end

    def resolve_email(identity)
      if identity =~ /^.+\@.+$/
        identity
      else
        User.send("find_by_#{user_identity || 'email'}!", identity).email
      end
    end

    def log(mail)
      puts "Aufruf: #{mail}" 
      if mail.present?
        File.open("log/test_mails.log", "a") do |file|
          file << "From: #{mail.from}\n"
          file << "To: #{mail.to.join(', ')}\n"
          file << "Subject: #{mail.subject}\n\n"
          file << mail.body
          file << "\n-------------------------\n\n"
        end
      end
    end

  end
end