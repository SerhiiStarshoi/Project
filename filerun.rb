require_relative "tests"

case ENV["WHAT_TEST"]
when "create"
  Tests::Create.new.whole_test
when "update"
  Tests::Update.new.whole_test
when "delete"
  Tests::Deactivate.new.whole_test
else
  puts "No such test!"
end

#retire
