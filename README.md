# Proyecto Dart COCO

Un pequeño proyecto dart el cual consume la API FAKE STORE, empleando QuickType para la generación de modelos de datos y Either para el control de errores.
Se espera emplar el presente proyecto como paquete que pueda ser empleado por un proyecto flutter para consumir datos mediante este presente proyecto.
El proyecto aun no cuenta con tests unitarios x2. 😅

# Tabla de contenidos
1. [Introducción](#introduction)
2. [Agradecimientos](#thanks)
3. [Requerimientos](#requeriments)
4. [Documentación](#doc)
5. [Librerias](#libraries)
6. [Equipo de trabajo](#team)
7. [Conclusiones](#end) 

## Introducción
El presente proyecto esta desarrollado emplando principios de arquitectura limpia, el cual se ve reflejado en la estructuración de los paquetes y siguiendo algunos principios SOLID, al manejar contratos entre el repositorio y el punto de acceso desde donde se consume y ejecuta la información.

## Agradecimientos
Es indispensable agradecer a Alejandra Rodriguez Ruiz y Dolph Hincapié por el feedback y las recomendaciones hechas para la solucion del presente proyecto 👏🏻.

## Requerimientos
Para descargar el repositorio se requiere VSCode, AndroidStudio o cualquier editor de codigo que les facilite la lectura, compresión y compilación del proyecto.

## Documentación
El presente proyecto consume 3 servicios de Fake Store API:  
+ [Get all categories](https://fakestoreapi.com/products/categories):  
 		Este servicio retorna un listado de categorias existentes el cual solo contiene datos de tipo String, sin embargo en el proyecto se crea un modelo CategoriesModel con su respectiva clase mapper para convertir el formato Json al modelo y hacer el llamado posteriormente. Al ejecutar el archivo dart_coco_application.dart el output para este servicio sera:
```
=========================
Todas las categorias:
=========================
* electronics
* jewelery
* men's clothing
* women's clothing
```
+ [Get products in a specific category](https://fakestoreapi.com/products/category/electronics):  
		Este servicio retorna un listado de productos el cual tiene definido como modelo un listado de ProductModel con su respectiva clase mapper, el metodo getProductFromCategory el cual espera como parametro un String que representa a alguna de las categorias anteriores retorna el listado de productos correspondientes a este **(por defecto se envia la categoria electronics y solo se muestra en consola dos productos para no sobre cargar la vista en consola)**.
  El output para este servicio sera:  
```
=========================
Productos de la categoria 'electronics':
=========================
*****************
- Id producto: 9
- Titulo producto: WD 2TB Elements Portable External Hard Drive - USB 3.0 
- Precio producto: 64.0
- Descripción producto: USB 3.0 and USB 2.0 Compatibility Fast data transfers Improve PC Performance High Capacity; Compatibility Formatted NTFS for Windows 10, Windows 8.1, Windows 7; Reformatting may be required for other operating systems; Compatibility may vary depending on user’s hardware configuration and operating system
- Categoria producto: electronics
- Imagen producto: https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg
- Recuento de calificaciones: 203
- Tasa de calificación: 3.3
*****************
- Id producto: 10
- Titulo producto: SanDisk SSD PLUS 1TB Internal SSD - SATA III 6 Gb/s
- Precio producto: 109.0
- Descripción producto: Easy upgrade for faster boot up, shutdown, application load and response (As compared to 5400 RPM SATA 2.5” hard drive; Based on published specifications and internal benchmarking tests using PCMark vantage scores) Boosts burst write performance, making it ideal for typical PC workloads The perfect balance of performance and reliability Read/write speeds of up to 535MB/s/450MB/s (Based on internal testing; Performance may vary depending upon drive capacity, host device, OS and application.)
- Categoria producto: electronics
- Imagen producto: https://fakestoreapi.com/img/61U7T1koQqL._AC_SX679_.jpg
- Recuento de calificaciones: 470
- Tasa de calificación: 2.9
```
+ [Get all products](https://fakestoreapi.com/products):
		Este servicio retorna un listado de productos el cual tiene definido como modelo un listado de ProductModel con su respectiva clase mapper de igual manera al servicio anterior, el metodo getAllProducts retorna el listado de productos correspondientes a este **(solo se muestra en consola dos productos para no sobre cargar la vista en consola)**.
  El output para este servicio sera:
```
=========================
Todos los productos:
=========================
*****************
- Id producto: 1
- Titulo producto: Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops
- Precio producto: 109.95
- Descripción producto: Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday
- Categoria producto: men's clothing
- Imagen producto: https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg
- Recuento de calificaciones: 120
- Tasa de calificación: 3.9
*****************
- Id producto: 2
- Titulo producto: Mens Casual Premium Slim Fit T-Shirts 
- Precio producto: 22.3
- Descripción producto: Slim-fitting style, contrast raglan long sleeve, three-button henley placket, light weight & soft fabric for breathable and comfortable wearing. And Solid stitched shirts with round neck made for durability and a great fit for casual fashion wear and diehard baseball fans. The Henley style round neckline includes a three-button placket.
- Categoria producto: men's clothing
- Imagen producto: https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg
- Recuento de calificaciones: 259
- Tasa de calificación: 4.1
```

Para el control de errores se emplea Either proveniente de la libreria Dartz.  
Either es un tipo de dato el cual representa alguno de los dos tipos de datos definidos en su declaración, normalmente se emplea para el manejo de errores, haciendo uso de left o right para almacenar el valor correspondiente a los tipos definidos en izquierda o derecha.
```
Future<Either<ResponseError, List<ProductModel>>> getAllProducts() async {
    final url = getAllProductsUrl();
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return right(ProductMapper.productsFromJson(response.body));
    } else {
      return left(ResponseError('Ops!, ha ocurrido un error'));
    }
  }
```
Como se ve anteriormente, dependiendo del status de la respuesta del servicio, almacenaremos un valor ya sea en right o left de acorde a la posicion en los que se define los tipos de datos del Either, se emplea tambien futures para ejecutar las peticiones de forma asincrona.

Para acceder a estas respuestas, empleamos fold para evaluar el resultado de la petición y actuar en consecuancia como se muestra a continuación:  
```
final responseProducts = await catalog.getAllProducts();
responseProducts.fold((error) => print(error.message),
      (products) => printProductsFromCategories(products));
```
De esta manera controlamos las excepciones que puedan suceder al consultar la petición. En este caso, al ocurrir un error durante el consumo del servicio, este devuelve un mensaje de error denominado 'Ops!, ha ocurrido un error'  

 ## Librerias
 A continuación se comparte las librerias empleadas:  
	* [http](https://pub.dev/packages/http)  
 	* [dartz](https://pub.dev/packages/dartz)  

 ## Equipo de trabajo
 Su servidor Antony Raul Cristobal Zambrano desde Perú 🇵🇪

 ## Conclusiones
 Al desarrollar el presente proyecto se logro poner en practica los conceptos de arquitectura limpia, control de errores, peticiones http y principios SOLID los cuales son empleados en diferentes proyectos que se encuentran en el mercado.
 Espero que este proyecto cumpla con sus expectativas y sirva como referencia crear proyectos Dart para el consumo de API's externas 🩵.
