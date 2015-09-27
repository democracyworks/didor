FROM clojure:lein-2.5.2
MAINTAINER Democracy Works, Inc. <dev@democracy.works>

RUN mkdir -p /opt/didor
WORKDIR /opt/didor

RUN apt-get update && apt-get upgrade -y # last updated 20150416
RUN apt-get install -y ruby jq curl
RUN gem install bundler

COPY ./Gemfile /opt/didor/Gemfile
COPY ./Gemfile.lock /opt/didor/Gemfile.lock
RUN bundle install

COPY ./read_edn.rb /opt/didor/read_edn.rb

ADD ./deploy-or-run /bin/deploy-or-run

EXPOSE 8080

CMD ["/bin/deploy-or-run"]
