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

Asi quedaria el archivo [Dockerfile](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/Dockerfile.txt)

 ![Hito3_12](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/dokerefile.png)

### Archivo docker-compose.yml

Luego pasaremos a la configuración de [docker-compose.yml](https://github.com/MigueTimberland/inventory/blob/master/Docs/docker-compose.yml)

- El servicio php-apache utiliza la imagen oficial de PHP con Apache y expone el puerto 80.

![Hito3_12](img/Hito3_12.png)

- El servicio pgadmin utiliza la imagen oficial de Postgres, se ha configurado con un usuario y contraseña.

![Hito3_14](img/Hito3_14.png)

- El servicio pgadmin utiliza la imagen oficial de pgAdmin4, se ha configurado con un usuario y contraseña.

![Hito3_15](img/Hito3_15.png)

## Ejecución del contenedor

Para construir la imagen del contenedor se ejecuta el siguiente comando:

![Hito3_21](img/Hito3_21.png)

Dando el siguiente resultado:

![Hito3_22](img/Hito3_22.png)

Como siguienre paso inicializamos los servicios definidos en el archivo docker-compose.yml, con el siguiente comando:

![Hito3_16](img/Hito3_16.png)

![Hito3_19](img/Hito3_19.png)

Primero comprobaremos la ejecución de postgres y psAdmin, así que en un navegador probaremos el localhost:8081, en el cual pondremos el usuario y contraseña que colocamos en el archivo docker-compose.yml, como a continuación se ven en las imagenes:

![Hito3_17](img/Hito3_17.png)

![Hito3_18](img/Hito3_18.png)

Luego comprobaremos la ejecución de PHP

![Hito3_20](img/Hito3_20.png)

## Docker Hub

Iniciamos creando una imagen del proyecto.

![Hito3_23](img/Hito3_23.png)

LUego subimos la imagen a docker hub con el siguiente comando:

![Hito3_24](img/Hito3_24.png)

De la misma forma podemos visualizar el resultado en el navegador

![Hito3_25](img/Hito3_25.png)

## Uso de registros alternativos y públicos de contenedores 

 - **Primero:** Creamos un archivo en el área de trabajo, el cual se encontrara en la ruta [.github/workflows/update-imagen.yml](github/workflows/update-imagen.yml)

 - **Segundo:** Una vez que se creo y configuro el archivo YAML, confirma y empuja los cambios a tu repositorio en GitHub.

 - **Tercero:** Luego revisar la sección "Actions" en el repositorio en GitHub para ver los resultados de la ejecución de las acciones programadas. 

![Hito3_26](img/Hito3_26.png)













