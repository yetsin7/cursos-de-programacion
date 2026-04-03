# Módulo 17 — Listas y Scroll

## Mostrar listas de datos eficientemente

En casi toda app móvil hay listas. Flutter ofrece varios widgets para mostrarlas:

- **ListView**: listas verticales (el más común)
- **GridView**: cuadrículas de items
- **CustomScrollView + Slivers**: layouts de scroll complejos con appbar que se colapsa
- **RefreshIndicator + ScrollController**: pull-to-refresh y paginación

---

## ¿Por qué importa la eficiencia?

Un ListView con `children: [Widget, Widget, ...]` crea TODOS los widgets al mismo tiempo, aunque no sean visibles. Con 1000 items, esto crea 1000 widgets en memoria.

`ListView.builder` solo crea los widgets que son visibles en pantalla (más unos pocos extra como buffer). Es virtualmente gratis en términos de memoria sin importar cuántos items tenga la lista.

```dart
// ❌ INEFICIENTE para listas largas — crea todos a la vez:
ListView(children: items.map((i) => ItemWidget(i)).toList())

// ✅ EFICIENTE — lazy loading, solo crea lo visible:
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(items[index]),
)
```

---

## Slivers: el sistema de scroll de bajo nivel

Los Slivers son el sistema de scroll de bajo nivel de Flutter. `CustomScrollView` acepta una lista de Slivers que se comportan como fragmentos de scroll unificado:

- **SliverAppBar**: AppBar que se colapsa al hacer scroll
- **SliverList**: equivalente a ListView dentro de CustomScrollView
- **SliverGrid**: equivalente a GridView dentro de CustomScrollView
- **SliverToBoxAdapter**: para colocar widgets normales dentro de un Sliver

---

## Archivos de este módulo

| Archivo | Tema |
|---|---|
| `01_listview.dart` | ListView, ListView.builder, ListView.separated, ListTile |
| `02_gridview.dart` | GridView.builder, GridView.count, aspectRatio |
| `03_custom_scroll.dart` | CustomScrollView, SliverAppBar, SliverList, SliverGrid |
| `04_pull_to_refresh.dart` | RefreshIndicator, ScrollController, paginación |
| `05_ejercicios.dart` | Ejercicios de práctica |
