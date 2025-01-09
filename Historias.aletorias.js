// Función para generar una historia aleatoria
function generarHistoria(personajes, lugares, acciones) {
    if (personajes.length === 0 || lugares.length === 0 || acciones.length === 0) {
        throw new Error("Todas las categorías deben tener al menos un elemento.");
    }

    const personaje = personajes[Math.floor(Math.random() * personajes.length)];
    const lugar = lugares[Math.floor(Math.random() * lugares.length)];
    const accion = acciones[Math.floor(Math.random() * acciones.length)];

    return `Un día, ${personaje} estaba en ${lugar} y decidió ${accion}.`;
}

// Interfaz para interactuar con el usuario
function iniciarGeneradorDeHistorias() {
    try {
        const personajes = [];
        const lugares = [];
        const acciones = [];

        // Solicitar personajes
        for (let i = 0; i < 5; i++) {
            const personaje = prompt(`Ingresa un personaje ${i + 1} (o deja vacío para terminar):`);
            if (personaje.trim() === "") {
                break;
            }
            personajes.push(personaje.trim());
        }

        // Solicitar lugares
        for (let i = 0; i < 5; i++) {
            const lugar = prompt(`Ingresa un lugar ${i + 1} (o deja vacío para terminar):`);
            if (lugar.trim() === "") {
                break;
            }
            lugares.push(lugar.trim());
        }

        // Solicitar acciones
        for (let i = 0; i < 5; i++) {
            const accion = prompt(`Ingresa una acción ${i + 1} (o deja vacío para terminar):`);
            if (accion.trim() === "") {
                break;
            }
            acciones.push(accion.trim());
        }

        if (personajes.length === 0 || lugares.length === 0 || acciones.length === 0) {
            alert("Debe haber al menos un elemento en cada categoría. Intenta de nuevo.");
            return;
        }

        // Generar la historia
        const historia = generarHistoria(personajes, lugares, acciones);
        console.log(historia);
        alert(historia);
    } catch (error) {
        console.error(error.message);
        alert(error.message);
    }
}

// Llamar a la función de interacción
iniciarGeneradorDeHistorias();
