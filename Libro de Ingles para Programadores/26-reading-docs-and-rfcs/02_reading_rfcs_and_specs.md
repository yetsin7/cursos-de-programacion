# Lesson 02: Reading RFCs and Specifications

## Introduccion

Los RFCs (Request for Comments) son documentos que definen los estandares de Internet. Si alguna vez te has preguntado como funciona HTTP, WebSocket, JWT o el email, la respuesta esta en un RFC. Aprender a leerlos te da un entendimiento profundo de las tecnologias que usas todos los dias.

---

## Que es un RFC?

RFC significa **Request for Comments** (Solicitud de Comentarios). A pesar del nombre humilde, los RFCs son los documentos que definen los estandares de Internet.

| Dato | Detalle |
|------|---------|
| **Organizacion** | IETF (Internet Engineering Task Force) |
| **Formato** | Texto plano, numerados secuencialmente |
| **Primer RFC** | RFC 1 (1969) - "Host Software" |
| **Total** | Mas de 9000 RFCs publicados |
| **Idioma** | Siempre en ingles |
| **Acceso** | Gratuito en tools.ietf.org y rfc-editor.org |

### RFCs famosos que todo programador deberia conocer

| RFC | Nombre | Que define |
|-----|--------|-----------|
| RFC 2616 / 7230-7235 | HTTP/1.1 | El protocolo HTTP |
| RFC 6455 | WebSocket | El protocolo WebSocket |
| RFC 7519 | JWT | JSON Web Tokens |
| RFC 7231 | HTTP Semantics | Metodos HTTP y codigos de estado |
| RFC 8259 | JSON | El formato JSON |
| RFC 5321 | SMTP | El protocolo de email |
| RFC 2119 | Key Words | Palabras clave para RFCs (MUST, SHALL...) |
| RFC 3986 | URI | Sintaxis de URIs |
| RFC 6749 | OAuth 2.0 | Autorizacion OAuth |
| RFC 7540 | HTTP/2 | El protocolo HTTP/2 |

---

## Estructura de un RFC

Todo RFC sigue una estructura similar. Conocerla te permite navegar cualquier RFC rapidamente.

### Secciones principales

| Seccion | Que contiene | Importancia |
|---------|-------------|-------------|
| **Abstract** | Resumen de 1-2 parrafos | Lee siempre primero |
| **Status of This Memo** | Estado del documento (Draft, Proposed, Standard) | Indica madurez |
| **Table of Contents** | Indice de secciones | Usa para navegar |
| **1. Introduction** | Contexto y motivacion | Lee para entender el "por que" |
| **2. Terminology** | Definiciones de terminos | Consulta cuando no entiendas algo |
| **3-N. Specification** | El contenido tecnico principal | La parte mas importante |
| **Security Considerations** | Implicaciones de seguridad | Critico para implementar bien |
| **IANA Considerations** | Registros con IANA | Solo si necesitas registrar algo |
| **References** | Documentos relacionados | Util para profundizar |
| **Authors' Addresses** | Contacto de los autores | Informativo |

---

## RFC 2119: Las palabras clave

El RFC 2119 es probablemente el mas importante para leer otros RFCs. Define el significado exacto de palabras clave que encontraras en TODOS los demas RFCs.

### Las palabras clave y su significado

| Palabra clave | Significado | Nivel de obligacion |
|--------------|-------------|---------------------|
| **MUST** | Es obligatorio, no hay excepcion | 100% requerido |
| **MUST NOT** | Esta absolutamente prohibido | 100% prohibido |
| **REQUIRED** | Igual que MUST | 100% requerido |
| **SHALL** | Igual que MUST (mas formal) | 100% requerido |
| **SHALL NOT** | Igual que MUST NOT (mas formal) | 100% prohibido |
| **SHOULD** | Recomendado, pero hay excepciones validas | Fuertemente recomendado |
| **SHOULD NOT** | No recomendado, pero hay excepciones | Fuertemente desaconsejado |
| **RECOMMENDED** | Igual que SHOULD | Fuertemente recomendado |
| **MAY** | Es completamente opcional | Opcional |
| **OPTIONAL** | Igual que MAY | Opcional |

### Como identificarlas

Cuando estas palabras aparecen **EN MAYUSCULAS** en un RFC, tienen su significado tecnico preciso:

```
The server MUST respond with a 200 status code.
   -> Es OBLIGATORIO que el servidor responda con 200.

The client SHOULD include an Accept header.
   -> Es RECOMENDADO pero no obligatorio incluir Accept.

The implementation MAY support compression.
   -> Es OPCIONAL soportar compresion.

The server MUST NOT send a body in response to a HEAD request.
   -> Esta PROHIBIDO enviar un body en respuesta a HEAD.
```

---

## Ejemplo practico: Leyendo RFC 7519 (JWT)

Veamos como leer secciones reales de un RFC.

### El Abstract

```
JSON Web Token (JWT) is a compact, URL-safe means of representing
claims to be transferred between two parties.  The claims in a JWT
are encoded as a JSON object that is used as the payload of a JSON
Web Signature (JWS) structure or as the plaintext of a JSON Web
Encryption (JWE) structure, enabling the claims to be digitally
signed or integrity protected with a Message Authentication Code
(MAC) and/or encrypted.
```

