import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 6),
    Band(id: '2', name: 'Queen', votes: 1),
    Band(id: '3', name: 'Band', votes: 3),
    Band(id: '4', name: 'Mana', votes: 4),
    Band(id: '5', name: 'Wos', votes: 5)
  ];



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Band Names', style: TextStyle( color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: ( context, i ) => _bandTile( bands[i] )
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addNewBand,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction){
        //llamar el borrado en el server
      },
      background: Container(
        padding: const EdgeInsets.only( left: 8.0 ),
        color: Colors.redAccent,
        child: const Align(
          alignment: Alignment.centerLeft,
          child:  Text('Delete Band', style: TextStyle(color: Colors.white),),
        ),
      ),
      child: ListTile(
            leading: CircleAvatar(
              child: Text( band.name.substring(0,2) ),
              backgroundColor: Colors.blue[100],
            ),
            title: Text(band.name),
            trailing: Text( '${ band.votes }', style: const TextStyle(  fontSize: 20 )),
            onTap: () {
              print(band.name);
            },
          ),
    );
  }

  addNewBand(){

    final textController  = new TextEditingController();

    if( Platform.isAndroid ){

      return showDialog(
        context: context,
          builder: ( context ){
            return AlertDialog(
              title: const Text('New Band Name'),
              content:  TextField(controller: textController),
              actions: [
                MaterialButton(
                  child: const Text('Add'),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => addBandToList(textController.text)
                )
              ],
            );
          },
      );


    }

    showCupertinoDialog(
      context: context,
      builder: ( _ ){
        return CupertinoAlertDialog(
          title: Text('New Band Name'),
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
      }
    );




  }


  void addBandToList( String name ){
    if( name.length > 1 ){
      this.bands.add( Band(id: DateTime.now().toString() , name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);

  }


}