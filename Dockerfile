FROM openjdk:17-slim AS build

# Install Maven
RUN apt-get update && apt-get install -y maven

# Copy your Maven project files into the image
COPY . /app

# Set the working directory
WORKDIR /app

# Build the Maven project
RUN mvn clean install -DskipTests

# Use a lighter image for the final application
FROM openjdk:17-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file from the build stage to the current working directory
COPY --from=build /app/target/Calculator-1.0-SNAPSHOT.jar /app.jar

# Expose the port your app will run on (adjust if needed)
EXPOSE 8000

# Command to run your application
ENTRYPOINT ["java", "-jar", "/app/Calculator-1.0-SNAPSHOT.jar"]
