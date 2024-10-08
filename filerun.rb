require_relative "tests"

case ENV["WHAT_TEST"]
when "create"
  Tests::Create.new.whole_test
when "update"
  Tests::Update.new.whole_test
when "delete"
  Tests::Deactivate.new.whole_test
when "create-delete"
  Tests::Create.new.whole_test
  Tests::Deactivate.new.whole_test
when "update-delete"
  Tests::Update.new.whole_test
  Tests::Deactivate.new.whole_test
else
  puts "No such test!"
end

#retire
