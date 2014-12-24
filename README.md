# Docker Immutant2 Deploy Or Run (DIDOR) script

This script is designed to allow simpler Docker containers for Clojure apps in dev and production using Immutant 2.

It should be the "CMD" in your Clojure app's Dockerfile.

When run without a linked "wildfly" container, it just executes `lein run`.

When run *with* a linked "wildfly" container, it will deploy the .war file into the WildFly application server,
sleep indefinitely, and undeploy the .war file when stopped.

## Usage

Put the `deploy-or-run` script in your container and run it as the CMD in your Dockerfile.
It will pull the name of your app from the `(defproject ...)` form in your `project.clj` file
and deploy `[app].war` from your `target/` directory (so make sure you run `lein immutant war`
in your Docker build process.

To run the container in standalone mode (lein run):
1. `docker build -t your-image-tag .`
1. `docker run -P -d your-image-tag`

To deploy to a WildFly container:
1. Create a derivative of the `jboss/wildfly` image that adds an admin user and binds the management port on 0.0.0.0.
    1. Example Dockerfile:

    ```dockerfile
    FROM jboss/wildfly
    
    RUN /opt/jboss/wildfly/bin/add-user.sh admin password --silent
    
    CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
    ```
1. Build and run your WildFly container
    1. `docker build -t your-wildfly-image .`
    1. `docker run -d --name wildfly your-wildfly-image`
1. `docker build -t your-image-tag .`
1. `docker run --link wildfly:wildfly -d your-image-tag`
