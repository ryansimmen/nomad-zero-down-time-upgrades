# http_server.rb
require 'socket'

$enable_health_endpoint = true

def shut_down
  puts "\nTurning off health endpoint..."
  $enable_health_endpoint = false
end

Signal.trap("INT") { 
  shut_down 
}

Signal.trap("TERM") {
  shut_down
}

server = TCPServer.new ENV["HTTP_PORT"]

while session = server.accept
  request = session.gets
  puts request

  method, full_path = request.split(' ')

  path, query = full_path.split('?')

  if path == "/_ping" && $enable_health_endpoint then
    session.print "HTTP/1.1 200\r\n" 
    session.print "Content-Type: text/html\r\n"
    session.print "\r\n"
    session.print "pong!"
    session.close

  elsif path == "/" then
    session.print "HTTP/1.1 200\r\n" 
    session.print "Content-Type: text/html\r\n"
    session.print "\r\n"
    session.print "#{ENV["VERSION"]}"
    session.close

  else
    session.print "HTTP/1.1 400\r\n" 
    session.print "Content-Type: text/html\r\n"
    session.print "\r\n"
    session.print "Bad Request"
    session.close

  end
end