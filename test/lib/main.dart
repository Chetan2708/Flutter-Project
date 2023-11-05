import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/Widgets/modal.dart';
import 'package:test/utilities/imagecropper.dart';
import 'package:test/utilities/imagepicker.dart';
import 'package:test/Screen/recoganization_page.dart';
import 'colors.dart';
import 'Splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        // primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
      ),
      home: Splash(), //const MyHomePage(title: 'Text Extraction'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 39, 38, 38),
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(children: [
          SizedBox(height: 80),
          Image.asset('assets/logo.jpg'),
          SizedBox(height: 110),
          const Center(
            child: Text(
              'Click on the Scan button to add your certificate',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Pallete.whiteColor, 
                fontSize: 25,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ]),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          imagePickerModal(
            context,
            onCameraTap: () {
              pickImage(source: ImageSource.camera).then((value) {
                if (value != '') {
                  imageCropperView(value, context).then((value) {
                    if (value != '') {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => RecognizePage(
                            path: value,
                          ),
                        ),
                      );
                    }
                  });
                }
              });
            },
            onGAlleryTap: () {
              pickImage(source: ImageSource.gallery).then((value) {
                debugPrint("Gallery");
                if (value != '') {
                  imageCropperView(value, context).then((value) {
                    if (value != '') {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => RecognizePage(
                            path: value,
                          ),
                        ),
                      );
                    }
                  });
                }
              });
            },
          );
        },
        tooltip: 'Increment',
        label: const Text("Scan photo"),
        backgroundColor: Color.fromARGB(255, 224, 224, 224),
        icon: const Icon(Icons.add_a_photo),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
 