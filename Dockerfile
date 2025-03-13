FROM maven:3.9.6-eclipse-temurin-21

# Diretório de trabalho na imagem
WORKDIR /app

# Copia os arquivos do projeto para o container
COPY . .

# Compila o projeto
RUN mvn clean package -DskipTests

# Copia o arquivo compilado para a pasta /app
RUN cp target/*.jar /app/app.jar

# Porta da aplicação
EXPOSE 8080

# Comando para iniciar a aplicação
CMD ["java", "-jar", "app.jar"]