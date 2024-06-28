import Result "mo:base/Result";
import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Iter "mo:base/Iter";
import Types "types";

// Definición del actor principal que contiene las funcionalidades del DAO.
actor {
    // Definición de tipos utilizados en el DAO.
    type Member = Types.Member;
    type Result<Ok, Err> = Types.Result<Ok, Err>;
    type HashMap<K, V> = Types.HashMap<K, V>;

    // Inicialización del HashMap para almacenar los miembros del DAO.
    // Utiliza el `Principal` como clave y el tipo `Member` como valor.
    let members = HashMap.HashMap<Principal, Member>(0, Principal.equal, Principal.hash);

    // Función para agregar un nuevo miembro al DAO.
    // Toma un objeto `Member` como parámetro y utiliza el `caller` como clave.
    public shared ({ caller }) func addMember(member : Member) : async Result<(), Text> {
        switch (members.get(caller)) {
            case (null) {
                members.put(caller, member);
                return #ok();
            };
            case (?member) {
                return #err("Member already exists");
            };
        };
    };

    // Función de consulta para obtener los detalles de un miembro.
    // Toma un `Principal` como parámetro y devuelve el objeto `Member` correspondiente.
    public query func getMember(p : Principal) : async Result<Member, Text> {
        switch (members.get(p)) {
            case (null) {
                return #err("Member does not exist");
            };
            case (?member) {
                return #ok(member);
            };
        };
    };

    // Función para actualizar los detalles de un miembro existente.
    // Toma un nuevo objeto `Member` como parámetro y actualiza el miembro asociado al `caller`.
    public shared ({ caller }) func updateMember(newMember : Member) : async Result<(), Text> {
        switch (members.get(caller)) {
            case (null) {
                return #err("Member does not exist");
            };
            case (?member) {
                members.put(caller, newMember);
                return #ok();
            };
        };
    };

    // Función de consulta para obtener todos los miembros del DAO.
    // Devuelve una matriz con todos los objetos `Member` almacenados.
    public query func getAllMembers() : async [Member] {
        return Iter.toArray(members.vals());
    };

    // Función de consulta para obtener el número total de miembros en el DAO.
    // Devuelve un valor de tipo `Nat` que representa la cantidad de miembros.
    public query func numberOfMembers() : async Nat {
        return members.size();
    };

    // Función para eliminar un miembro del DAO.
    // Utiliza el `caller` como clave para identificar y eliminar el miembro correspondiente.
    public shared ({ caller }) func removeMember() : async Result<(), Text> {
        switch (members.get(caller)) {
            case (null) {
                return #err("Member does not exist");
            };
            case (?member) {
                members.delete(caller);
                return #ok();
            };
        };
    };
};

// Descripción de las Funcionalidades

// Agregar Miembro (addMember):
//     Esta función permite que un usuario se registre como miembro del DAO.
//     Utiliza el caller (el principal del usuario que llama a la función) como clave en el HashMap.
//     Si el miembro ya existe, devuelve un error.

// Obtener Miembro (getMember):
//     Permite consultar la información de un miembro específico utilizando su Principal.
//     Devuelve el objeto Member correspondiente o un error si no existe.

// Actualizar Miembro (updateMember):
//     Permite que un miembro existente actualice su información.
//     Utiliza el caller como clave y actualiza los datos en el HashMap.

// Obtener Todos los Miembros (getAllMembers):
//     Devuelve una lista de todos los miembros registrados en el DAO.

// Número de Miembros (numberOfMembers):
//     Devuelve el número total de miembros registrados en el DAO.

// Eliminar Miembro (removeMember):
//     Permite que un miembro se elimine a sí mismo del DAO.
//     Utiliza el caller como clave para identificar y eliminar al miembro correspondiente.

// Importancia del CRUD en el DAO

// Las funcionalidades CRUD son esenciales para gestionar la membresía dentro del DAO de Alegra Studio.
// Permiten la creación, lectura, actualización y eliminación de miembros, lo que garantiza que la comunidad 
// pueda mantener y gestionar sus participantes de manera eficiente y transparente. Utilizando HashMap para 
// almacenar datos y Result para manejar errores, este sistema proporciona una forma robusta y segura de 
// interactuar con la DAO, asegurando que solo los usuarios autorizados puedan realizar cambios en la estructura del DAO.
