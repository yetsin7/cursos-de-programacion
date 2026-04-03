# Describing Bugs

## Como Describir Bugs en Ingles

Saber describir un bug de forma clara y profesional en ingles es una habilidad
critica. Ya sea en un issue de GitHub, un mensaje de Slack o un reporte formal,
una buena descripcion acelera la resolucion del problema.

---

## La Formula Basica

La forma mas simple de describir un bug es:

> **"When I [action], [what happens] instead of [what should happen]."**

### Ejemplos

| Descripcion del bug |
|---------------------|
| "When I **click the submit button**, the page **reloads** instead of **showing a success message**." |
| "When I **open the app offline**, it **crashes** instead of **showing cached data**." |
| "When I **enter a long username**, the text **overflows** instead of **truncating**." |
| "When I **refresh the page**, the **cart loses all items** instead of **persisting them**." |

---

## Estructura de un Bug Report

Un reporte de bug profesional tiene estas secciones:

### 1. Title (Titulo)

Breve y descriptivo. Incluye donde y que pasa.

| Mal | Bien |
|-----|------|
| "Bug" | "Login button unresponsive on mobile Safari" |
| "Doesn't work" | "Cart total shows negative values with discount > price" |
| "Error" | "500 error when uploading images larger than 5MB" |

### 2. Description (Descripcion)

```markdown
## Description

When a user applies a discount code that exceeds the item price,
the cart total displays a negative value instead of showing zero.
```

### 3. Steps to Reproduce (Pasos para Reproducir)

```markdown
## Steps to Reproduce

1. Add a product priced at $10 to the cart.
2. Apply discount code "SAVE20" (which gives $20 off).
3. Observe the cart total.
```

**Frases utiles**:
- "Navigate to..."
- "Click on..."
- "Enter [value] in the [field] field."
- "Wait for the page to load."
- "Observe that..."
- "Scroll down to..."

### 4. Expected Behavior (Comportamiento Esperado)

```markdown
## Expected Behavior

The cart total should display $0.00 when the discount exceeds
the item price.
```

**Frases utiles**:
- "The app **should** display..."
- "The user **should be able to**..."
- "The page **should redirect to**..."
- "The field **should show** a validation error."
- "The API **should return** a 200 status."

### 5. Actual Behavior (Comportamiento Real)

```markdown
## Actual Behavior

The cart total displays -$10.00, and the checkout button remains
enabled, allowing the user to proceed with a negative total.
```

**Frases utiles**:
- "Instead, the app **displays**..."
- "The page **crashes** with..."
- "The API **returns** a 500 error."
- "Nothing happens when..."
- "The screen **freezes** for 10 seconds."

### 6. Environment (Entorno)

```markdown
## Environment

- **OS**: iOS 17.2
- **Browser**: Safari 17.2
- **App version**: 2.1.0
- **Device**: iPhone 15 Pro
- **Network**: WiFi
```

### 7. Additional Context (Contexto Adicional)

```markdown
## Additional Context

- This issue started after the v2.1.0 release.
- Only reproducible on iOS; Android works fine.
- Screenshot attached.
- Related to issue #234.
```

---

## Plantilla Completa de Bug Report

```markdown
## Bug Report

### Title
[Component] Brief description of the issue

### Description
A clear and concise description of the bug.

### Steps to Reproduce
1. Go to '...'
2. Click on '...'
3. Scroll down to '...'
4. See error

### Expected Behavior
A description of what you expected to happen.

### Actual Behavior
A description of what actually happened.

### Screenshots
If applicable, add screenshots.

### Environment
- OS: [e.g., Windows 11, macOS 14, iOS 17]
- Browser/App: [e.g., Chrome 120, Flutter 3.19]
- Version: [e.g., 2.1.0]

### Additional Context
- Frequency: [always / sometimes / rarely]
- Severity: [critical / major / minor / cosmetic]
- Related issues: #123
```

---

## Niveles de Severidad

| Nivel | Ingles | Significado |
|-------|--------|-------------|
| **Critical** | /ˈkrɪtɪkəl/ | La app no funciona, se pierden datos |
| **Major** | /ˈmeɪdʒər/ | Funcionalidad importante esta rota |
| **Minor** | /ˈmaɪnər/ | Funcionalidad menor afectada |
| **Cosmetic** | /kɒzˈmɛtɪk/ | Problema visual, no afecta funcionalidad |

### Ejemplos

- "This is a **critical** bug — users can't log in." (Bug critico, los usuarios no pueden iniciar sesion.)
- "It's a **minor** issue — the icon is slightly misaligned." (Es un problema menor, el icono esta ligeramente desalineado.)

---

## Frases para Comunicar Bugs en Reuniones o Chat

| Situacion | Frase en ingles |
|-----------|----------------|
| Reportar un bug | "I found a bug in the checkout flow." |
| Describir el impacto | "This affects all users on mobile." |
| Pedir ayuda | "Can someone look into this issue?" |
| Dar contexto | "This started happening after the last deployment." |
| Ofrecer informacion | "I can reproduce it consistently with these steps." |
| Proponer solucion | "I think the root cause is a missing null check." |
| Dar estado | "I'm investigating the issue now." |
| Confirmar fix | "The fix has been deployed and verified." |
| Cerrar un bug | "This has been resolved in version 2.1.1." |

---

## Vocabulario Adicional para Bugs

| Termino | Significado |
|---------|-------------|
| **Reproducible** | Se puede replicar siguiendo los pasos |
| **Intermittent** | Ocurre a veces, no siempre |
| **Blocker** | Impide continuar con el trabajo |
| **Showstopper** | Bug tan grave que detiene el lanzamiento |
| **Workaround available** | Existe una solucion temporal |
| **Cannot reproduce** | No se puede replicar el error |
| **Works as intended** | Funciona como fue disenado (no es un bug) |
| **Won't fix** | Se decide no corregir |
| **Duplicate** | Ya fue reportado anteriormente |

---

## Resumen

Para describir un bug profesionalmente:

1. Usa la formula: "When I [X], [Y happens] instead of [Z]"
2. Incluye **pasos para reproducir** claros y numerados
3. Separa **comportamiento esperado** vs **real**
4. Proporciona informacion del **entorno**
5. Indica la **severidad** y **frecuencia**
6. Adjunta **screenshots** o logs cuando sea posible
