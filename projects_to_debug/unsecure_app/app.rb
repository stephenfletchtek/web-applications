require 'sinatra/base'
require "sinatra/reloader"
require 'cgi'

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/hello' do
    if invalid_input?
      status 400
      return ''
    else
      @name = params[:name]
      return erb(:hello)
    end
  end

  def invalid_input?
    return true if params[:name] == nil
    return true if params[:name] != CGI.escapeHTML(params[:name])
    return true if params[:name].match(/\W+/)
  end
end
