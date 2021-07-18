FROM maven:3.6.3-jdk-8

COPY ./ ./

RUN mvn clear package

CMD ["java", "-jar", "/target/spring-petclinic-2.4.5.jar"]

