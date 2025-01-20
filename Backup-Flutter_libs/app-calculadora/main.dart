import 'package:flutter/material.dart';
import 'calculadora.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Calculadora'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  //alignment: Alignment.center,
                  //color: Colors.amber,
                  //child: const Text('Cabeçalho'),
                  ),
            ),
            Expanded(
              flex: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        /*alignment: Alignment.center,
                      color: Colors.red,
                      child: const Text('Primeira coluna'),*/
                        ),
                  ),
                  Expanded(
                    flex: 3,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Garante que o elemento nunca ultrapasse 400 de largura
                        final double width = constraints.maxWidth > 400 ? 400 : constraints.maxWidth;
                        return Align(
                          alignment: Alignment.center,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: width,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 170, 197, 255),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 134, 176, 255),
                                  width: 1,
                                ),
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.greenAccent,
                                    blurRadius: 5,
                                    offset: Offset(-10, 10),
                                  ),
                                ],
                              ),
                              child: const Calculadora(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        /*alignment: Alignment.center,
                      color: Colors.orange,
                      child: const Text('Terceira coluna'),*/
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                  //alignment: Alignment.center,
                  //color: Colors.blue,
                  //child: const Text('Rodapé'),
                  ),
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),*/
    );
  }
}
