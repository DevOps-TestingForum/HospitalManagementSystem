FROM maven:latest as builder

WORKDIR /app

COPY . .

RUN mvn clean package

FROM tomcat:latest

RUN sed -i 's/8080/8084/' /usr/local/tomcat/conf/server.xml

RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/

COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/
EXPOSE 8084
