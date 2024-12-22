FROM maven:latest as builder

WORKDIR /app

COPY . .

RUN mvn clean package

FROM tomcat:latest

RUN cp -R /usr/local/tomcat/webapps.dist/* /usr/local/tomcat/webapps/

COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/
