# Décimo cuarta semana, 22 de diciembre

Última semana del año.

## Objetivo de esta semana

## Objetivos adicionales

- Errores frecuentes en la práctica
  - ¿Qué pasa con etcd?
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
  - Seguís sin usar HUs, ni poner bien los issues, ni hacer buenos
    mensajes de commits (en general).
    
## Material de esta semana

Última práctica

## Plazos en este periodo

- Entregar el
  [hito 7](http://jj.github.io/IV/documentos/proyecto/7.Paas): día **14
  de enero**.
