require 'sqlite3'
require 'json'
require 'sinatra'

post '/' do
    req = request.body.read.strip
    p req

    json = JSON.parse(req);
    sql = json['sql'].strip
    p sql

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
    JSON.generate(response)
end
