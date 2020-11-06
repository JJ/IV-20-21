# Sexta semana, comienza el 3 de Noviembre.

## Objetivos de la semana

* Entender los diferentes niveles de abstracción que llevan a
  construir una aplicación para la nube.
* Entender la importancia de los sistemas de configuración distribuida
  y su utilidad en despliegues en la nube.
* Entender cómo funciona la inyección de dependencias (o algo por el
  estilo).
* Entender la importancia de los sistemas de log.

## Otros objetivos


* Un
  [fichero travis](https://github.com/JJ/tests-python/blob/master/.travis.yml) y
  [cómo se ha llegado hasta él](https://travis-ci.com/github/JJ/tests-python/builds).
* Entender
  [la configuración distribuida](http://jj.github.io/IV/documentos/temas/Microservicios#creando-un-microservicio-desde-cero) y
  como manejarla en un microservicio.
* Reentregar el hito 3 una vez corregido.
* Errores comunes en el hito 3
  * Comparaciones que se limitan a varias versiones de las imágenes
    "oficiales", sobre todo en JavaScript. Deberían probar quizás
    no-oficiales o construir desde 0 usando el sistema
    operativo. Igual el resultado sorprendía. O incluso varias
    versiones de la misma versión de node.
    * Tampoco se enlaza la versión del Dockerfile usada en las
      diferentes pruebas. Puede ser la versión en un commit
      determinado, no hace falta que sea un fichero que esté en el
      repo (salvo la versión elegida).
    * Si todos lo habéis hecho así porque representa el mínimo
      esfuerzo, *mal*. Si todos lo habéis hecho así porque alguien lo
      ha sugerido, *mal*. Ya es casualidad que con 200 imágenes que
      hay en Docker Hub, todos hayáis elegido comparar las tres
      mismas. Nadie ha
      probado
      [esta imagen de ubuntu](https://hub.docker.com/r/tbaltrushaitis/ubuntu-nodejs),
      por ejemplo.
    * Muy pocos han documentado los Dockerfiles usados en esas
      pruebas. En algunos casos hay pantallazos con el tamaño de la
      imagen resultante, pero nunca el Dockerfile. En concreto, los
      Dockerfiles de Alpine y de Debian (los slim) son totalmente
      diferentes. Por ejemplo, si las construyes también en Docker Hub
      simplemente hay que enlazar el build correspondiente (que apunta
      al commit en el que se ha hecho)
      


## Material para la clase

La sección sobre [integración
continua](http://jj.github.io/IV/documentos/temas/Desarrollo_basado_en_pruebas#a%C3%B1adiendo-integraci%C3%B3n-continua) es
parte el capítulo sobre desarrollo basado en pruebas.

* Comenzamos
  [microservicios](http://jj.github.io/IV/documentos/temas/Microservicios),
  pero empezamos por lo más básico: configuración.
  
- Seguimos con
  el
  [cuarto hito](http://jj.github.io/IV/documentos/proyecto/4.CI). La
  entrega es el viernes 6 de noviembre a las 23:59 horas.

## Siguiente semana

[Octava semana](semana-08.md).
