FROM openjdk:17.0.2-jdk-slim AS build

WORKDIR /app

RUN apt-get update && apt-get install -y maven

COPY pom.xml .

RUN mvn dependency:go-offline -B

COPY src ./src

RUN mvn clean package -DskipTests

FROM openjdk:17.0.2-jdk-slim AS runtime 

COPY --from=build /app/target/springboot-react-1.0.0.jar springboot-react-1.0.0.jar

EXPOSE 9001

ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} -jar springboot-react-1.0.0.jar"]
