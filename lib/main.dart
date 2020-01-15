import 'package:flutter/material.dart';
import 'package:rx_dart/counter.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.I;

void main() { 
  // the git avoid to instantiate it multiple time
  getIt.registerSingleton<Counter>(Counter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  final  counter = getIt.get<Counter>();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
       title: Text(title),
      ),
      body: 
      StreamBuilder(stream: counter.stream$,
      builder: (BuildContext ctx, AsyncSnapshot snap){
        return 
        Center(
         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text('${snap.data}',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      )        ;
      },),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.increment(),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

