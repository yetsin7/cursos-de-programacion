export {};

/*
 * Capitulo 07 — Utility Types
 * Archivo: 01_utility_types.ts
 *
 * Este ejemplo muestra como adaptar un modelo base a distintas necesidades sin
 * copiar y pegar tipos casi iguales.
 */

interface UserProfile {
  id: number;
  name: string;
  email: string;
  isAdmin: boolean;
}

type UserUpdate = Partial<UserProfile>;
type PublicUser = Pick<UserProfile, "id" | "name">;
type PrivateUser = Omit<UserProfile, "isAdmin">;
type UserDirectory = Record<string, PublicUser>;

const pendingUpdate: UserUpdate = {
  email: "nuevo-correo@example.com"
};

const publicUser: PublicUser = {
  id: 1,
  name: "Elena"
};

const privateUser: PrivateUser = {
  id: 2,
  name: "Marco",
  email: "marco@example.com"
};

const directory: UserDirectory = {
  elena: publicUser,
  marco: { id: 2, name: "Marco" }
};

console.log("Actualizacion parcial:", pendingUpdate);
console.log("Usuario publico:", publicUser);
console.log("Usuario privado:", privateUser);
console.log("Directorio:", directory);
