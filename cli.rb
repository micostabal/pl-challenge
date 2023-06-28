require_relative 'util'
require 'io/console'

class CLI
  def get_credentials(filename)
    if file_exists(filename)
      auth_data = open_json_file(filename)
      
      client_id = auth_data['client_id']
      client_secret = auth_data['client_secret']
    else 
      puts "Enter client_id"
      client_id = STDIN.noecho(&:gets).chomp
      puts "Enter client_secret"
      client_secret = STDIN.noecho(&:gets).chomp
    end

    return {
      'client_id': client_id,
      'client_secret': client_secret
    }
  end
end