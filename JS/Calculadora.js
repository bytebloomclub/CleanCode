// Clase Calculadora para encapsular las operaciones
class Calculadora {
    // Método para sumar
    static sumar(a, b) {
        return a + b;
    }

    // Método para restar
    static restar(a, b) {
        return a - b;
    }

    // Método para multiplicar
    static multiplicar(a, b) {
        return a * b;
    }

    // Método para dividir
    static dividir(a, b) {
        if (b === 0) {
            throw new Error("Error: División por cero no está permitida.");
        }
        return a / b;
    }
}

// Interfaz para interactuar con el usuario
function interactuarConUsuario() {
    try {
        const operacion = prompt("Selecciona una operación: sumar, restar, multiplicar, dividir");
        const numero1 = parseFloat(prompt("Ingresa el primer número:"));
        const numero2 = parseFloat(prompt("Ingresa el segundo número:"));

        let resultado;
        switch (operacion.toLowerCase()) {
            case "sumar":
                resultado = Calculadora.sumar(numero1, numero2);
                break;
            case "restar":
                resultado = Calculadora.restar(numero1, numero2);
                break;
            case "multiplicar":
                resultado = Calculadora.multiplicar(numero1, numero2);
                break;
            case "dividir":
                resultado = Calculadora.dividir(numero1, numero2);
                break;
            default:
                throw new Error("Operación no válida. Por favor, intenta de nuevo.");
        }

        console.log(`El resultado de ${operacion} ${numero1} y ${numero2} es: ${resultado}`);
        alert(`El resultado de ${operacion} ${numero1} y ${numero2} es: ${resultado}`);
    } catch (error) {
        console.error(error.message);
        alert(error.message);
    }
}

// Llamar a la función de interacción
interactuarConUsuario();
