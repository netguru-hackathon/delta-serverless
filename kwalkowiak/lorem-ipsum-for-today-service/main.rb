# frozen_string_literal: true

# initialize standalone bundler
require __dir__ + '/bundle/bundler/setup.rb'
# require the gems we want to use
require 'betterlorem'
require 'erb'

def main(params)
  length = (params["length"] || 20).to_i
  lorem_text = BetterLorem.w(length, true)
  filename = File.join(__dir__, 'views', 'template.html.erb')
  {
    statusCode: 200,
    headers: { 'Content-Type': 'text/html' },
    body: ERB.new(File.read(filename)).result(binding)
  }
end
