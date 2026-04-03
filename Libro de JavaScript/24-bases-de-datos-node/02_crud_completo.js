// ============================================================
// ARCHIVO: 02_crud_completo.js
// TEMA: CRUD completo con clase NotasDB usando better-sqlite3
// CÓMO EJECUTAR: node 02_crud_completo.js
// DEPENDENCIA: npm install better-sqlite3
// ============================================================

'use strict';

const Database = require('better-sqlite3');
const path = require('path');

// ─── CLASE NotasDB ────────────────────────────────────────────

/**
 * Gestor de la base de datos de notas.
 * Encapsula todas las operaciones CRUD en métodos legibles.
 * Usa prepared statements para seguridad y rendimiento.
 */
class NotasDB {
  /**
   * Abre (o crea) la base de datos y prepara la tabla y los statements.
   * @param {string} rutaDB - Ruta al archivo .db (default: ./notas.db)
   */
  constructor(rutaDB = './notas_demo.db') {
    this.db = new Database(rutaDB);
    this.db.pragma('journal_mode = WAL');
    this.db.pragma('foreign_keys = ON');
    this._crearTabla();
    this._prepararStatements();
    console.log(`Base de datos lista: ${path.resolve(rutaDB)}`);
  }

  /** Crea la tabla si no existe — se puede llamar múltiples veces sin error */
  _crearTabla() {
    this.db.exec(`
      CREATE TABLE IF NOT EXISTS notas (
        id           INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo       TEXT    NOT NULL,
        contenido    TEXT    NOT NULL DEFAULT '',
        etiqueta     TEXT    NOT NULL DEFAULT 'general',
        creado_en    TEXT    NOT NULL DEFAULT (datetime('now')),
        actualizado  TEXT    NOT NULL DEFAULT (datetime('now'))
      )
    `);
  }

  /**
   * Prepara todos los statements SQL de una sola vez al iniciar.
   * Compilar statements una vez y reutilizarlos es más eficiente
   * que compilarlos cada vez que se llama a un método.
   */
  _prepararStatements() {
    this._stmts = {
      insertar: this.db.prepare(
        `INSERT INTO notas (titulo, contenido, etiqueta)
         VALUES (@titulo, @contenido, @etiqueta)`
      ),
      obtenerTodas: this.db.prepare(
        `SELECT * FROM notas ORDER BY creado_en DESC`
      ),
      obtenerPorId: this.db.prepare(
        `SELECT * FROM notas WHERE id = @id`
      ),
      buscar: this.db.prepare(
        `SELECT * FROM notas
         WHERE titulo LIKE @termino OR contenido LIKE @termino
         ORDER BY creado_en DESC`
      ),
      actualizar: this.db.prepare(
        `UPDATE notas
         SET titulo = @titulo,
             contenido = @contenido,
             etiqueta = @etiqueta,
             actualizado = datetime('now')
         WHERE id = @id`
      ),
      eliminar: this.db.prepare(
        `DELETE FROM notas WHERE id = @id`
      ),
      contar: this.db.prepare(
        `SELECT COUNT(*) as total FROM notas`
      ).pluck(),
    };
  }

  // ─── CRUD ────────────────────────────────────────────────────

  /**
   * Crea una nueva nota en la base de datos.
   * @param {{ titulo: string, contenido?: string, etiqueta?: string }} datos
   * @returns {{ id: number, titulo: string, contenido: string, etiqueta: string }} La nota creada
   * @throws {Error} Si el título está vacío
   */
  crear(datos) {
    if (!datos.titulo?.trim()) {
      throw new Error('El título de la nota es obligatorio');
    }
    const payload = {
      titulo: datos.titulo.trim(),
      contenido: (datos.contenido || '').trim(),
      etiqueta: datos.etiqueta || 'general',
    };
    const { lastInsertRowid } = this._stmts.insertar.run(payload);
    return this.obtener(lastInsertRowid);
  }

  /**
   * Devuelve todas las notas, ordenadas por fecha de creación (más reciente primero).
   * @returns {Array} Lista de notas
   */
  obtenerTodas() {
    return this._stmts.obtenerTodas.all();
  }

  /**
   * Busca una nota por su ID.
   * @param {number} id
   * @returns {object|undefined} La nota o undefined si no existe
   */
  obtener(id) {
    return this._stmts.obtenerPorId.get({ id });
  }

  /**
   * Busca notas cuyo título o contenido contenga el texto dado.
   * @param {string} texto - Texto a buscar (insensible a mayúsculas)
   * @returns {Array} Notas que coinciden
   */
  buscar(texto) {
    return this._stmts.buscar.all({ termino: `%${texto}%` });
  }

