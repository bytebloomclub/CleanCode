// Función para girar la ruleta
function girarRuleta(nombres) {
    if (nombres.length === 0) {
        throw new Error("La lista de nombres está vacía.");
    }

    const indiceAleatorio = Math.floor(Math.random() * nombres.length);
    return nombres[indiceAleatorio];
}

// Interfaz para interactuar con el usuario
function iniciarRuleta() {
    try {
        const nombres = [];

        // Solicitar nombres al usuario
        for (let i = 0; i < 10; i++) {
            const nombre = prompt(`Ingresa el nombre ${i + 1} (o deja vacío para terminar):`);
            if (nombre.trim() === "") {
                break;
            }
            nombres.push(nombre.trim());
        }

        if (nombres.length === 0) {
            alert("No se ingresaron nombres. Intenta de nuevo.");
            return;
        }

        // Girar la ruleta
        const ganador = girarRuleta(nombres);
        console.log(`El ganador es: ${ganador}`);
        alert(`¡El ganador es: ${ganador}!`);
    } catch (error) {
        console.error(error.message);
        alert(error.message);
    }
}

// Llamar a la función de interacción
iniciarRuleta();
