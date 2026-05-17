 
# Stage 1: Build program menggunakan Maven & JDK 25
FROM maven:3.9.9-eclipse-temurin-25 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Jalankan aplikasi menggunakan JRE 25 yang ringan
FROM eclipse-temurin:25-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Port default yang dibaca oleh Render
EXPOSE 7860

ENTRYPOINT ["java", "-Dserver.port=7860", "-jar", "app.jar"]