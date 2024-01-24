# Hito 2 : Test, Librerias y Bibliotecas

## Test

### PHPUnit
  
    [PHPUnit](https://phpunit.de/)  es un framework de pruebas unitarias para el lenguaje de programación PHP. Fue desarrollado originalmente por Sebastian Bergmann y se ha convertido en la herramienta estándar para realizar pruebas unitarias en proyectos PHP. PHPUnit facilita la creación y ejecución de pruebas automatizadas para garantizar que el código funcione correctamente y cumpla con los requisitos esperados.
    
    PHPUnit es ampliamente utilizado en la comunidad de desarrollo de PHP y es una herramienta valiosa para garantizar la calidad del código al automatizar y facilitar el proceso de pruebas unitarias.
    
### Cómo realizar test

Para realizar el test siguiremos los siguientes pasos:

  - **Primero:** Se instala el framework PHPUnit en Visual Code

    ![PHPUnit](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/phpunit.png)

  - **Segundo:** Buscamos el comando PHPUNnit Test 

    ![PHPUnit Test](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/phpunit_test.png)
     
  - **Tercero:** Escogemos que le haremos test: funcion o la clase:
  
     ![PHPUnit Test](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/class.png)

  - **Cuarto:** Al dar click en toda la clase en este caso escogimos la clase TestCase.php
  
     ![PHPUnit Test](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/testcase.png)

### Pruebas de Test

    Realizamos pruebas de Test para las primeras opciones del modulo, y las respuestas fueron las siguientes, las cuales se estan subsanando:

    Jest nos permite generar un reporta referente a la cobertura del código (code coverage ratio) registrado durante el testing. Esto se consigue únicamente empleando el flag --coverage de Jest, mientra que en el caso de Mocha, esto es posible de obtener, pero nuevamente haciendo uso de una biblioteca adicional.

    Por estas razones, y con el fin de no elevar considerablemente la complejidad del proyecto, se ha decidido optar por Jest como marco de pruebas. Este framework es instalado como dependencia de desarrollo mediante npm utilizando el comando:
     
   ![Jest](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/jest.png)
   
   - Se instalo composer
   
   ![Composer](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/composer.png)

   - Se creo un archivo de configuración para Jest, por ejemplo, jest.config.js en el directorio raíz del proyecto:
   
   ![Config](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/config.png)
   
   ![ConfigJs](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/configjs.png)

   - Se creo el archivo CreateProducto.spec.js para la prueba del componente CreateProducto.vue

   ![CreateProducto](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/createproducto.png)
   
   - Finalmente se ejecuta el test
 
   ![EjecucionTest](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/testing.png)


## Librerias y Bibliotecas

Para el desarrollo del proyecto usaremos la siguiente Librerias:
  
 - Bootstrap:
  
   Bootstrap es un marco de desarrollo front-end gratuito y de código abierto para la creación de sitios web y aplicaciones web . Diseñado para permitir el desarrollo responsivo de sitios web móviles, Bootstrap proporciona una colección de sintaxis para diseños de plantillas. El cual se utiliza con los lenguajes de programación CSS, JavaScript, Sass y LESS
   
   Los siguientes pasos para la instalación de la libreria de Boostrap:
   
   1.- Ingresamos a la pagina de [Bootstrap](https://getbootstrap.com/docs/5.3/getting-started/download/), en la cual nos ofrece diferentes formas de usarlo. 
   
   2.- Para el proyecto descargaremos todo el paquete de css de bootstrap y la integraremos a nuestro proyecto.

 - FPDF para PHP
 
   FPDF es una clase librería escrita en PHP que permite generar documentos PDF directamente desde PHP , es decir, sin usar la biblioteca PDFlib. La F de FPDF significa Free (gratis y libre), por lo que es posible utilizar la librería para cualquier propósito y modificar la misma para satisfacer nuestras necesidades.
   
   El único requisito para su instalación es subirlo a nuestro servidor y colocarlo en una carpeta que como consejo es útil llamar fpdf en la raíz del dominio.
   
 - PHPMailer
 
 PHPMailer es una biblioteca de códigos para enviar correos electrónicos de forma segura y sencilla mediante código PHP desde un servidor web.
   
 Para tener la biblioteca PHPMailer descargada e incluida en el proyecto. Puede encontrar la biblioteca en [GitHub](https://github.com/PHPMailer/PHPMailer),

#### Biblioteca de aserciones
------------

Al usar PHPUnit como framework, este ya incluye un conjunto de aserciones que podemos utilizar en la ejecucion de las pruebas, ya que contiene aserciones para difentes tipos de datos, comparaciones, excepciones, arrays, entre otros. Para mas informacion revisar el [link](https://docs.phpunit.de/en/10.0/assertions.html)

#### Gestor de paquetes
------------
Composer es el gestor de dependencias que ofrece Laravel, se podrian utilizar otras herramientas pero destaca por los siguientes motivos.
- Composer es el gestor de dependencias mas popular en PHP, por lo tanto existe una gran cantidad de recursos y documentacion.
- Esta integrado con Packgist que es el repositorio central de paquetes de PHP, en la que los desarrolladores comparten sus librerias.
- Es compatible con Laravel, por lo que la integracion de dependencias sera mas sencilla.
- Es facil de instalar, al menos para Windows.
- El archivo composer.json es muy facil de entender y podemos configurar las versiones para facilitar la actualizacion y evitar conflictos. 
- Esta inspirado en NPM, que es el gestor más popular. 

Para más detalles de composer, click [aquí](https://getcomposer.org/)
   
   
#### ¿ Cómo realizar las pruebas?
------------
Ya que configurames Make al proyecto, configuraremos la tarea en el archivo Makefile

`test: 
	php artisan test
`

Agregamos las pruebas funcionales y unitarias. Despues de corregir los errores iniciales (Fallar para corregir), obtenemos el siguiente resultado. Para ejecutar las pruebas ejecutar el comando `make test` en el terminal.

![](https://raw.githubusercontent.com/SisChampions2024/blob/main/Docs/maketest.png)

  
  
  
  
 
 
