# Migrations-Flyway-Manual

Esse projeto tem o objetivo de demonstrar e registrar o processo de integrar o flyway de forma manual em um projeto Spring.

## Passo a Passo

1. No pom.xml incluir a dependência do FlyWay.

```XML
<dependencies>
    ...suas dependências
    <dependency>
        <groupId>org.flywaydb</groupId>
        <artifactId>flyway-core</artifactId>
    </dependency>
    <dependency>
        <groupId>org.flywaydb</groupId>
        <artifactId>flyway-database-postgresql</artifactId>
    </dependency>
    ...suas dependências
</dependencies>
```
OBS: Incluir especificamente do seu banco (MySql, SQLServer ...), no caso estamos usando PostgreSQL assim adicionamos ```flyway-database-postgresql```.

2. Ainda no pom.xml incluir a dependência do plugin do FlyWay.

```XML
<plugins>
    ...Seus plugins
    <plugin>
        <groupId>org.flywaydb</groupId>
        <artifactId>flyway-maven-plugin</artifactId>
        <version>10.17.0</version> 
        <configuration>
            <user>SEU-USER</user>
            <password>SUA-SENHA</password>
            <url>SUA-URL-PARA-BANCO</url>
        </configuration>
    </plugin>
    ...Seus plugins
</plugins>
```

OBS: Tem muidas outras configurações e formas de configurar, por favor olhar na [Documentação FlyWay](https://documentation.red-gate.com/flyway/getting-started-with-flyway).

3. No application.properties faça a configuração para seu banco de dados.

```sh
spring.application.name=NOME-APLICAÇÂO
spring.datasource.url=SUA-URL-PARA-BANCO
spring.datasource.username=SEU-USER
spring.datasource.password=SUA-SENHA
```

4. Agora vamos remover a sincronização das migrações para ter maior controle. na sua pasta de configuração crie um arquivo ```EmptyMigrationStrategyConfig.java``` com uma estratégia "vazia" assim quando o projeto iniciar **não será executado automaticamente**.

```java
package SEU-PATH;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.boot.autoconfigure.flyway.FlywayMigrationStrategy;

@Configuration
public class EmptyMigrationStrategyConfig {

    @Bean
    public FlywayMigrationStrategy flywayMigrationStrategy() {
        return flyway -> {
            // do nothing  
        };
    }
}
```

5. Agora seus SQLs devem ser adicionados na seguinte localização ```resources/db/migration```, esse local pode ser modificado caso necessário por meio da configuração do flyway.

6. Padrão de nomenclatura.

![Imagem do artigo de Grant Fritchey!](https://www.red-gate.com/wp-content/uploads/2020/07/flyway_naming.png "Grant Fritchey")

Ótimo artigo: [Flyway: Naming Patterns Matter - Grant Fritchey](https://www.red-gate.com/blog/database-devops/flyway-naming-patterns-matter).

7. Com as migrations criadas podemos executa-las:

Para migrações "criação/ajuste":
```sh
mvn flyway:migrate
```

Para migrações "rollback":
```sh
mvn flyway:undo
```

8. Para ter informações sobre as migrações:
```sh
mvn flyway:info
```

