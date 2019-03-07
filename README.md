# Exposición de arte

Se va a realizar una exposición de arte visual.
 Nos piden desarrollar un modelo de objetos para manejar las obras que se van a presentar, 
 y las consecuencias de algunas actividades que se van a llevar a cabo.

Este modelo aplica a una sola exposición,
que por lo tanto se puede modelar como un objeto bien conocido.


## Obras, colores, ingresos, estadísticas

En esta primera etapa, debemos generar un primer modelo de la exposición,
 y modelar artistas, colores y obras.

De cada **artista** debemos registrar quién fue su maestro. P.ej. 
```
raulSoldi.setMaestro(juanCastagnino)
```

Cada **color** se modela como un objeto bien conocido.
Se brinda el archivo `colores.wlk` donde están definidos los colores que vamos a usar en este desarrollo.

De cada **obra** debemos registrar: el autor, qué colores tiene, 
cuántas personas se estima que la vieron.  
Vamos a contemplar dos tipos de obras: **pintura** y **fotografía**.
Se dice que una pintura _es relevante_ si la vieron más de 10000 personas. 
Para una fotografía, la condición es tener más de tres colores.
Para las pinturas se registra un dato adicional: el nivel de desgaste, que es un número.

Respecto de la exposición, deben registrarse los artistas que formarán parte del jurado.

Se pide armar un modelo que permita:
* consultar, dado un artista, si _es influyente_ para la exposición.

 La condición es que el artista haya sido el maestro de, al menos, 
 
 uno de los miembros del jurado de la exposición.  
 
P.ej. si Raúl Soldi está en el jurado, 

entonces Juan Castagnino es influyente para la exposición.

* _registrar el ingreso_ de una obra a la exposición: simplemente,
 se agrega la obra a una lista de obras que forman parte de la exposición.

* a partir de esto, 
averiguar cuáles de las obras que forman parte de la exposición _deben ser restauradas_.
 Una pintura debe ser restaurada si su desgaste es de 200 puntos o más. 
 Una fotografía nunca debe ser restaurada.

* consultar si la exposición _es brillante_:
 la condición es que todas las obras que forman parte de la exposición sean relevantes.

* adicionalmente, realizar estas consultas respecto de la exposición:
 el conjunto de autores de las obras que forman parte, 
 la cantidad de obras de un artista,
  el conjunto de obras cuyo autor es influyente para la exposición,
   y el artista con más obras en la exposición.


Como ejemplo, consideremos estas obras:
* "Juanito", pintura de Horacio Cóppola, la vieron 20000 personas,
 su nivel de desgaste es 240. Colores: azul, verde y rojo.
* "Rosita", pintura de Juan Castagnino,
 la vieron 15000 personas, su nivel de desgaste es 80.
  Colores: amarillo y fucsia.
* "La fiesta", fotografía de Horacio Cóppola,
 la vieron 8000 personas.
  Colores: rojo, marrón, fucsia y naranja.
* "Persona en una botella", 
fotografía de Grete Stern,
 la vieron 18000 personas. Colores: verde y amarillo.  

Si las obras que forman parte de la exposición son "Juanito", "Rosita" y "La fiesta", 
entonces tenemos: autores Horacio Coppola y Juan Castagnino,
 2 obras de Coppola y 1 de Castagnino, artista con más obras Coppola,
  la exposición es brillante (porque todas las obras son relevantes).
   La única obra que debe ser restaurada es "Juanito".

Si agregamos "Persona en una botella", 
ahora los autores son Coppola, Castagnino y Grete Stern,
 el artista con más obras sigue siendo Coppola,
  ahora la exposición no es brillante 
  (porque "Persona en una botella" no es relevante).

Armar tests que verifiquen estas condiciones
, y también que Juan Castagnino es influyente para la exposición,
 poniendo como jurados a Raúl Soldi y Antonio Berni 
 (y sin olvidar de asignar a Castagnino como maestro de Soldi). 
Verificar que la única obra de autor influyente es "Rosita".  


**¡OJO!**  
cada consulta que se piden respecto de la exposición deben ser resuelta enviándole _un_ mensaje a la exposición. P.ej. para saber el artista con más obras, la consulta debe ser algo así:
```
exposicion.artistaConMasObras()
```

## Condiciones de ingreso
En esta etapa, 
se agrega el análisis de los requisitos que debe cumplir una obra para poder ser aceptada
 como parte de la exposición.
 
