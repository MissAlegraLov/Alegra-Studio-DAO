import Principal "mo:base/Principal";
import Time "mo:base/Time";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import HashMap "mo:base/HashMap";

module {
    // Definición del tipo Result utilizado para manejar resultados de operaciones con éxito o error.
    public type Result<Ok, Err> = Result.Result<Ok, Err>;

    // Definición del tipo HashMap utilizado para almacenar datos clave-valor.
    public type HashMap<Ok, Err> = HashMap.HashMap<Ok, Err>;

    // Definición del tipo Member utilizado para representar a un miembro del DAO.
    // Contiene los campos:
    // - name: Nombre del miembro (tipo Text).
    // - age: Edad del miembro (tipo Nat).
    public type Member = {
        name : Text;
        age : Nat;
    };
};