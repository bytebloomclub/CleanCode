import java.util.Scanner;

public class CalculadoraIMC {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Ingresa tu peso en kilogramos:");
        double peso = scanner.nextDouble();

        System.out.println("Ingresa tu altura en metros:");
        double altura = scanner.nextDouble();

        double imc = peso / (altura * altura);
        System.out.printf("Tu IMC es: %.2f%n", imc);

        if (imc < 18.5) {
            System.out.println("Clasificación: Bajo peso.");
        } else if (imc >= 18.5 && imc < 24.9) {
            System.out.println("Clasificación: Peso normal.");
        } else if (imc >= 25 && imc < 29.9) {
            System.out.println("Clasificación: Sobrepeso.");
        } else {
            System.out.println("Clasificación: Obesidad.");
        }
    }
}