Para todas las **obras** se pide que entre sus colores tengan rojo,
 amarillo o naranja.

* Para las **pinturas** se pide que la haya visto,
 al menos, una cantidad de personas que se establece en la exposición. 
 En principio este valor es de 6000, o sea, 
 la condición adicional es que al menos 6000 personas hayan visto la obra.
  Pero este valor tiene que poder cambiarse enviándole un mensaje a la exposición. 

* Para las **fotografías** se agregan dos condiciones.
 Una es la hayn visto, al menos, 
 la misma cantidad de personas que se piden para una pintura _más 1000_. 

P.ej., si se pide que una pintura haya sido vista por al menos 6000 personas,
 entonces para una fotografía hay que pedir al menos 7000. 
 La otra condición es que tenga el marrón o el verde entre sus colores.
 

Además,

 la **exposición** no permite que formen parte obras cuyos autores sean miembros del jurado,
 y también que haya más de una obra del mismo autor si es un artista influyente para la exposición 
 (los artistas que no son ni parte del jurado ni influyentes, pueden tener todas las obras que quieran).
  
Se pide agregar al modelo la posibilidad de
* preguntar si una obra _cumple con los requisitos_ para formar parte de la exposición.
 Acá evaluar solamente las condiciones relacionadas con la obra, o sea,
  no van las restricciones relacionadas con el autor.

* preguntarle a la exposición si una obra _está inhabilitada_. 
Acá evaluar las restricciones relacionadas con el autor.

* preguntarle a la exposición si una obra _puede formar parte_.
 La condición es que la obra cumpla con los requisitos, y además no esté inhabilitada.

* indicarle a la exposición a que _incorpore_ una obra.
 Si la obra puede formar parte de la exposición,
  entonces se registra el ingreso. Caso contrario, debe generarse un error.

* preguntarle a la exposición si _está bien armada_.
 La condición es que todas las obras que forman parte de la exposición, 
 cumplan las condiciones correspondiente 
 (tanto las relacionadas con la obra como las del autor). 


## Muestras cromáticas

Agregar el manejo de **muestras cromáticas**,
 que son actividades que se organizan dentro del ámbito de la exposición. 
 Cada muestra cromática está asociada a un color, 
 y se desarrolla durante una cantidad de días.
  Un ejemplo es una muestra asociada al amarillo que dura 5 días.

Para cada muestra se define qué obras se van a incluir,
 de entre las que forman parte de la exposición.
  Cualquier obra puede incluirse en la muestra, tenga o no el color asociado. 
  En la muestra que pusimos como ejemplo,
   pueden incluirse p.ej. tanto "Juanito" (que no tiene amarillo) 
   como "Angeles" (que sí tiene amarillo).   

Para cada obra incluida en la muestra:
- si tiene el color de la muestra, 
entonces se suman a la cantidad de personas que se estima que la vieron, 
el resultado de multiplicar la cantidad de visitas 
por día asociada al color por la cantidad de días que dura la muestra.
- en caso contrario, se suma la mitad de esa cantidad.

Para las **pinturas** se agrega otra condición: 
se suma un punto de desgaste por cada día de la muestra.

En el ejemplo, por formar parte de la muestra
- a "Juanito" se le suman 2500 personas que se estima que la vieron 
(1000 visitas por día del color amarillo * 5 da 5000, 
para "Juanito" la mitad porque no tiene amarillo), y 5 puntos de desgaste.
- a "Angeles" se le suman 5000 personas que se estima que la vieron.
 Como no es una pintura, no se suma desgaste.


Se pide agregar al modelo
* el registro de una muestra que se incluye en la exposición, 
que ya tiene incorporadas las obras que incluye. 
Esto implica: 
agregar la muestra a un conjunto de muestras realizadas que hay que agregar al modelo de la exposición, 
y aplicarle a cada obra incluida las consecuencias de estar en la muestra.
* la consulta sobre el total de días de muestras organizadas dentro de la exposición.































## Esculturas

Agregar al modelo un tercer tipo de obra, les **esculturas**.
 De cada escultura se sabe (además de los datos comunes a todas las obras) 
 el peso en kilos, y un conjunto de artistas (aparte del autor) 
 que colaboraron con su concepción.  

Una escultura se considera _relevante_ si pesa más de 200 kilos,
 o colaboró con su concepción el maestro del autor.

Como _requisito_ para ser aceptada como parte de la exposición,
 además del común a todas las obras, se agrega que pese menos de 500 kilos.



 














