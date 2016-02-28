FROM        java:7-jdk

ENV         JAVA_HOME             /usr/lib/jvm/java-7-openjdk-amd64
ENV         GLASSFISH_HOME        /opt/glassfish3
ENV         GLASSFISH_VERSION     3.1.2.2
ENV         PATH                  $PATH:$JAVA_HOME/bin:$GLASSFISH_HOME/bin

RUN         apt-get update && \
            apt-get install -y curl unzip zip inotify-tools expect && \
            apt-get clean && \
            rm -rf /var/lib/apt/lists/*

RUN         curl -L -o /tmp/glassfish-$GLASSFISH_VERSION-web.zip http://download.java.net/glassfish/$GLASSFISH_VERSION/release/glassfish-$GLASSFISH_VERSION-web.zip && \
            unzip /tmp/glassfish-$GLASSFISH_VERSION-web.zip -d /opt/ && \
            rm -f /tmp/glassfish-$GLASSFISH_VERSION-web.zip

ADD         changePassword.sh /opt/glassfish3
ADD         enableAdmin.sh /opt/glassfish3

RUN         asadmin start-domain && \
            expect /opt/glassfish3/changePassword.sh && \
            expect /opt/glassfish3/enableAdmin.sh && \
            asadmin stop-domain

VOLUME ["/opt/glassfish3/glassfish/domains"]

EXPOSE      8080 4848 8181

WORKDIR     /opt/glassfish3

CMD         asadmin start-domain --verbose