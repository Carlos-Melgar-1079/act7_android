import 'package:flutter/material.dart';
import 'package:myapp/services/firebase_services.dart' show getPeople, deletePeople;

// importaciones de firebase

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi CRUD"),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder(
        future: getPeople(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  onDismissed: (direction)async{
                    await deletePeople(snapshot.data?[index]['uid']);
                  },
                  confirmDismiss: (direction) async{
                    bool result = false;

                    result = await showDialog(context:context ,builder:(context){
                      return AlertDialog(
                        title:  Text("estas seguro q quieres eliminar a ${snapshot.data?[index]['name']}"),
                        actions: [
                          TextButton(onPressed: (){
                            return Navigator.pop(context, false);
                          },
                           child:const Text("cancelar", style: TextStyle(color: Colors.red))),
                          TextButton(onPressed: (){
                            return Navigator.pop(context, true,);
                          }, child:const Text("si, esoy seguro"))
                        ],
                      );
                    });

                    return result;
                  },
                  background: Container(
                    child: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                  direction: DismissDirection.endToStart,
                  key: Key(snapshot.data?[index]['uid']),
                  child: ListTile(
                    
                    title: Text(snapshot.data?[index]['name']),
                    onTap: (() async {
                      await Navigator.pushNamed(
                        context,
                        "/edit",
                        arguments: {
                          "name": snapshot.data?[index]['name'],
                          "uid": snapshot.data?[index]['uid'],
                        },
                      );
                      setState((){});
                    }),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
