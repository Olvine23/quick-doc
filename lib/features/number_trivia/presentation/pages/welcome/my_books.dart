// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/core/styles/styles.dart';
import 'package:test/features/number_trivia/presentation/pages/schedule/models/books.dart';
import 'package:test/features/number_trivia/presentation/pages/welcome/dummy.dart';
import 'package:test/features/number_trivia/presentation/widgets/notif_sect.dart';
import 'package:test/features/number_trivia/presentation/widgets/top_doc.dart';
import 'package:test/main.dart';

class MyBooks extends StatefulWidget {
  const MyBooks({super.key});

  @override
  State<MyBooks> createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  final _author = TextEditingController();
  final _doc = TextEditingController();
  final _title = TextEditingController();
  final _freq = TextEditingController();
  final _dateInput = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late dynamic day;
  bool _validate = false;

  DateTime? _dateTime = DateTime.now();

  _showDate() async {
    DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(3000))
        .then((value) {
      setState(() {
        _dateTime = value;
        _dateInput.text = DateFormat('dd MMM yyyy').format(_dateTime!);
      });
      return null;
    });

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate);
      print(pickedDate.day);
    } else
      print("something is wrpng");
  }

  @override
  void dispose() {
    _author.dispose();
    _doc.dispose();
    _title.dispose();
    super.dispose();
    _freq.dispose();
    _dateInput.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Appointments")),
      body: ValueListenableBuilder(
          valueListenable: Hive.box<Books>('booksBox').listenable(),
          builder: ((context, Box<Books> books, _) {
            if (books.values.isEmpty) {
              final size = MediaQuery.of(context).size;
              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height: size.height,
                    margin: EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        Text(
                          "There is nothing yet",
                          style: kHeadStyle,
                        ),
                        Center(
                            child: Lottie.network(
                          'https://assets4.lottiefiles.com/packages/lf20_RBLKseLycb.json',
                        )),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              print(books.values.length);

              day = _dateTime!.day;
              print(day);
              var showText = DateFormat('dd MMM yyyy').format(_dateTime!);
              print(showText);
              return SingleChildScrollView(
                  child: SafeArea(
                child: Column(
                  children: [
                     
                    ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: books.values.length,
                      itemBuilder: (context, index) {
                        var res = books.getAt(index);
                        print(res!.date);
                        var showDateText =
                            DateFormat('dd MMM yyyy').format(res.date!);
                        return Dismissible(
                          key: Key(res.toString()),
                          onDismissed: (direction) {
                            box!.deleteAt(index);
                          },
                          child: Card(
                            child: ListTile(
                                title: Text(res.doc as String),
                                subtitle: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Text(res.doc!),
                                    Text(showDateText),
                                    // Text(res.date!.toString()),
                                    Text(res.quantity.toString()),
                                  ],
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    box!.deleteAt(index);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                  ),
                                )),
                          ),
                        );
                      },
                    ),
                    ElevatedButton.icon(
                        onPressed: () => Notify.instantNotify(),
                        icon: Icon(Icons.notification_add),
                        label: Text("Add Notificaion")),
                    ElevatedButton.icon(
                        onPressed: () => Notify.schedulenotify(),
                        icon: Icon(Icons.notification_add),
                        label: Text("Add Notificaion")),
                    ElevatedButton.icon(
                        onPressed: _showDate,
                        icon: Icon(Icons.notification_add),
                        label: Text("Pick Date")),
                    Text(showText)
                  ],
                ),
              ));
            }
          })),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(CustomColors.header01),
          child: Icon(Icons.add),
          onPressed: () => addNewBook(context)),
    );
  }

  addNewBook(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(8.0),
            title: const Text("Schedule Appointment"),
            content: Container(
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      }),
                      controller: _doc,
                      decoration: InputDecoration(
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          icon: Icon(Icons.person_add),
                          hintText: 'Doc Name'),
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      }),
                      controller: _dateInput,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today), hintText: 'Date'),
                      readOnly: true,
                      onTap: _showDate,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      }),
                      controller: _author,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.medical_information),
                          hintText: 'Ailment'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return "This field is required";
                        }
                        return null;
                      }),
                      keyboardType: TextInputType.number,
                      controller: _freq,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.phone), hintText: 'Phone Number'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await box!.put(
                                DateTime.now().toString(),
                                Books(
                                    title: _title.text,
                                    date: _dateTime,
                                    quantity: int.parse(_freq.text),
                                    author: _author.text,
                                    doc: _doc.text));

                            Navigator.pop(context);
                            _author.clear();
                            _title.clear();
                            _doc.clear();
                            _freq.clear();
                            _dateInput.clear();
                          }
                        },
                        child: const Text("Add")),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
