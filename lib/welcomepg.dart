import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class welcomepg extends StatefulWidget {
  @override
  _welcomepgState createState() => _welcomepgState();
}

class _welcomepgState extends State<welcomepg> {
  TextEditingController titlectrl = TextEditingController();
  TextEditingController descctrl = TextEditingController();
  Map<String, dynamic>addToBlog; /*mapping to firebase*/
/*submit function to assign value and add to firebase when complete as return to previous page */
  submitBlog(){
    addToBlog={
      'Title': titlectrl.text,
      'Desc': descctrl.text,
    };
    ref.add(addToBlog).whenComplete(() => Navigator.pop(context));
  }
  final ref = Firestore.instance.collection('BlogApp'); //assigning variable to collection
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Lockdown Blog 2020-21'),
        backgroundColor: Colors.blue[400],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
                stream: ref.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> Snapshot)
                {
                  if (Snapshot.hasData) {
                    return Container(
                      height: 500,
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: Snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors. grey[200],
                                  child: Container(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                         Text(Snapshot.data.documents[index].data['Title']),
                                         SizedBox(width: 15),
                                         Text(Snapshot.data.documents[index].data['Desc']),
                                         InkWell(
                                           onTap: (){
                                             Snapshot.data.documents[index].reference.delete();
                                           },
                                             child: Icon(Icons.delete, color: Colors.grey,)),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          Container(
                            height: 40, width: 200,
                            color: Colors.grey,
                            child: TextButton(
                              onPressed: (){
                                showDialog(context: context, builder: (context) => Dialog(
                                  child: Container(
                                    height: 300, width: 400,
                                    decoration: BoxDecoration(color: Colors.grey[150]),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: TextFormField(
                                            autocorrect: true,
                                          initialValue: '   ',
                                            controller: titlectrl,
                                            decoration: InputDecoration(
                                              labelText: 'Title', hintText: 'Enter blog Title',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: TextFormField(
                                            autocorrect: true,
                                            controller: descctrl,
                                            decoration: InputDecoration(
                                              labelText: 'Desc', hintText: 'Enter Desc',
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 40, width: 150,
                                          decoration: BoxDecoration(color: Colors.grey[200]),
                                          child: TextButton(
                                            onPressed: (){
                                              submitBlog();
                                            },
                                            child: Text('Submit'),
                                          )
                                        ),

                                      ],
                                    ) ,
                                  ),
                                ));
                              },
                              child: Text('Add New Blog', style: TextStyle(color: Colors.white),),
                            ),
                          )
                      ]),
                    );
                  } else{
                    return CircularProgressIndicator();}
                }),
          ],
        ),
      ),
    );
  }
}
