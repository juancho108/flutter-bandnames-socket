import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Soda Stereo', votes: 4),
    Band(id: '3', name: 'Queen', votes: 0),
    Band(id: '4', name: 'Tan Bionica', votes: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (BuildContext context, int index) =>
              _bandTile(bands[index])),
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
        print('direction: $direction');
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Delete Band',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[200],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final textController = new TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('New Band Name:'),
              content: TextField(
                controller: textController,
              ),
              actions: [
                MaterialButton(
                    child: Text('Add'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => addBandToList(textController.text))
              ],
            );
          });
    }

    showCupertinoDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: Text('New Band Name:'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandToList(textController.text),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      //Podemos agregar
      this
          .bands
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
