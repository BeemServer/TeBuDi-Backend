# Stage 1: Build menggunakan JDK 21 LTS resmi
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Jalankan aplikasi menggunakan JRE 21 yang ringan
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Wajib port 7860 untuk Hugging Face
EXPOSE 7860
ENTRYPOINT ["java", "-Dserver.port=7860", "-jar", "app.jar"]