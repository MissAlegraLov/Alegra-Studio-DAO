import Result "mo:base/Result";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Option "mo:base/Option";
import Types "types";

actor {
    type Result<Ok, Err> = Types.Result<Ok, Err>;
    type HashMap<K, V> = Types.HashMap<K, V>;

    // Defina la variable ledger para almacenar el saldo de cada usuario
    let ledger = HashMap.HashMap<Principal, Nat>(0, Principal.equal, Principal.hash);

    // tokenName: Devuelve el nombre del token utilizado en Alegra Studio DAO.
    public query func tokenName() : async Text {
        return "AlegraRecycles";
    };

    // tokenSymbol: Devuelve el símbolo del token utilizado en Alegra Studio DAO.
    public query func tokenSymbol() : async Text {
        return "AGR";
    };

    // mint: Crea nuevos tokens y los asigna a un propietario específico.
    // Parámetros:
    // - owner: Principal del propietario que recibirá los nuevos tokens.
    // - amount: Cantidad de tokens a crear.
    // Devuelve un resultado indicando éxito o un mensaje de error.
    public func mint(owner : Principal, amount : Nat) : async Result<(), Text> {
        let balance = Option.get(ledger.get(owner), 0);
        ledger.put(owner, balance + amount);
        return #ok();
    };

    // burn: Elimina una cantidad específica de tokens de un propietario.
    // Parámetros:
    // - owner: Principal del propietario cuyos tokens serán eliminados.
    // - amount: Cantidad de tokens a eliminar.
    // Devuelve un resultado indicando éxito o un mensaje de error.
    public func burn(owner : Principal, amount : Nat) : async Result<(), Text> {
        let balance = Option.get(ledger.get(owner), 0);
        if (balance < amount) {
            return #err("Insufficient balance to burn");
        };
        ledger.put(owner, balance - amount);
        return #ok();
    };

    // transfer: Transfiere tokens de un propietario a otro.
    // Parámetros:
    // - from: Principal del propietario que envía los tokens.
    // - to: Principal del propietario que recibe los tokens.
    // - amount: Cantidad de tokens a transferir.
    // Devuelve un resultado indicando éxito o un mensaje de error.
    public shared ({ caller }) func transfer(from : Principal, to : Principal, amount : Nat) : async Result<(), Text> {
        if (from == to) {
            return #err("Cannot transfer to self");
        };
        let balanceFrom = Option.get(ledger.get(from), 0);
        let balanceTo = Option.get(ledger.get(to), 0);
        if (balanceFrom < amount) {
            return #err("Insufficient balance to transfer");
        };
        ledger.put(from, balanceFrom - amount);
        ledger.put(to, balanceTo + amount);
        return #ok();
    };

    // balanceOf: Consulta el saldo de tokens de un propietario.
    // Parámetros:
    // - owner: Principal del propietario cuyos tokens serán consultados.
    // Devuelve el saldo de tokens del propietario.
    public query func balanceOf(owner : Principal) : async Nat {
        return Option.get(ledger.get(owner), 0);
    };

    // totalSupply: Consulta el suministro total de tokens.
    // Devuelve la cantidad total de tokens en circulación.
    public query func totalSupply() : async Nat {
        var total = 0;
        for (balance in ledger.vals()) {
            total += balance;
        };
        return total;
    };
};
