require 'sqlite3'
require 'json'

sql = ENV['SQL']

db = SQLite3::Database.new("/app/test.db")
columns, *rows = db.execute2(sql)
db.close

response = {
    "status" => 0,
    "result" => [columns] + rows
}
puts JSON.generate(response)
