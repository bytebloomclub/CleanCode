import java.util.Scanner;

public class ConversorTemperatura {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Elige una conversión: ");
        System.out.println("1. Celsius a Fahrenheit");
        System.out.println("2. Fahrenheit a Celsius");
        int opcion = scanner.nextInt();

        System.out.println("Ingresa la temperatura:");
        double temperatura = scanner.nextDouble();

        if (opcion == 1) {
            double fahrenheit = (temperatura * 9 / 5) + 32;
            System.out.println("La temperatura en Fahrenheit es: " + fahrenheit);
        } else if (opcion == 2) {
            double celsius = (temperatura - 32) * 5 / 9;
            System.out.println("La temperatura en Celsius es: " + celsius);
        } else {
            System.out.println("Opción no válida.");
        }
    }
}
