# ----------- Stage 1: Build the application -----------
FROM maven:3.9.9-eclipse-temurin-11 AS build

# Set working directory
WORKDIR /app

# Copy the entire project to the container
COPY . .

# Build the application and skip tests (faster build, you can remove -DskipTests for CI)
RUN mvn clean package -DskipTests


# ----------- Stage 2: Run the application -----------
FROM openjdk:11-jre-slim

# Create a working directory in the runtime container
WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/journalApp-0.0.1-SNAPSHOT.jar app.jar

# Expose port 8080 (Spring Boot default)
EXPOSE 8080

# Run the jar file
ENTRYPOINT ["java", "-jar", "app.jar"]
