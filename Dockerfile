# Use a lightweight JRE image
FROM eclipse-temurin:17-jre-focal

WORKDIR /app

# Copy the JAR file built by Maven
# Note: The 'deploy' job identifies it in the root after download-artifact
COPY github-actions-demo.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
