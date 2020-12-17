# Undécima semana, 1 de diciembre

Incluye la siguiente semana que no hay clase

## Objetivos de la semana

## Otros objetivos

- Errores frecuentes en la entrega del hito 5
  - La rúbrica 1 lo que pedía era que se justificara la configuración
    del repositorio *completa*, no sólo la conexión. Cada sistema
    tendrá una configuración específica. También habrá que explicar
    qué se ha hecho en la función de tu proyecto para adaptarla al
    entorno serverless.
  - 200 no es el status que se devuelve siempre, es el que se devuelve
    cuando el resultado es correcto. Para indicar que no se ha
    encontrado o no existe, se debe devolver 404.
  - También se puede usar el error 400 (como Antonio Revelles) si hay
    un error en el query string.
  - Nunca se devuelve error 500. Ese error es cuando no funciona la
    aplicación. Si no funciona, no puede devolver error 500.
  - Poner un front-end Telegram para hacer peticiones a otro endpoint
    URL es una muy mala idea. Si los dos proyectos tienen origen en el
    mismo, simplemente habría que hacer que los datos se cogieran del
    mismo origen. Eso le va a añadir latencia y acoplar fuertemente el
    uno al otro.
  - Seguimos con los issues "Hacer no sé qué en Vercel" o "Crear
    fichero no sé cuanto". Los issues son problemas a resolver, no
    tareas que haya que hacer literalmente.
- [Entender el diseño de rutas en este ejemplo](https://github.com/JJ/node-app-cc/blob/master/lib/index.js).
  - Comprender también el concepto de clases controladoras, esenciales
    al concepto de "única fuente de verdad", y cómo se desacoplan los
    microservicios del resto.
- Entender el concepto de *inyección de dependencias* y *single
    source of truth* ⇒ Si se va a usar acceso a datos, es mejor
    empezar desde este momento.
- [Tests de integración](http://jj.github.io/IV/documentos/temas/Microservicios#probando-nuestra-aplicaci%C3%B3n-en-la-nube).
- [Microservicios en producción](http://jj.github.io/IV/documentos/temas/Microservicios#microservicios-en-producci%C3%B3n),
  que ya corresponde al hito siguiente sobre [PaaS](http://jj.github.io/IV/documentos/temas/PaaS).

## Material de este periodo

- Entender
  los
  [tests de integración](http://jj.github.io/IV/documentos/temas/Microservicios#microservicios-en-producci%C3%B3n) y
  otros temas relacionados con los microservicios.
- Comenzamos con [PaaS](http://jj.github.io/IV/documentos/temas/PaaS).

## Plazos en este periodo

- Entregar
  el
  [hito 6](http://jj.github.io/IV/documentos/proyecto/6.Microservicio) la
  siguiente semana.


## Siguiente semana

[Semana décimo tercera](semana-13.md).
