import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_name/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Hilsong', votes: 5),
    Band(id: '2', name: 'Grupo Rojo', votes: 4),
    Band(id: '3', name: 'Barak', votes: 8),
    Band(id: '4', name: 'Grace', votes: 9),
    Band(id: '5', name: 'Aposento Alto', votes: 10),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BandName',
            style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
        elevation: 1,
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => _bandTile(bands[i])),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        child: const Icon(Icons.add),
        onPressed: addNewBand,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('diraction: $direction');
        print('Id: ${band.id}');
        //TODO: Llamar el borrado del server
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Text(
          'Delete Band',
          style: TextStyle(color: Colors.white),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name!.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name!),
        trailing: Text('${band.votes}', style: const TextStyle(fontSize: 20)),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = new TextEditingController();

    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: const Text('New Band Name:'),
              content: CupertinoTextField(
                controller: textController,
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text('Add'),
                  onPressed: () => addBandToList(textController.text),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text('Dismiss'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            );
          });
    }
    if (Platform.isAndroid) {
      //Es Androird
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('New Band Name:'),
              content: TextField(controller: textController),
              actions: <Widget>[
                MaterialButton(
                    child: const Text('Add'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => addBandToList(textController.text))
              ],
            );
          });
    } else {
      //Es Androird
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('New Band Name:'),
              content: TextField(controller: textController),
              actions: <Widget>[
                MaterialButton(
                    child: const Text('Add'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => addBandToList(textController.text))
              ],
            );
          });
    }
  }

  void addBandToList(String name) {
    print(name);
    if (name.length > 1) {
      //podemos Agregar
      bands.add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
