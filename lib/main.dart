import 'package:flutter/material.dart';

// Función principal para ejecutar la aplicación.
void main() {
  runApp(const MyApp());
}

// Clase principal de la aplicación, es un widget sin estado (StatelessWidget).
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de "debug" en la esquina.
      home: Calculator(), // Widget Calculator como pantalla principal.
    );
  }
}

// Clase que representa el widget Calculator con estado (StatefulWidget).
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState(); // Crea el estado de la calculadora.
}

// Clase que maneja el estado del widget Calculator.
class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = '0'; // Texto que se muestra en la pantalla de la calculadora.
  double numOne = 0; // Primer número de la operación.
  double numTwo = 0; // Segundo número de la operación.
  String result = ''; // Resultado intermedio.
  String finalResult = ''; // Resultado final que se muestra en pantalla.
  String opr = ''; // Operador actual.
  String preOpr = ''; // Operador anterior.

  // Widget que representa un botón de la calculadora.
  Widget calcbutton(String btntxt, Color btncolor, Color txtcolor) {
    return ElevatedButton(
      onPressed: () {
        calculation(btntxt); // Llama a la función de cálculo cuando se presiona el botón.
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(), // Estilo de botón circular.
        padding: const EdgeInsets.all(20), // Espaciado alrededor del botón.
        backgroundColor: btncolor, // Color de fondo del botón.
      ),
      child: Text(
        btntxt,
        style: TextStyle(
          fontSize: 35, // Tamaño de la fuente del texto del botón.
          color: txtcolor, // Color del texto del botón.
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fondo negro para la calculadora.
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5), // Margen horizontal.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // Alineación de los elementos al final.
          children: <Widget>[
            // Sección de la pantalla de la calculadora.
            SingleChildScrollView(
              scrollDirection: Axis.vertical, // Permite el desplazamiento vertical.
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // Alineación a la derecha.
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '$displaytxt', // Muestra el valor actual en pantalla.
                      textAlign: TextAlign.right, // Alineación del texto a la derecha.
                      style: const TextStyle(
                        color: Colors.white, // Texto blanco.
                        fontSize: 100, // Tamaño de fuente muy grande.
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Filas de botones de la calculadora.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Espaciado uniforme entre los botones.
              children: <Widget>[
                calcbutton('AC', Colors.grey, Colors.black), // Botón para reiniciar la calculadora.
                calcbutton('+/-', Colors.grey, Colors.black), // Botón para cambiar de signo.
                calcbutton('%', Colors.grey, Colors.black), // Botón de porcentaje.
                calcbutton('/', Colors.amber[700]!, Colors.white), // Botón de división.
              ],
            ),
            const SizedBox(height: 10), // Espaciado entre filas.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('7', Colors.grey[850]!, Colors.white), // Botones numéricos.
                calcbutton('8', Colors.grey[850]!, Colors.white),
                calcbutton('9', Colors.grey[850]!, Colors.white),
                calcbutton('x', Colors.amber[700]!, Colors.white), // Botón de multiplicación.
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('4', Colors.grey[850]!, Colors.white),
                calcbutton('5', Colors.grey[850]!, Colors.white),
                calcbutton('6', Colors.grey[850]!, Colors.white),
                calcbutton('-', Colors.amber[700]!, Colors.white), // Botón de resta.
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                calcbutton('1', Colors.grey[850]!, Colors.white),
                calcbutton('2', Colors.grey[850]!, Colors.white),
                calcbutton('3', Colors.grey[850]!, Colors.white),
                calcbutton('+', Colors.amber[700]!, Colors.white), // Botón de suma.
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Botón especial para el número 0, ocupa más espacio.
                ElevatedButton(
                  onPressed: () {
                    calculation('0'); // Botón del número 0.
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(), // Borde en forma de estadio.
                    padding: const EdgeInsets.fromLTRB(34, 20, 128, 20), // Espaciado.
                    backgroundColor: Colors.grey[850], // Fondo gris oscuro.
                  ),
                  child: const Text(
                    '0',
                    style: TextStyle(fontSize: 35, color: Colors.white), // Texto del botón 0.
                  ),
                ),
                calcbutton('.', Colors.grey[850]!, Colors.white), // Botón de punto decimal.
                calcbutton('=', Colors.amber[700]!, Colors.white), // Botón de igual para calcular.
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Función que maneja los cálculos cuando se presionan los botones.
  void calculation(String btnText) {
    // Si se presiona 'AC', reinicia todos los valores.
    if (btnText == 'AC') {
      displaytxt = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';
    } 
    // Repetir el cálculo con el último operador cuando se presiona '=' dos veces.
    else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } 
    // Si se presiona un operador (+, -, x, /, =).
    else if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result); // Asigna el primer número.
      } else {
        numTwo = double.parse(result); // Asigna el segundo número.
      }

      // Realiza la operación según el operador.
      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } 
    // Si se presiona el botón de porcentaje (%).
    else if (btnText == '%') {
      result = (numOne / 100).toString();
      finalResult = doesContainDecimal(result);
    } 
    // Si se presiona el botón de punto decimal (.) y no existe ya un punto.
    else if (btnText == '.') {
      if (!result.contains('.')) {
        result = '$result.';
      }
      finalResult = result;
    } 
    // Si se presiona el botón de cambio de signo (+/-).
    else if (btnText == '+/-') {
      result = result.startsWith('-') ? result.substring(1) : '-$result';
      finalResult = result;
    } 
    // Para los números (0-9).
    else {
      result = result + btnText; // Concatenar los números presionados.
      finalResult = result;
    }

    // Actualiza la pantalla con el resultado final.
    setState(() {
      displaytxt = finalResult;
    });
  }

  // Funciones para las operaciones aritméticas básicas.
  String add() {
    result = (numOne + numTwo).toString(); // Suma
    numOne = double.parse(result); // Almacena el resultado como primer número para operaciones futuras.
    return doesContainDecimal(result); // Devuelve el resultado con formato.
  }

  String sub() {
    result = (numOne - numTwo).toString(); // Resta
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString(); // Multiplicación
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    if (numTwo == 0) {
      return 'Error'; // Manejo de división por cero.
    }
    result = (numOne / numTwo).toString(); // División
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  // Función para formatear los números y eliminar los decimales innecesarios.
  String doesContainDecimal(String result) {
    if (result.contains('.')) {
      List<String> splitDecimal = result.split('.'); // Divide el número en parte entera y decimal.
      if (int.parse(splitDecimal[1]) == 0) return splitDecimal[0]; // Elimina la parte decimal si es 0.
    }
    return result; // Devuelve el número formateado.
  }
}
