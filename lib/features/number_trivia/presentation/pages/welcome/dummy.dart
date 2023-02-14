import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test/features/number_trivia/presentation/components/auth_button.dart';
import 'package:test/features/number_trivia/presentation/components/mytextfield.dart';
import 'package:test/features/number_trivia/presentation/pages/schedule/models/docs.dart';

class Dummy extends StatefulWidget {
  Dummy({super.key});

  @override
  State<Dummy> createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  final nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final ageController = TextEditingController();

  late String _age;

  late String _name;

  @override
  void initState() {
    _name = "Flutter Campus";
    _age = "2";
    super.initState();
  }

  void addContact(Docs contact) {
    final docsBox = Hive.box('contacts');
    docsBox.add(contact);

    print(docsBox.length);

    print('Name: ${contact.name}, Age: ${contact.age}, ');
  }

  void addDocs(Docs doc) {
    final docsBox = Hive.box('contacts');

    docsBox.add(doc);
    print(docsBox);
  }

  onTap() {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox(
          'contacts',
          compactionStrategy: (int total, int deleted) {
            return deleted > 20;
          },
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final contactsBox = Hive.box('contacts');
            final statusController = TextEditingController();

            final size = MediaQuery.of(context).size;
            return Scaffold(
              appBar: AppBar(title: Text("Schedule Appointent")),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: size.height,
                      width: double.infinity,
                      child: Column(
                        children: [
                          // MyTextField(
                          //     controller: nameController,
                          //     hintText: "Enter name",
                          //     obsCureText: false),
                          // MyTextField(hintText: "Enter age", obsCureText: false),
                          SizedBox(
                            height: 25,
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Expanded(
                                  child: TextForm(nameController: nameController),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Expanded(
                                  child: TextFormField(
                                    controller: ageController,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade400)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        labelText: 'Age'),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            child: Text('Add New Contact'),
                            onPressed: () {
                              final newContact = Docs(
                                nameController.text,
                                int.parse(
                                  ageController.text,
                                ),
                              );
                              addContact(newContact);
                            },
                          ),
                          // ignore: deprecated_member_use
                          WatchBoxBuilder(
                            box: Hive.box(
                              'contacts',
                            ),
                            builder: (BuildContext context, contactsBox) {
                              return ListView.builder(
                                  itemCount: contactsBox.length,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder: ((context, index) {
                                    final contact =
                                        contactsBox.get(index) as Docs;
                                    // final one = contactsBox.get(0) as Docs;
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Text(contact.name),
                                          subtitle:
                                              Text(contact.age.toString()),
                                          trailing: IconButton(
                                              onPressed: () =>
                                                  contactsBox.deleteAt(index),
                                              icon: Icon(
                                                Icons.delete,
                                              )),
                                        ),
                                      ],
                                    );
                                  }));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class TextForm extends StatelessWidget {
  const TextForm({
    Key? key,
    required this.nameController,
  }) : super(key: key);

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey.shade400)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white)),
          labelText: 'Name'),
    );
  }
}
