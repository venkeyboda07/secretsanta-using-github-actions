FROM maven:3.9.9-eclipse-temurin-8 AS build

WORKDIR /build

COPY . .

RUN mvn clean package -DskipTests

FROM eclipse-temurin:8-jre-alpine

WORKDIR /app

COPY --from=build /build/target/secretsanta-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

USER appuser

ENTRYPOINT ["java","-jar","app.jar"]
