# Hito 5

#### Justificación técnica del framework elegido para el microservicio
------------

Se optó por el framework Laravel, basado en el lenguaje de programación PHP, para la implementación del microservicio. La elección de este framework se fundamenta principalmente en su nivel de aprendizaje intermedio, junto con su capacidad para proporcionar una capa de enrutamiento eficiente y gestionar de manera efectiva las solicitudes HTTP. Esta característica es crucial en el contexto de microservicios, donde la comunicación entre servicios se lleva a cabo mediante solicitudes HTTP y APIs RESTful.

Adicionalmente, cabe destacar que Laravel es ampliamente aceptado dentro de la comunidad de PHP debido a su elegancia y sintaxis clara. Este respaldo se fundamenta en la revisión de la literatura realizada previamente a la elección, donde se destacaron los puntos mencionados a continuación: 

- Integra un sistema de enrutamiento.
- Ofrece una capa de abstracción de base de datos denominada Eloquent.
- Simplifica el uso de migraciones para administrar esquemas de base de datos.
- Dispone de soporte para colas (queues), lo cual resulta beneficioso para la ejecución de tareas en segundo plano.
- Posibilita la programación de tareas mediante su sistema integrado.
- Incluye funcionalidades integradas para la autenticación de usuarios.
- Brinda capacidades incorporadas para la autorización y la gestión de permisos.
- Engloba otras características valiosas al desarrollar aplicaciones distribuidas.


#### Diseño en general del API.
------------

Laravel, siendo un framework de PHP, sigue el patrón de diseño Modelo-Vista-Controlador (MVC). En consecuencia, los recursos generados se estructuran en la carpeta "Controllers" para definir las lógicas de control, mientras que los modelos de bases de datos se sitúan en la carpeta "Model".

Al crear el modelo, se utiliza un comando específico en el cual se definen las relaciones con otras tablas del sistema.
```
php artisan make:model Currency
```
Tal como hemos señalado en etapas previas, Eloquent actúa como el ORM (Mapeo Objeto-Relacional) incorporado en el framework Laravel. Esto posibilita la interacción con bases de datos, simplificando el acceso y proporcionando diversas funcionalidades predefinidas para llevar a cabo operaciones sobre dichas bases de datos.


Para establecer las rutas, es necesario realizar su configuración en el archivo correspondiente. [routes/api.php](https://github.com/MigueTimberland/SisChampions2024/blob/main/scambia-api/routes/api.php). En este archivo, configuraremos todos los recursos de nuestro sitio, ya que estos representan todas las operaciones de nuestra API Restful.


```
<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\PlaceController;
use App\Http\Controllers\SchoolController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


Route::apiResource('places', PlaceController::class);

Route::group(['middleware' => 'api','prefix' => 'auth'], function () {
    Route::post('login',[AuthController::class,'login']);
    Route::post('logout',[AuthController::class,'logout']);
    Route::post('refresh',[AuthController::class,'refresh']);
    Route::post('register',[AuthController::class,'register']);
    Route::get('me',[AuthController::class,'me']);
    Route::apiResource('schools', SchoolController::class);
});

```

Para probar nuestras API's hemos utilizando Postman, realizando las peticiones correspondientes a los recursos HTTP creados.

POST:

![](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/prueba_post_1.png)


![](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/tabla_user.png)


![](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/prueba_post_2.png)


GET:

![](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/prueba_get_1.png)


![](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/prueba_get_2.png)


#### Uso de logs.

------------

Laravel emplea Monolog para la generación de registros (logs), una biblioteca de registro flexible y potente ampliamente reconocida en la comunidad PHP. Cabe destacar que su configuración es bastante sencilla.

En el archivo [config/logging.php](https://github.com/MigueTimberland/SisChampions2024/config/logging.php). En esta situación, se establecen los canales con la posibilidad de configurar el envío de registros a una dirección de correo electrónico o su almacenamiento en una base de datos. En este escenario particular, se ajustará la configuración para que los registros se almacenen de manera diaria en una carpeta específica.

![](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/logging.png)

Se han incorporado los siguientes niveles de registro dentro de nuestra API:

- Información (INFO).
- Advertencia (WARNING).
- Error (ERROR).

Los controladores de las APIs incluyen código adicional para gestionar los errores y proporcionar la capacidad de revisar el registro, permitiendo así visualizar las solicitudes realizadas a las APIs junto con los datos de la petición.

![](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/api2.png)

![](https://github.com/MigueTimberland/SisChampions2024/blob/main/Docs/api1.png)