FROM clojure:lein-2.7.1-alpine
MAINTAINER Democracy Works, Inc. <dev@democracy.works>

RUN mkdir -p /opt/didor
WORKDIR /opt/didor

RUN apk add --update ruby ruby-dev build-base jq curl coreutils
RUN gem install bundler io-console --no-document

COPY ./Gemfile /opt/didor/Gemfile
COPY ./Gemfile.lock /opt/didor/Gemfile.lock
RUN bundle install

COPY ./read_edn.rb /opt/didor/read_edn.rb

ADD ./deploy-or-run /bin/deploy-or-run

EXPOSE 8080

CMD ["/bin/deploy-or-run"]
