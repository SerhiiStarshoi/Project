require_relative "lib/authorization"
require_relative "lib/locations"
require_relative 'tests'

case ENV['WHAT_TEST'] #create
when "create"
  Tests::Create.new.whole_test
when "update"
  Tests::Update.new.whole_test
when "delete"
  Tests::Deactivate.new.whole_test
else
  puts "No such test!"
end

# придумати як можна заранити декілька тестів обмежитись одною змінною
# перенести тести в кукунбмер і створити новий фіча фейл в якому будуть ці три тести і записати ці три тести в сценаріях
# описати ці степи на рубі
#REQUIRE спробувати




# https://www.atlassian.com/git/tutorials/merging-vs-rebasing
