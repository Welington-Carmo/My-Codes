import 'package:flutter/material.dart';
import 'package:meu_tmb/models/person.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController sexo_ctrl = TextEditingController();
  final TextEditingController altura_ctrl = TextEditingController();
  final TextEditingController peso_ctrl = TextEditingController();
  final TextEditingController idade_ctrl = TextEditingController();

  String result = '';
  double Kcal = 0;
  bool confirmation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: Color(0xff666666), title: Text('TMB')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('MENU',
                    style: TextStyle(
                      fontSize: 60,
                      color: Colors.white
                    ),),
                ],
              ),
              decoration: BoxDecoration(
                color: Color(0xff666666),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {},
              tileColor: Color(0xffeeeeee),
            ),
            SizedBox(height: 5),
            ListTile(
              title: Text('Pesquisar'),
              onTap: () {},
              tileColor: Color(0xffeeeeee),
            )
          ],
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            color: Color(0xffdddddd),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: sexo_ctrl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Sexo',
                          hintText: 'ex: M'),
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        controller: idade_ctrl,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Idade',
                            hintText: 'ex: 20'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: altura_ctrl,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Altura',
                          hintText: 'ex: 175'),
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        controller: peso_ctrl,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Peso',
                            hintText: 'ex: 75'),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Calcular();
                    setState(() {});
                  },
                  child: Text('Calcular'),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TMB',
                      style: TextStyle(fontSize: 28),
                    ),
                    Container(
                      width: 72,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Color(0xffeeeeee),
                        border: Border.all(
                          color: Color(0xff666666),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(result),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Flexible(
                        child: ListView(shrinkWrap: true, children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Title(
                            color: Colors.black,
                            child: confirmation
                                ? Text('Ganho de massa',
                                    style: TextStyle(fontSize: 20))
                                : Text('')),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: confirmation
                              ? Text('${(Kcal + 500).toStringAsFixed(0)}Kcal com apenas musculação')
                              : Text('')),
                      confirmation
                          ? Text(
                              '${(Kcal + 1000).toStringAsFixed(0)}Kcal com musculação e aeróbico moderado')
                          : Text('')
                    ])),
                    SizedBox(
                      width: 50,
                    ),
                    Flexible(
                        child: ListView(shrinkWrap: true, children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Title(
                            color: Colors.black,
                            child: confirmation
                                ? Text('Perda de peso',
                                    style: TextStyle(fontSize: 20))
                                : Text('')),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: confirmation
                              ? Text('${(Kcal + 100).toStringAsFixed(0)}Kcal com apenas musculação')
                              : Text('')),
                      confirmation
                          ? Text(
                              '${(Kcal + 500).toStringAsFixed(0)}Kcal com musculação e aeróbico moderado')
                          : Text('')
                    ]))
                  ],
                )
              ],
            ),
          )),
    );
  }

  void Calcular() {
    double Result;

    Person person = Person(
        sexo: sexo_ctrl.text[0],
        altura: int.parse(altura_ctrl.text),
        peso: int.parse(peso_ctrl.text),
        idade: int.parse(idade_ctrl.text));
    if (person.sexo == 'M' || person.sexo == 'm') {
      Result = 66 +
          (13.8 * person.peso) +
          (5 * person.altura) -
          (6.8 - person.idade);
      setState(() {
        result = Result.toStringAsFixed(0).toString() + ' Kcal';
        Kcal = Result;
        confirmation = true;
      });
    } else if (person.sexo == 'F' || person.sexo == 'f') {
      Result = 655 +
          (9.6 * person.peso) +
          (1.8 * person.altura) -
          (4.7 - person.idade);
      setState(() {
        result = Result.toStringAsFixed(0).toString() + ' Kcal';
        Kcal = Result;
        confirmation = true;
      });
    } else {
      setState(() {
        result = 'digite corretamente';
      });
    }
  }
}