**Desglose del vocabulario:**

| Termino | Significado |
|---------|-------------|
| **compact** | Compacto, de tamano reducido |
| **URL-safe** | Seguro para usar en URLs |
| **means of representing** | Forma de representar |
| **claims** | Afirmaciones/declaraciones (datos que el token contiene) |
| **transferred between two parties** | Transferidas entre dos partes |
| **encoded** | Codificado |
| **payload** | Carga util (los datos que transporta) |
| **digitally signed** | Firmado digitalmente |
| **integrity protected** | Protegido en su integridad |
| **encrypted** | Cifrado |

### La Terminologia

```
NumericDate
   A JSON numeric value representing the number of seconds from
   1970-01-01T00:00:00Z UTC until the specified UTC date/time,
   ignoring leap seconds.
```

Las definiciones en la seccion de terminologia son **muy precisas**. Cada palabra importa.

### La Especificacion

```
The following Claim Names are registered in the IANA "JSON Web Token
Claims" registry:

- "iss" (Issuer) Claim: identifies the principal that issued the JWT.
- "sub" (Subject) Claim: identifies the principal that is the subject.
- "aud" (Audience) Claim: identifies the recipients.
- "exp" (Expiration Time) Claim: identifies the expiration time on or
  after which the JWT MUST NOT be accepted for processing.
```

Nota como usan **MUST NOT** (en mayusculas): es absolutamente prohibido aceptar un JWT expirado.

---

## Ejemplo: RFC 6455 (WebSocket)

### Opening Handshake

```
The opening handshake is intended to be compatible with HTTP-based
server-side software and intermediaries, so that a single port can
be used by both HTTP clients talking to that server and WebSocket
clients talking to that server.

The client's opening handshake consists of the following:

1. A Status-Line with a method of GET and a Request-URI
2. A |Host| header field containing the server's authority
3. An |Upgrade| header field with value "websocket"
4. A |Connection| header field with value "Upgrade"
5. A |Sec-WebSocket-Key| header field with a base64-encoded value
```

**Vocabulario tecnico del RFC:**

| Termino | Significado |
|---------|-------------|
| **handshake** | Protocolo de inicio de conexion |
| **intermediaries** | Intermediarios (proxies, load balancers) |
| **single port** | Un solo puerto |
| **consists of** | Consiste en, esta compuesto de |
| **header field** | Campo de cabecera |
| **base64-encoded** | Codificado en base64 |

---

## Como leer un RFC eficientemente

### Paso 1: Lee el Abstract y la Introduccion

Te dan el contexto general. Si no entiendes de que trata el RFC, no podras leer el resto.

### Paso 2: Revisa la Terminologia

Antes de leer la especificacion, asegurate de entender los terminos definidos.

### Paso 3: Lee la especificacion con las palabras clave

Presta atencion especial a MUST, SHOULD y MAY. Te dicen que es obligatorio, recomendado y opcional.

### Paso 4: Revisa Security Considerations

Esta seccion es critica si vas a implementar el protocolo. Te dice que puede salir mal.

### Paso 5: Consulta las referencias

Los RFCs referencian otros RFCs. Si no entiendes algo, la referencia te lleva al RFC que lo explica.

---

## Vocabulario esencial de RFCs

| Termino | Pronunciacion | Significado |
|---------|---------------|-------------|
| **specification** | spe-si-fi-KEI-shon | Especificacion |
| **compliance** | com-PLAI-ans | Cumplimiento |
| **conformance** | con-FOR-mans | Conformidad |
| **interoperability** | in-ter-o-pe-ra-BI-li-ti | Interoperabilidad |
| **backward compatible** | BAK-ward com-PA-ti-bol | Compatible hacia atras |
| **normative** | NOR-ma-tiv | Que establece normas |
| **informative** | in-FOR-ma-tiv | Solo informativo |
| **errata** | e-RA-ta | Correcciones de errores |
| **obsoletes** | ob-so-LITS | Reemplaza (un RFC anterior) |
| **updates** | ap-DEITS | Actualiza (un RFC anterior) |

---

## Tipos de documentos de especificacion

Ademas de RFCs, existen otros tipos de especificaciones:

| Tipo | Organizacion | Ejemplos |
|------|-------------|----------|
| **RFC** | IETF | HTTP, WebSocket, JWT |
| **W3C Recommendation** | W3C | HTML, CSS, DOM |
| **ECMA Standard** | Ecma International | ECMAScript (JavaScript) |
| **ISO Standard** | ISO | Codificaciones, formatos |
| **PEP** | Python | Propuestas de mejora de Python |
| **JSR** | JCP | Especificaciones de Java |
| **TC39 Proposal** | TC39 | Nuevas features de JavaScript |

---

## Resumen

- Los RFCs definen los estandares de Internet y estan siempre en ingles
- Aprende las palabras clave del RFC 2119 (MUST, SHOULD, MAY) para entender obligaciones
- Lee siempre en orden: Abstract -> Terminology -> Specification -> Security
- No necesitas leer un RFC completo: busca la seccion relevante a tu problema
- Conocer los RFCs te da ventaja para entender protocolos a nivel profundo
