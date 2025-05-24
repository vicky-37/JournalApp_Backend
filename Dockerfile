# ----------- Stage 1: Build the application -----------
FROM maven:3.9.9-eclipse-temurin-11 AS build

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests


# ----------- Stage 2: Run the application -----------
FROM eclipse-temurin:11-jre-focal

WORKDIR /app

COPY --from=build /app/target/journalApp-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]

