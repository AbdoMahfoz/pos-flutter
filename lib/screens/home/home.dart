import 'package:flutter/material.dart';
import 'package:posapp/viewmodels/home.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = new HomeViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<List<String>>(
          stream: viewModel.valuesStream,
          initialData: [],
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                StreamBuilder<int>(
                    stream: viewModel.counter,
                    initialData: 0,
                    builder: (context, snapshot) => Text(
                          "${snapshot.data}",
                          style: Theme.of(context).textTheme.headline4,
                        )),
                for (var item in snapshot.data!) Text(item)
              ],
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.addButtonClicked,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
