import Principal "mo:base/Principal";
import Time "mo:base/Time";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import HashMap "mo:base/HashMap";

module {
    // Definición del tipo `Result` utilizado para manejar resultados y errores.
    public type Result<Ok, Err> = Result.Result<Ok, Err>;

    // Definición del tipo `HashMap` utilizado para almacenar datos de miembros.
    public type HashMap<Ok, Err> = HashMap.HashMap<Ok, Err>;

    // Definición del tipo `Member` que representa un miembro del DAO.
    // Incluye el nombre y la edad del miembro.
    public type Member = {
        name : Text;
        age : Nat;
    };
};
