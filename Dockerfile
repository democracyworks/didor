FROM clojure:lein-2.5.1
MAINTAINER Democracy Works, Inc. <dev@democracy.works>

ADD ./deploy-or-run /bin/deploy-or-run

CMD ["/bin/deploy-or-run"]