  /**
   * Actualiza una nota existente por su ID.
   * @param {number} id - ID de la nota a actualizar
   * @param {{ titulo?: string, contenido?: string, etiqueta?: string }} datos - Campos a actualizar
   * @returns {object|undefined} La nota actualizada, o undefined si no existía
   */
  actualizar(id, datos) {
    const nota = this.obtener(id);
    if (!nota) return undefined;

    const payload = {
      id,
      titulo: (datos.titulo ?? nota.titulo).trim(),
      contenido: (datos.contenido ?? nota.contenido).trim(),
      etiqueta: datos.etiqueta ?? nota.etiqueta,
    };

    if (!payload.titulo) {
      throw new Error('El título de la nota no puede estar vacío');
    }

    this._stmts.actualizar.run(payload);
    return this.obtener(id);
  }

  /**
   * Elimina una nota por su ID.
   * @param {number} id
   * @returns {boolean} true si se eliminó, false si no existía
   */
  eliminar(id) {
    const { changes } = this._stmts.eliminar.run({ id });
    return changes > 0;
  }

  /** @returns {number} Total de notas en la base de datos */
  contar() {
    return this._stmts.contar.get();
  }

  /** Cierra la conexión con la base de datos */
  cerrar() {
    this.db.close();
    console.log('Conexión a la BD cerrada.');
  }
}

// ─── PRUEBAS ──────────────────────────────────────────────────

/** Función de utilidad para mostrar resultados de forma legible */
function mostrar(titulo, datos) {
  console.log(`\n--- ${titulo} ---`);
  if (Array.isArray(datos)) {
    datos.forEach((d) => console.log(`  [${d.id}] "${d.titulo}" [${d.etiqueta}]`));
    console.log(`  Total: ${datos.length} registros`);
  } else if (datos && typeof datos === 'object') {
    Object.entries(datos).forEach(([k, v]) => console.log(`  ${k}: ${v}`));
  } else {
    console.log(' ', datos);
  }
}

try {
  const db = new NotasDB('./notas_demo.db');

  // CREATE
  console.log('\n=== CREAR ===');
  const nota1 = db.crear({ titulo: 'Apuntes de Node.js', contenido: 'Node permite ejecutar JS en el servidor', etiqueta: 'backend' });
  const nota2 = db.crear({ titulo: 'React Hooks', contenido: 'useState y useEffect son los más usados', etiqueta: 'frontend' });
  const nota3 = db.crear({ titulo: 'SQLite con Node', contenido: 'better-sqlite3 tiene API síncrona y es muy rápida', etiqueta: 'base-de-datos' });
  const nota4 = db.crear({ titulo: 'Express Middleware', contenido: 'Los middleware son funciones (req, res, next)', etiqueta: 'backend' });
  mostrar('Nota creada', nota1);
  console.log('  Total de notas:', db.contar());

  // READ ALL
  mostrar('Obtener todas', db.obtenerTodas());

  // READ ONE
  mostrar('Obtener nota id=2', db.obtener(2));

  // SEARCH
  mostrar('Buscar "backend" (en contenido/título)', db.buscar('backend'));
  mostrar('Buscar "Node"', db.buscar('Node'));

  // UPDATE
  console.log('\n=== ACTUALIZAR ===');
  const actualizada = db.actualizar(1, {
    titulo: 'Apuntes de Node.js (actualizado)',
    contenido: 'Node.js usa el motor V8 de Chrome para ejecutar JavaScript en el servidor.',
  });
  mostrar('Nota actualizada', actualizada);

  // DELETE
  console.log('\n=== ELIMINAR ===');
  const eliminada = db.eliminar(4);
  console.log('  ¿Nota id=4 eliminada?', eliminada);
  console.log('  ¿Nota id=99 eliminada?', db.eliminar(99)); // No existe
  mostrar('Notas restantes', db.obtenerTodas());

  // Error handling
  console.log('\n=== MANEJO DE ERRORES ===');
  try {
    db.crear({ titulo: '' }); // Debe lanzar error
  } catch (e) {
    console.log('  Error esperado al crear sin título:', e.message);
  }

  // Cierre limpio
  db.cerrar();

} catch (error) {
  console.error('Error de base de datos:', error.message);
  process.exit(1);
} finally {
  // Limpiar el archivo de demo para que el script sea re-ejecutable
  const fs = require('fs');
  ['./notas_demo.db', './notas_demo.db-wal', './notas_demo.db-shm'].forEach((f) => {
    if (fs.existsSync(f)) fs.unlinkSync(f);
  });
  console.log('\nArchivo de demo eliminado. Vuelve a ejecutar para re-crear.');
}
