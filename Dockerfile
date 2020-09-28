FROM ruby

ENV HTTP_PORT 8080

COPY http_server.rb /

CMD ["ruby", "http_server.rb"]