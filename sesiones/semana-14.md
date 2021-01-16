# Décimo cuarta semana, 22 de diciembre

Última semana del año.

## Objetivo de esta semana

- Entender la arquitectura de aplicaciones en
  plataformas-como-servicio.
- Conocer los servicios más comunes.
- Conocer los conceptos relacionados con el proceso de virtualización
  tanto de software como de hardware y ponerlos en práctica.

## Objetivos adicionales

- [Ejemplo de aplicación](http://jj.github.io/IV/documentos/temas/PaaS#creando-un-bot-de-telegram-para-heroku) de
  un bot en Telegram para Heroku: uso de variables de configuración,
  modos de empleo, logging, uso de contenedores Docker para el
  despliegue.
- [Desplegando en Heroku](http://jj.github.io/IV/documentos/temas/PaaS#desplegando-en-el-paas) usando
  la línea de órdenes.
- Errores frecuentes en la práctica
  - Antipatrón: Conversación que hay en el grupo alternativo de clase
    1. ¿Qué hay que poner aquí?
    2. Pon esto
    3. "esto" está siempre mal o no cubre la rúbrica. Pero lo peor es
       que "esto" se parece a lo que han escrito otros 10 estudiantes
       en mayor o menor medida, así que canta a la legua con que el
       profesor se moleste lo más mínimo en corregir. Además,
       evidencia falta de interés y de trabajo autónomo por parte del
       estudiante. En el siguiente hito, cualquier evidencia en esta
       dirección hará que se pierda el punto de trabajo
       autónomo. Decidid en el siguiente hito si os merece la pena
       perder ese punto (y dependiendo del grado de fidelidad de
       "esto" con el resto de los compañeros y/o advertencias
       anteriores, suspender para la convocatoria extraordinaria).
    4. Por otro lado, "esto" muchas veces se puede resolver de la
       forma más simple con una pregunta de algún concepto que no se
       entienda en los grupos reales de clase o preguntando a los
       profesores, que aunque nunca te dirán qué hay que poner, te
       orientarán por lo menos en la dirección correcta.
    5. El problema principal es que *no hay una forma de hacer las
       cosas*. Se valora que encuentres tu propia forma, no que copies
       la forma de otra persona. Lo importante no es el resultado, es
       lo que se aprenda por el camino.
  - Antipatrón: Issue abierto con "Haz esto". Issue cerrado con un
    commit que dice "Se ha hecho esto". Los issues son problemas a
    resolver, y siempre tienen que estar en relación con una HU.
      - Seguís sin usar HUs, ni poner bien los issues, ni hacer buenos
        mensajes de commits (en general). Hay quien lo hace bien, pero
        en general, no.

  - ¿Qué pasa con `etcd`?
    - Imagino que por medio o un punto no merece la pena. Pero es que
      debíais haberlo mirado cuando lo dimos hace casi un
      mes. Realmente es un componente muy importante de las
      arquitecturas en la nube.
  - Justificación no técnica del framework elegido. Especialmente si
    se ha elegido Express.
    - Si hacéis comparaciones de velocidad, hacedlo con *vuestro*
      API. Las comparacciones genéricas pueden o no servir. Y en todo
      caso, ¿vais a notar 1000 o el número de peticiones por segundo
      que digáis en vuestro caso?
    - Si usáis cosas tipo `ab` no uséis números arbitrarios. El nivel
      y la calidad de servicio deben establecerse en una HU.
  - Las rutas deben construirse alrededor de un recurso, y por tanto
    deben empezar por un sustantivo que designe al recurso.
    - Si sabes el URI, usa PUT para crear el recurso
    - Usa POST si no lo sabes.
    - GET nunca crea recursos, es idempotente.
    - No pongáis `/api` al principio de las rutas. Tiene su uso
      específico, no es este.
  - No pongáis como instalar nada.

## Material de esta semana

Última práctica
  [sobre PaaS](http://jj.github.io/IV/documentos/temas/PaaS),
  [hito 7](http://jj.github.io/IV/documentos/proyecto/7.Paas). Entrega: día **14
  de enero**.
