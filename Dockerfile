FROM jboss/wildfly

# For HTTP2
RUN keytool -genkeypair -alias http2test -keyalg RSA -keystore /opt/jboss/wildfly/standalone/configuration/http2test.keystore -storepass storepass -keypass keypass -dname "cn=127.0.0.1.xip.io"
ADD resources/standalone.xml /opt/jboss/wildfly/standalone/configuration/standalone.xml

RUN cd /opt/jboss/wildfly/bin && \
curl -O http://central.maven.org/maven2/org/mortbay/jetty/alpn/alpn-boot/8.1.8.v20160420/alpn-boot-8.1.8.v20160420.jar && \
echo '# Add ALPN to the boot class path' >> standalone.conf && \\
echo 'JAVA_OPTS="$JAVA_OPTS -Xbootclasspath/p:$JBOSS_HOME/bin/alpn-boot-8.1.8.v20160420.jar"' >> standalone.conf 

# Deploy application
USER root
RUN yum install -y maven

RUN mkdir /app && chown jboss:jboss /app
ADD app /app
RUN cd /app && mvn package && \
cp target/example-http2-1.0-SNAPSHOT.war /opt/jboss/wildfly/standalone/deployments/ && \
chown jboss:jboss /opt/jboss/wildfly/standalone/deployments/*

USER jboss