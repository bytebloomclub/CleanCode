function lanzarDado(caras, cantidad) {
    let resultados = [];
    for (let i = 0; i < cantidad; i++) {
        const resultado = Math.floor(Math.random() * caras) + 1;
        resultados.push(resultado);
    }
    return resultados;
}

// Uso
const caras = 6; // Dado de 6 caras
const cantidad = 2; // Lanzar 2 dados
console.log("Resultados de los dados:", lanzarDado(caras, cantidad));
