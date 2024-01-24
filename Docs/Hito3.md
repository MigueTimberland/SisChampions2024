# Hito 3 : Creación de un contenedor para pruebas

## Elección de un contenedor base

Para esta parte del proyecto se eligió un contenedor base para el proyecto en PHP y PhpAdmin.

Se empleará una imagen de PHP que ofrece un entorno de ejecución PHP estandarizado y reproducible. Esta medida es esencial para garantizar que tu aplicación funcione de manera consistente en diversos entornos, ya sea durante el desarrollo, las pruebas o en la fase de producción. Además, puedes hacer uso de la integración con otros servicios de Docker, como bases de datos, servidores web y sistemas de orquestación de contenedores.

En cuanto a la imagen oficial de MySQL, nos proveerá un entorno de base de datos estandarizado y reproducible. Usualmente, la imagen de MySQL ya viene preconfigurada con las opciones más comunes y recomendadas para un entorno de base de datos MySQL.

Realizar la instalación de dichas imagenes

   ![Hito3_1](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/docker_php.png)

   ![Hito3_2](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/docker_mysql.png)

 Aqui instalamos composer

   ![Hito3_3](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/docker_images.png)  

Aqui comprobaremos que las imagenes se encuentran dentro del contenedor

   ![Hito3_4](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/docker_escritorio.png)

## Configuración del contenedor

### Archivo Dockerfile


Construiremos nuestro contenedor base a partir de la imagen oficial de PHP 8.2 con Apache.

```
FROM php:8.1.10-apache
```
Definimos el usuario root debido a que necesitaremos permisos de administrador para instalar composer.
```
USER root
```
Establecemos el directorio dentro del contenedor en /var/www/html. 
```
WORKDIR /var/www/html
```
Copiamos los archivos de configuración de apacher de la carpeta base en las carpetas del contenedor
```
COPY ./docker/sources.list /etc/apt/sources.list  
COPY ./docker/000-default.conf  /etc/apache2/sites-available/000-default.conf
```
Descargamos e instalamos las bibliotecas necesarios.
```
RUN apt update && apt install -y \
        nodejs \
        npm \
        libpng-dev \
        zlib1g-dev \
        libxml2-dev \
        libzip-dev \
        libonig-dev \
        zip \
        curl \
        unzip \
        make \
    && docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip \
    && docker-php-source delete
```
Descarga e instalación de composer.
```
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN chown -R www-data:www-data /var/www/html && a2enmod rewrite

```

#### Creación del archivo docker-compose.yml
------------
Definiremos el entorno de desarrollo de la aplicación web en el archivo docker-compose.yml En el cual definiremos:
1. Servicio web basandonos en el archivo Dockerfile definido previamente.
2. Servicio de base de datos con la imagen de MySQL.
3. Servicio para conectarnos a la BD de datos con la imagen de phpMyAdmin.

#### Ejecución del contenedor de pruebas
------------

Ya hemos configurado los archivos necesarios, ahora empezaremos a construir la imagen y ejecutar el contenedor para iniciar los servicios definidos en el archivo docker-compose.yml , con el comando:
```
docker-compose up -d 
```
Obtenemos el siguiente resultado.

![docker_compose](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/docker_compose.png)
![docker_imagen](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/docker_images_star.png)

Podemos visualizar el contenedor en la aplicación Docker de Widnows.

![Hito3_4](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/docker_escritorio.png)

Ahora ejecutaremos las pruebas unitarias y funcionales en el contenedor con el comando con el gestor de tareas que definimos en el anterior hito

```
make test 
```
Obteniendo el siguiente resultado que incluyen las pruebas satisfactorias.

![test_0](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/test0.png)

![docker_0](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/test1.png)


#### Contenedor subido a Dockerhub
------------

Para subir el contenedor en el que se ejecutarón las pruebas unitarias, necesitamos etiquetarla con nuestro nombre de usuario e imagen. Para ello ejecutamos el siguiente comando:

```
docker tag sischampions2024-web:latest miguetimberland/sischampions2024-api-web:latest
```

Ahora subimos la imagen a docker hub con el siguiente comando:
```
docker push miguetimberland/sischampions2024-web:latest
```

Al ejecutar obtenemos el siguiente resultado:

![docker_hub](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/dockerhub.png)

Podemos ver tambien el resultado en nuestro perfil de Dockerhub:

![docker_hub_repositorio](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/dockerhub_repositorio.png)

#### Uso de registros alternativos y públicos de contenedores
------------

Se ha configurado un workflow en el proyecto para que pueda ser ejecutado por actions de github para cada vez que se hace un cambio a la rama main. El workflow configurado se puede revisar [aquí](https://github.com/florescobar/Scambia-PracticasCC-UGR/blob/main/.github/workflows/github_actions.yml)


Al ejecutarse las GitHub Actions se obtuvo el siguiente resultado:

![](https://raw.githubusercontent.com/florescobar/Scambia-PracticasCC-UGR/main/docs/img/hito3_8.png)

Podemos ver tambien en la sección de paquetes de nuestro repositorio:
![](https://raw.githubusercontent.com/florescobar/Scambia-PracticasCC-UGR/main/docs/img/hito3_9.png)