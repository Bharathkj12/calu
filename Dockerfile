# Use an official Maven image to build the app
FROM maven:3.8.6-openjdk-17-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and source code to the container
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean install -DskipTests

# Use a lighter image for the final application
FROM openjdk:17-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file from the build stage to the current working directory
COPY --from=build /app/target/Calculator-1.0-SNAPSHOT.jar /app/Calculator-1.0-SNAPSHOT.jar

# Expose the port your app will run on (adjust if needed)
EXPOSE 8000

# Command to run your application
ENTRYPOINT ["java", "-jar", "Calculator-1.0-SNAPSHOT.jar"]

