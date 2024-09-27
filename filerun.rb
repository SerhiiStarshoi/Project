require_relative 'tests'

what_test = "create"

case what_test
when "create"
  Tests::Create.new.whole_test
when "update"
  Tests::Update.new.whole_test
when "delete"
  Tests::Deactivate.new.whole_test
else
  puts "No such test!"
end

# git_ignore CMD + K
# видалити перед гіт ігнор файли які були залиті на гіт
# запушити папку на гіт

# #зробити щоб біфор викликався в усіх тестах але був написати в одному місці ++++
# get location має +- виглядати як delete (get location сховати ріквести) ++++
# file_run має мати всі new і ми передаємо стрінгою назву тесту який запускаємо ++++
# всі рекваєр перенести в модуль ???
# глянути чи треба інклуд локейшенс ++++
# $LOAD_PATH? чи можна зробити через рекваєр
# у всіх методах має бути теж перевірка статусів ++++
# https://www.atlassian.com/git/tutorials/merging-vs-rebasing
# updated
