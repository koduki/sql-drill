require 'sqlite3'
require 'json'

sql = ENV['SQL']
status = 0

db = SQLite3::Database.new("/app/test.db")
begin
    columns, *rows = db.execute2(sql)
rescue Exception => ex
    message = ex.message
    status = 1
ensure
    db.close 
end

response = {
    "status" => status,
    "message" => message,
    "result" => (status == 0) ? [columns] + rows : nil
}
puts JSON.generate(response)

