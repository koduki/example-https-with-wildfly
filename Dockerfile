FROM jboss/wildfly
USER root
RUN  yum install -y maven

RUN mkdir /app && chown jboss:jboss /app
ADD app /app
RUN cd /app && mvn package && \
cp target/example-http2-1.0-SNAPSHOT.war /opt/jboss/wildfly/standalone/deployments/ && \
chown jboss:jboss /opt/jboss/wildfly/standalone/deployments/*

USER jboss
#ADD your-awesome-app.war /opt/jboss/wildfly/standalone/deployments/
