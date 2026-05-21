FROM openjdk:17

COPY target/myapp.jar myapp.jar

ENTRYPOINT ["java","-jar","/myapp.jar"]