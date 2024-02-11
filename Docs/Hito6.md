
# Hito 6

#### Justificación de la estructura del clúster.
------------

Como se había indicado en todos los puntos de referencia, nuestra iniciativa constará de una API Restful conectada a una base de datos MySQL. Inicialmente, la idea era incorporar también el frontend, pero debido a limitaciones temporales, no fue posible integrarlo en el proyecto. En consecuencia, optaremos por un modelo de Microservicios que implementaremos en contenedores. Esto incluirá el servicio de API Aplicación y la base de datos.

![](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/cliente-servidor.png)

#### Justificación de la configuración de cada uno de los contenedores que lo componen
------------

Dentro del contenedor, se estructurarán dos servicios:

1. Servicio web: La imagen se generará a partir de php.8.2 mediante el archivo Dockerfile. Este redireccionará el puerto 8070 de la máquina host al puerto 80 del contenedor. 
2. Servicio Database: Utiliza la imagen de MySQL con la versión 8.0. En este punto se especifican las credenciales de acceso, así como la base de datos a la cual se conectarán los servicios.


![](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/compose.png)



#### Fichero de composición
------------

Se ha definido en el archivo [docker-compose.yml](https://github.com/MigueTimberland/SisChampions2024/blob/main/routes/docker-compose.yml) los servicios que componen el contenedor. La estructura es la siguiente.

```
services:
  web:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "8070:80" 
    depends_on:
      - db
    volumes:
      - .:/var/www/html

  db:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: 
      MYSQL_DATABASE: dbchampions
      MYSQL_ALLOW_EMPTY_PASSWORD: 'yes'

    ports:
      - "3308:3306"

  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    links:
      - db:db
    ports:
      - "8081:80"
    environment:
      PMA_HOST: db
      MYSQL_ROOT_PASSWORD: secret

```

Para crear la imagen y verificar que el contenedor se ha iniciado correctamente para llevar a cabo las pruebas, ejecutaremos el siguiente comando.

```
docker-compose up -d
```
Obteniendo la siguiente imagen del contenedor en ejecución .
![](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/docker-servicio.png).


#### Pruebas
------------

Ahora que el contenedor está funcionando, incorporamos los siguientes puntos finales para verificar la exactitud de las respuestas.

![](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/docker-servicio.png).
![](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/docker-servicio.png).
![](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/docker-servicio.png).
![](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/docker-servicio.png).


Incluimos la lista de los demás puntos finales en el archivo correspondiente [cc.yaml]( https://github.com/MigueTimberland/SisChampions2024/blob/main/routes/cc.yml)
