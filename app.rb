require 'sinatra'
require 'json'

def exec(image, sql)
    cmd = "docker run -e SQL='#{sql}' #{image}"
    p cmd
    response = IO.popen(cmd, "r+") {|io| 
        io.each_line.map{|l|l}.join 
    }
    p response
    response
end

get '/' do
    erb :index
end

get '/problem/:id' do
    id = params[:id]

    contents = JSON.load(File.open("problem/#{id}/contents.json"))
    @problem_title = contents["title"]
    @problem_body = open("problem/#{id}/#{contents["problem"]}").read
    @problem_tables = contents["tables"]
    @problem_example = contents["example"]

    erb :problem
end

post '/query/:id' do
    id = params[:id]
    sql = request.body.read.strip
    p sql

    res = exec "koduki/sqljudge-#{id}", sql
    res
end
