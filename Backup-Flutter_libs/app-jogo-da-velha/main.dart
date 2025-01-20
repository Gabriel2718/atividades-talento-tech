import 'package:flutter/material.dart';
import 'componentes/jogo_da_velha.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jogo da Velha',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Jogo da Velha'),
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
      backgroundColor: const Color.fromARGB(255, 29, 29, 29),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 93, 123, 185),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
                Flexible(
                  flex: 4,
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 100,
                        maxWidth: 400,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 63, 104, 190),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromARGB(255, 0, 16, 46),
                              width: 1,
                            ),
                            boxShadow: const <BoxShadow>[
                              BoxShadow(
                                color: Color.fromARGB(255, 0, 124, 173),
                                blurRadius: 3,
                                offset: Offset(-12, 12),
                              ),
                              BoxShadow(
                                color: Color.fromARGB(255, 134, 89, 218),
                                blurRadius: 0,
                                offset: Offset(-5, 5),
                              ),
                            ],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Jogo(),
                          ),
                        ),
                      )),
                ),
                Flexible(
                  flex: 1,
                  child: Container(),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
