import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_names/scr/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'Gueen', votes: 1),
    Band(id: '3', name: 'Heroes del silencio', votes: 7),
    Band(id: '4', name: 'AC/DC', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bandas de Musica',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, index) => _bandTile(bands[index])),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction $direction');
        print('id: ${band.id}');
        // TODO: llamar el borrado en el server
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.lightBlue[50],
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Delete Band',
            style: TextStyle(color: Colors.blue[600]),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () => print(band.name),
      ),
    );
  }

  addNewBand() {
    final textControllerUsuario = new TextEditingController();
    final textControllerAlias = new TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (builder) {
            return AlertDialog(
              title: Text('New Band Name'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Usuario:'),
                    TextField(
                      controller: textControllerUsuario,
                    ),
                    //Text('Alias'),
                    // TextField(
                    //   controller: textControllerAlias,
                    // )
                  ],
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                    child: Text('Add'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => addBandToList(textControllerUsuario.text))
              ],
            );
          });
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
              title: Text('New Band Name'),
              content: CupertinoTextField(
                controller: textControllerUsuario,
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: Text('Add'),
                    onPressed: () => addBandToList(textControllerUsuario.text)),
                CupertinoDialogAction(
                    child: Text('Dismiss'),
                    isDestructiveAction: true,
                    onPressed: () => Navigator.pop(context))
              ]);
        });
  }

  void addBandToList(String name) {
    print(name);
    if (name.length > 1) {
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
