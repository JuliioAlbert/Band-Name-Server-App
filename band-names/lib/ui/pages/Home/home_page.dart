import 'dart:io';

import 'package:app_scaffold/domain/entities/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: "Guns Roses", votes: 1),
    Band(id: '2', name: "Green Day", votes: 10),
    Band(id: '3', name: "Heroes", votes: 12),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bandas"),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, index) => Banda(banda: bands[index]),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: addNewBand,
        child: const Icon(
          Icons.add_box_sharp,
        ),
        elevation: 1,
      ),
    );
  }

  void addNewBand() {
    final TextEditingController textController = new TextEditingController();

    if (Platform.isAndroid) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("New Banda Name"),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              onPressed: () => addBandToList(textController.text),
              child: Text("Add"),
              elevation: 5,
              textColor: Colors.red,
            )
          ],
        ),
      );
      return;
    }
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text("New Band"),
              content: CupertinoTextField(
                controller: textController,
              ),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Add"),
                  onPressed: () => addBandToList(textController.text),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text("Dissmiss"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ));
  }

  void addBandToList(String name) {
    print(name);
    if (name.length > 1) {
      bands.add(new Band(id: '10', name: name, votes: 20));
      setState(() {});
    }
    Navigator.pop(context);
  }
}

class Banda extends StatelessWidget {
  const Banda({
    Key? key,
    required this.banda,
  }) : super(key: key);

  final Band banda;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        //!Llamar el borrar el el server
        print("Borrar desde el server");
      },
      direction: DismissDirection.startToEnd,
      background: Container(
        color: Colors.red,
        padding: const EdgeInsets.only(left: 10),
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Delete",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      key: Key(banda.id),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red[100],
          child: Text(banda.name.substring(0, 2)),
        ),
        title: Text(banda.name),
        trailing: Text(
          "${banda.votes}",
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () => print(banda.name),
      ),
    );
  }
}
