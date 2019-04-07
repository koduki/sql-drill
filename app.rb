require 'sinatra'
require 'json'
require 'rest-client'

def exec(id, sql)
    url = "https://sqljudge-p#{id}-k66dhjq4na-uc.a.run.app/"
    res = RestClient.post url, { :sql => sql }.to_json, {content_type: :json, accept: :json}
    p res
    res
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
    res = exec id, sql
    res
end
