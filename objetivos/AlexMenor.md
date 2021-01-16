# Objetivos de Alex en IV

## Primera semana

- [x] Entender la metodología docente, de evaluación y de interacción de la asignatura.
- [x] Darse de alta (si no se está) y comprender el funcionamiento básico de GitHub y el grupo de Telegram de la asignatura y conocer el resto de los recursos de la misma.
- [x] Entender el concepto de software libre y su aplicación práctica en esta asignatura.
- [x] Vernos las caras.
- [x] Explicar el [hito 0](http://jj.github.io/IV/documentos/proyecto/0.Repositorio). Fecha de entrega: martes 29 de septiembre, 11:30 de la mañana.
- [x] Empezar a usar git y GitHub. Por ejemplo, [seguir este vídeo](https://www.youtube.com/watch?v=gmXyJI01qa8) o cualquier otro tutorial online.

## Segunda semana

- [x] Conocer un poco más la Computación Virtual, de dónde surgió y por qué.
- [x] Familiarizarme más con el concepto de virtualización.
- [x] Indagar un poco en la virtualización a nivel de SO y técnicas hardware.
- [x] Tener una visión global sobre la Infraestructura Virtual.
- [x] Leer sobre los _X as a service_.
- [x] Aprender sobre el sistema de issues, hitos y estructuración del proyecto de la asignatura.

## Tercera semana

- [x] Entender la importancia de los tests y su relación con devops.
- [x] Entender los beneficios de user un gestor de versiones versus versiones de repositorio de diferentes lenguajes de programación.
- [x] Entender los ficheros de requisitos o dependencias y su utilidad en las infraestructuras virtuales.

## Cuarta semana

- [x] [Ver video sobre QA:](https://youtu.be/wD_og-3KOsE)
- [x] Investigar despliegue de contenedores en algún PaaS como Heroku
- [x] Leer algo sobre orquestación de contenedores
- [x] Investigar el billing de registros de contenedores de pago

## Quinta semana

- [x] Darse de alta en algún servicio de integración continua que no haya probado: https://github.com/AlexMenor/autoevaluacion-iv/blob/master/integracion-continua/circleci.png
- [x] Configurar algún servicio de integración continua que no haya probado: https://github.com/AlexMenor/autoevaluacion-iv/blob/master/integracion-continua/circleci-config.png

# Sexta semana

- [x] Entender los diferentes niveles de abstracción que llevan a construir una aplicación para la nube.
- [x] Entender la importancia de los sistemas de configuración distribuida y su utilidad en despliegues en la nube.
      He seguido la (documentación de etcd)[https://etcd.io/docs/v3.4.0/dev-guide/local_cluster/] para (probarlo en local.)[https://github.com/AlexMenor/autoevaluacion-iv/blob/master/microservicios/etcd.png]
- [x] Entender cómo funciona la inyección de dependencias (o algo por el estilo).
      Estoy familiarizado con la inyección de dependencias, no tanto con como se implementa en python, por eso me he leído (esta pregunta)[https://stackoverflow.com/questions/2461702/why-is-ioc-di-not-common-in-python] de Stack Overflow.
- [x] Entender la importancia de los sistemas de log.
      Investigar el estado del arte, en este caso he leído sobre (ELK Stack.)[https://www.elastic.co/es/what-is/elk-stack]

# Séptima semana

- [x] Entender el concepto de serverless y su uso en entornos cloud. Me he dado de alta en vercel y he hecho [el despliegue](https://serverless-vercel-seven.vercel.app/api/date) de [una función.](https://github.com/AlexMenor/serverless-vercel)
- [x] Entender los casos de uso de esta tecnología.
- [x] Mirar frameworks serverless como [serverless](https://www.serverless.com/framework/docs/getting-started/)

# Octava semana

- [x] Entender el concepto de webhook. He hecho [un ejercicio](https://github.com/AlexMenor/autoevaluacion-iv/blob/master/serverless/webhook.md) que reconstruye una blog jamstack usando dev.to como CMS, que llama mediante un webhook a la reconstrucción del sitio cuando un artículo ha sido creado o modificado.
- [x] Entender el manejo de los productos cloud de diferentes empresas.
- [x] Entender el concepto de continuous delivery o publicación continua.
- [x] Entender los casos de uso para las funciones-como-servicio. He leído [este](https://martinfowler.com/articles/serverless.html) artículo para entenderlo mejor.
- [x] Entender el concepto de observabilidad.

# Novena semana

- [x] Entender qué es un test de integración
- [x] Enteder la importancia de los logs para la observabilidad. Me he registrado en Papertrail y he hecho [una prueba](https://github.com/AlexMenor/autoevaluacion-iv/tree/master/microservicios/logging) desde Python.
- [x] Entender el concepto de ruta, middleware y URI.

# Décima semana

- [x] Usar etcd en un módulo de configuración. [Lo he usado en el proyecto](https://github.com/AlexMenor/que-vemos/blob/master/app/config/config.py)
- [x] Buscar información sobre mejores prácticas para un microservicio escrito en python en producción. [He leído esto.](https://fastapi.tiangolo.com/deployment/manually/)

# Última semana

- [x] Usar otro PaaS distinto a Heroku:
	- He creado [un workflow](https://github.com/AlexMenor/que-vemos/blob/master/.github/workflows/deploy-to-digital-ocean.yml) en mi proyecto para hacer push al registro de contenedores de digital ocean.
	- [Aquí](https://github.com/AlexMenor/autoevaluacion-iv/blob/master/paas/do-deploy.png) el deploy en App platform
	- [Aquí](https://github.com/AlexMenor/autoevaluacion-iv/blob/master/paas/do-working.png) mi microservicio funcionando en digital ocean
