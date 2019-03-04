require 'sinatra'
require 'json'

def exec(action, params)
    env = params.map{|x|"-e #{x} "}.join
    response = IO.popen("docker run --network -e action=#{action} #{env} -v /tmp/data:/data koduki/worker", "r+") {|io| 
        io.each_line.map{|l|l}.join 
    }
    response
end

get '/' do
    id = "0001"

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

    response = {
        "status" => 0,
        "result" => [
            ["グループ名","ランキング最上位","ランキング最下位"],
            ["A",3,56],
            ["B",1,62],
            ["C",8,46]
        ]
    }
    JSON.generate(response)
end

get '/:user/create' do
    user = params[:user]
    response = exec "create", ["u=#{user}"]
    response
end

get '/:user/show' do
    user = params[:user]
    response = exec "show", ["u=#{user}"]
    response
end

get '/:user/deposit/:amount' do
    user = params[:user]
    amount = params[:amount]
    response = exec "deposit", ["u=#{user}", "arg=#{amount}"]
    response
end
