import Buffer "mo:base/Buffer";

actor {
    // Defina una variable inmutable name de tipo Text que represente el nombre de su DAO.
    // El nombre de la DAO es "Alegra Studio DAO".
    let name : Text = "Alegra Studio DAO";

    // Defina una variable mutable manifesto de tipo Text que represente el manifiesto de su DAO.
    // El manifiesto describe la misión y visión de Alegra Studio DAO.
    var manifesto : Text = "En Alegra Studio DAO, creemos en un futuro donde la tecnología blockchain y las artes se unen para generar un impacto positivo en nuestra sociedad y medio ambiente. Nuestra misión es empoderar a los individuos a través de la creación y colaboración, utilizando la tecnología para promover prácticas sostenibles y transformar la economía circular.";

    // Defina una variable mutable de tipo Buffer<Text> que almacenará los objetivos de su DAO.
    // Buffer se utiliza para almacenar una lista de objetivos que puede ser dinámica y cambiar con el tiempo.
    let goals = Buffer.Buffer<Text>(0);

    // Implemente la función de consulta getName.
    // Esta función no toma parámetros y devuelve el nombre de su DAO.
    public shared query func getName() : async Text {
        return name;
    };

    // Implemente la función de consulta getManifesto.
    // Esta función no toma parámetros y devuelve el manifiesto de su DAO.
    public shared query func getManifesto() : async Text {
        return manifesto;
    };

    // Implemente la función setManifesto.
    // Esta función toma un parámetro newManifesto de tipo Text, actualiza el valor del manifiesto y no devuelve nada.
    public func setManifesto(newManifesto : Text) : async () {
        manifesto := newManifesto;
        return;
    };

    // Implemente la función addGoal.
    // Esta función toma un parámetro newGoal de tipo Text, agrega un nuevo objetivo al búfer de objetivos y no devuelve nada.
    public func addGoal(newGoal : Text) : async () {
        goals.add(newGoal);
        return;
    };

    // Implemente la función de consulta getGoals.
    // Esta función no toma parámetros y devuelve todos los objetivos de su DAO en una matriz.
    public shared query func getGoals() : async [Text] {
        return Buffer.toArray(goals);
    };
};

// Resumen

// Este código proporciona una base para la administración de la DAO de Alegra Studio, permitiendo:

// Consultar el nombre de la DAO.
// Consultar y actualizar el manifiesto de la DAO.
// Agregar y consultar los objetivos de la DAO.

// Esto establece una estructura para la gobernanza descentralizada y la participación de la comunidad en la toma 
// de decisiones y la gestión de la plataforma Alegra Studio, alineándose con su misión de empoderar a los individuos 
// a través de la tecnología blockchain y fomentar la creatividad y la sostenibilidad.