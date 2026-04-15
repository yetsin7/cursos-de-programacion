/**
 * Capítulo 09 — STL: Contenedores y Algoritmos
 * Archivo: 01_stl.cpp
 *
 * Demuestra:
 *   - std::vector: array dinámico con operaciones comunes
 *   - std::map: diccionario ordenado clave→valor
 *   - std::set: conjunto de valores únicos
 *   - std::unordered_map: hash map de acceso rápido
 *   - Iteradores: begin(), end(), iteración con for
 *   - <algorithm>: sort, find, find_if, count, for_each, reverse
 *
 * Compilar: g++ -std=c++17 -o stl 01_stl.cpp
 */

#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <set>
#include <unordered_map>
#include <list>
#include <queue>
#include <stack>
#include <algorithm>  // sort, find, find_if, count, for_each, etc.

// Función auxiliar: imprime cualquier contenedor iterable
template <typename Contenedor>
void imprimir(const std::string& etiqueta, const Contenedor& c) {
    std::cout << etiqueta << ": ";
    for (const auto& elem : c) std::cout << elem << " ";
    std::cout << "\n";
}

int main() {
    using namespace std;

    // -------------------------------------------------------------------------
    // 1. std::vector — Array dinámico
    // -------------------------------------------------------------------------
    cout << "=== VECTOR ===\n";

    vector<int> numeros = {5, 2, 8, 1, 9, 3, 7, 4, 6};
    imprimir("Original", numeros);

    numeros.push_back(10);                 // Agregar al final
    numeros.pop_back();                    // Eliminar el último
    cout << "Tamaño: " << numeros.size() << "\n";
    cout << "Primer elemento: " << numeros.front() << "\n";
    cout << "Último elemento: " << numeros.back()  << "\n";
    cout << "Índice 3:  " << numeros.at(3) << "\n";

    // Insertar en posición específica (iterador)
    numeros.insert(numeros.begin() + 2, 99);  // Inserta 99 en índice 2
    cout << "Tras insertar 99 en índice 2: ";
    for (int n : numeros) cout << n << " ";
    cout << "\n";

    // Eliminar elemento en posición
    numeros.erase(numeros.begin() + 2);  // Elimina el 99
    imprimir("Tras erase en índice 2", numeros);

    // -------------------------------------------------------------------------
    // 2. std::map — Diccionario ordenado
    // -------------------------------------------------------------------------
    cout << "\n=== MAP (diccionario ordenado) ===\n";

    map<string, int> edades;
    edades["Ana"]     = 30;
    edades["Carlos"]  = 25;
    edades["Beatriz"] = 28;
    edades["David"]   = 22;

    // Iterar (el map siempre está ordenado por clave)
    cout << "Edades (ordenadas por nombre):\n";
    for (const auto& [nombre, edad] : edades) {  // C++17: structured bindings
        cout << "  " << nombre << ": " << edad << "\n";
    }

    // Buscar una clave
    auto it = edades.find("Carlos");
    if (it != edades.end()) {
        cout << "Carlos encontrado: " << it->second << " años\n";
    }

    // Verificar existencia sin insertar
    cout << "¿Existe 'Eva'? " << (edades.count("Eva") ? "Sí" : "No") << "\n";

    // -------------------------------------------------------------------------
    // 3. std::set — Conjunto sin duplicados
    // -------------------------------------------------------------------------
    cout << "\n=== SET (sin duplicados) ===\n";

    set<int> conjunto = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5};
    // Al insertar, los duplicados se eliminan y queda ordenado
    imprimir("Set (sin duplicados, ordenado)", conjunto);

    conjunto.insert(7);
    conjunto.insert(3);  // Duplicado: ignorado
    imprimir("Tras insertar 7 y 3 (dup)", conjunto);

    cout << "¿Contiene el 9? " << (conjunto.count(9) ? "Sí" : "No") << "\n";
    conjunto.erase(9);
    cout << "¿Contiene el 9 tras erase? " << (conjunto.count(9) ? "Sí" : "No") << "\n";

    // -------------------------------------------------------------------------
    // 4. std::unordered_map — Hash map (O(1) promedio)
    // -------------------------------------------------------------------------
    cout << "\n=== UNORDERED_MAP (hash map rápido) ===\n";

    unordered_map<string, string> capitales;
    capitales["México"]    = "Ciudad de México";
    capitales["España"]    = "Madrid";
    capitales["Argentina"] = "Buenos Aires";
    capitales["Colombia"]  = "Bogotá";

    cout << "Capital de España: " << capitales["España"] << "\n";

    // Verificar si existe antes de acceder
    string pais = "Chile";
    if (capitales.count(pais) == 0) {
        cout << pais << " no está en el mapa\n";
    }

    // -------------------------------------------------------------------------
    // 5. std::queue y std::stack
    // -------------------------------------------------------------------------
    cout << "\n=== QUEUE (cola FIFO) ===\n";

    queue<string> tareas;
    tareas.push("Tarea 1");
    tareas.push("Tarea 2");
    tareas.push("Tarea 3");

    while (!tareas.empty()) {
        cout << "Procesando: " << tareas.front() << "\n";
        tareas.pop();
    }

    cout << "\n=== STACK (pila LIFO) ===\n";
    stack<int> historial;
    historial.push(100);
    historial.push(200);
    historial.push(300);

    while (!historial.empty()) {
        cout << "Deshacer: " << historial.top() << "\n";
        historial.pop();
    }

    // -------------------------------------------------------------------------
    // 6. Algoritmos de <algorithm>
    // -------------------------------------------------------------------------
    cout << "\n=== ALGORITMOS ===\n";

    vector<int> datos = {5, 2, 8, 1, 9, 3, 7, 4, 6, 2, 5};

    // sort — Ordenar
    vector<int> ordenado = datos;
    sort(ordenado.begin(), ordenado.end());
    imprimir("sort ascendente", ordenado);

    sort(ordenado.begin(), ordenado.end(), greater<int>());
    imprimir("sort descendente", ordenado);

    // find — Buscar valor exacto
    auto pos = find(datos.begin(), datos.end(), 7);
    if (pos != datos.end()) {
        cout << "find(7): encontrado en índice "
             << distance(datos.begin(), pos) << "\n";
    }

    // find_if — Buscar con predicado lambda
    auto primerGrande = find_if(datos.begin(), datos.end(),
        [](int x) { return x > 6; });
    if (primerGrande != datos.end()) {
        cout << "find_if(>6): primer valor: " << *primerGrande << "\n";
    }

    // count y count_if
    cout << "count(5): " << count(datos.begin(), datos.end(), 5) << "\n";
    cout << "count_if(>5): "
         << count_if(datos.begin(), datos.end(), [](int x) { return x > 5; })
         << "\n";

    // for_each — Aplicar función a cada elemento
    vector<int> dobles = datos;
    for_each(dobles.begin(), dobles.end(), [](int& x) { x *= 2; });
    imprimir("for_each(*2)", dobles);

    // reverse
    vector<int> rev = {1, 2, 3, 4, 5};
    reverse(rev.begin(), rev.end());
    imprimir("reverse", rev);

    return 0;
}
