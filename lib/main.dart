import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:form_validation/form_validation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

// LOGIN PAGE
class _LoginState extends State<Login> {
  String email = "";
  String emailError = "";
  String passwd = "";
  String passwdError = "";
  bool _loading = false;

  final _formKey = GlobalKey<FormState>();

  void _onSubmit() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 3));
    _loading = false;
    if (mounted == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.4, 0.8],
                    colors: [
                      Color.fromARGB(255, 199, 243, 241),
                      Color.fromARGB(255, 112, 231, 235)
                    ],
                  )),
              child: Row(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: SvgPicture.asset(
                        'assets/images/bg.svg',
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Container(
                          child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: TextFormField(
                                      validator: (value) {
                                        var validator = Validator(
                                          validators: [
                                            RequiredValidator(),
                                            EmailValidator(),
                                          ],
                                        );

                                        return validator.validate(
                                          context: context,
                                          label: 'Email',
                                          value: value,
                                        );
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          email = value;
                                        });
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                          labelText: 'Email',
                                          errorBorder: InputBorder.none,
                                          border: InputBorder.none),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(emailError),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: TextFormField(
                                      validator: (value) {
                                        var validator = Validator(
                                          validators: [
                                            RequiredValidator(),
                                          ],
                                        );

                                        return validator.validate(
                                          context: context,
                                          label: 'Password',
                                          value: value,
                                        );
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          passwd = value;
                                        });
                                      },
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        labelText: 'Password',
                                        errorBorder: InputBorder.none,
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(passwdError),
                            const SizedBox(
                              height: 5,
                            ),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 70, vertical: 20),
                                  primary:
                                      const Color.fromARGB(255, 73, 182, 185),
                                ),
                                onPressed: () {
                                  // Validate returns true if the form is valid, or false otherwise.
                                  if (_formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Processing Data')),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyHomePage(
                                                title: "",
                                                email: email,
                                                passwd: passwd,
                                              )),
                                    );
                                  }
                                },
                                child: const Text(
                                  'Login Now',
                                  style: TextStyle(fontSize: 20),
                                )),
                          ],
                        ),
                      ))),
                ],
              ),
            )),
      ),
    );
  }
}

// HOME PAGE
class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {Key? key,
      required this.title,
      required this.email,
      required this.passwd})
      : super(key: key);
  final String title;
  final String email;
  final String passwd;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _recipient = TextEditingController();
  final TextEditingController _subject = TextEditingController();
  final TextEditingController _body = TextEditingController();
  List<String> recipients = [];
  List<PlatformFile> attachments = [];
  List<String> attachmentPath = [];

  @override
  void dispose() {
    super.dispose();
    _recipient.dispose();
    _subject.dispose();
  }

  void removeRecipient(int index) {
    setState(() {
      recipients.removeAt(index);
    });
  }

  sendMail(
      {required String username,
      // required List<String> recipients,
      required String password,
      required List<String> attachmentPath,
      required String subject,
      required String text,
      required List<String> recipients
      // required String html,
      }) async {
    Iterable<Attachment> toAt(Iterable<String>? attachmentPath) =>
        (attachmentPath ?? []).map((a) => FileAttachment(File(a)));

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username)
      ..recipients.addAll(recipients)
      // ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
      // ..bccRecipients.add(const Address('bccAddress@example.com'))
      ..subject = subject
      ..text = text
      // ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>"
      ..attachments.addAll(toAt(attachmentPath));
    // ..attachments = [
    //   FileAttachment(File('M-TT-01-Phieugiaoviec.docx')),
    // ];

    // ..attachments.addAll(attachments);
    try {
      final sendReport = await send(message, smtpServer);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message successfully sent')),
      );
    } on MailerException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message not sent.')),
      );
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
                icon: const Icon(Icons.send_outlined),
                onPressed: () {
                  sendMail(
                      username: widget.email,
                      password: widget.passwd,
                      subject: _subject.text,
                      text: _body.text,
                      recipients: recipients,
                      attachmentPath: attachmentPath);
                })
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            // height:MediaQuery.of(context).size.height*1,
            width: MediaQuery.of(context).size.width * 1,
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _recipient,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Recipient',
                          hintText: 'example@gmail.com',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                          onPressed: () {
                            if (_recipient.text == '') return;
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(_recipient.text);
                            if (!emailValid) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Invalid Email'),
                                    content: const Text(
                                        'Please enter a valid email address'),
                                    actions: [
                                      ElevatedButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          return Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
                            }
                            setState(() {
                              recipients.add(_recipient.text);
                            });
                            setState(() {
                              _recipient.clear();
                            });
                          },
                          child: const Text('Add to recipients list')),
                      const SizedBox(height: 10),
                      recipients.isEmpty
                          ? const SizedBox(height: 0)
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                  const Text('Recipients',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  for (var i = 0; i < recipients.length; i++)
                                    Row(children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          recipients[i],
                                          softWrap: false,
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                      IconButton(
                                          icon: const Icon(Icons.remove_circle,
                                              color: Colors.red),
                                          onPressed: () {
                                            removeRecipient(i);
                                          })
                                    ])
                                ]),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _subject,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: 'Subject',
                          hintText: 'Title of your email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _body,
                        minLines:
                            6, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          labelText: 'Content of your email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Click on the button to attach a file'),
                          const SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles();
                              if (result == null) return;
                              PlatformFile file = result.files.first;
                              setState(() {
                                attachments.add(file);
                                attachmentPath.add(file.path.toString());
                              });
                            },
                            child: const Text('Pick a file'),
                          ),
                          const SizedBox(height: 10),
                          attachments.isEmpty
                              ? const SizedBox(height: 0)
                              : Container(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                      const Text(
                                        'Attachment files',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      for (var i = 0;
                                          i < attachments.length;
                                          i++)
                                        Row(children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              attachments[i].name,
                                              softWrap: false,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                          IconButton(
                                              icon: const Icon(
                                                  Icons.remove_circle,
                                                  color: Colors.red),
                                              onPressed: () {
                                                setState(() {
                                                  attachments.removeAt(i);
                                                });
                                              })
                                        ])
                                    ]))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
