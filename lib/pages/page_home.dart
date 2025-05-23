import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_practice_sample_1_with_state_managenment_provider/controller/db_provider.dart';
import 'package:sqflite_practice_sample_1_with_state_managenment_provider/pages/add_page.dart';

import '../database_service.dart';

class PageHome_Sample_1 extends StatefulWidget {
  @override
  State<PageHome_Sample_1> createState() => _FirstPageState();
}

class _FirstPageState extends State<PageHome_Sample_1> {
  // List<Map<String, dynamic>> dataList = [];

  DatabaseService? dbRef = DatabaseService.database_instance;

  TextEditingController title_con = TextEditingController();
  TextEditingController des_con = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<DatabaseProvider>().getInitialData();

    /*  dbRef = DatabaseService.database_instance;
    getData_from_Database();*/
  }

/*  void getData_from_Database() async {
    dataList = await dbRef!.getAllData();
    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: Text(
          'Provider with Database',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<DatabaseProvider>(builder: (ctx, provider, __) {
        List<Map<String, dynamic>> dataList = provider.getData();
        return dataList.isNotEmpty
            ? ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(
                      dataList[index][dbRef?.COLUMN_TITLE],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    subtitle: Text(dataList[index][dbRef?.COLUMN_DESCRIPTION]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                            onTap: () {
                              /*      getBottomSheet(
                            isUpdate: true,
                            s_no: dataList[index]
                            [dbRef?.COLUMN_SERIAL_NUMBER]);*/

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Addpage(
                                            isUpdate: true,
                                            title: dataList[index]
                                                [dbRef?.COLUMN_TITLE],
                                            des: dataList[index]
                                                [dbRef?.COLUMN_DESCRIPTION],
                                            s_no: dataList[index]
                                                [dbRef?.COLUMN_SERIAL_NUMBER],
                                          )));
                              /*
                        title_con.text =
                        dataList[index][dbRef?.COLUMN_TITLE];
                        des_con.text =
                        dataList[index][dbRef?.COLUMN_DESCRIPTION];*/
                            },
                            child: Icon(Icons.edit)),
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () {
                            /*    dbRef!.deleteData( S_no: dataList[index]
                      [dbRef?.COLUMN_SERIAL_NUMBER] );
                      getData_from_Database();*/
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                  );
                })
            : Center(
                child: Text('No notes yet!'),
              );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[400],
        foregroundColor: Colors.black,
        onPressed: () {
          // getBottomSheet();

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Addpage()));

          // Clear the controllers
          title_con.clear();
          des_con.clear();
          //end

          // dbRef!.addData(
          //     Title: "Hello World", Description: "Welcome to dart programming");
          // getData_from_Database();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // show bottom sheet on floating action button function >>
/*  void getBottomSheet({bool isUpdate = false, int s_no = 0}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(
                    isUpdate ? 'Update Task' : 'Add Task',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              SizedBox(height: 16),
              TextField(
                controller: title_con,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(), // Adds border
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: des_con,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(), // Adds border
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      String title_text_catch = title_con.text;
                      String des_text_catch = des_con.text;

                      // Check if either title or description is empty
                      if (title_text_catch.isEmpty || des_text_catch.isEmpty) {
                        _showAlertDialog(
                            'Please fill out both fields before adding!');
                      } else {
                        // If both fields are not empty, add the data to the database
                        isUpdate
                            ? dbRef!.updateData(
                            Title: title_text_catch,
                            Description: des_text_catch,
                            S_no: s_no)
                            : dbRef!.addData(
                          Title: title_text_catch,
                          Description: des_text_catch,
                        );
                        getData_from_Database();

                        // Close the bottom sheet
                        Navigator.pop(context);
                      }
                    },
                    child: Text(isUpdate ? 'Update' : 'Add'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close bottom sheet
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }*/

// show alert dialog on blank fields function >>
/*  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error!'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }*/
}
