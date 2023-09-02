import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.shade400,
          toolbarHeight: 70,
          elevation: 14,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(70),
                  bottomLeft: Radius.circular(70))),
          title: const Text(
            'Insertion Sort!',
          ),
          centerTitle: true,
        ),
        body: const ListViewComponent(),
      ),
    );
  }
}

class ListViewComponent extends StatefulWidget {
  const ListViewComponent({Key? key}) : super(key: key);

  @override
  State<ListViewComponent> createState() => _ListViewComponentState();
}

class _ListViewComponentState extends State<ListViewComponent> {
  List<int> entries = <int>[1,2,4,2,5,3,7,1,3,8,2];
  int colorIndex = -1;
  int colorCompareIndex = -1;

  @override
  void initState() {
    super.initState();
    sortEntries();
  }

  Future<void> sortEntries() async {
    insertionSort();
  }

  void snackBarWidget(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  void insertionSort() async {
    await Future.delayed(const Duration(seconds: 1));
    snackBarWidget("Insertion Sort Started!");
    for (int i = 1; i < entries.length; i++) {
      await Future.delayed(const Duration(seconds: 1));
      int key = entries[i];
      int j = i - 1;
      while (j >= 0 && entries[j] > key) {
        await Future.delayed(const Duration(seconds: 1));
        setState(() {
          colorCompareIndex = j;
        });
        entries[j + 1] = entries[j];
        j--;
        entries[j + 1] = key;
      }
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        colorIndex = i;
      });
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        colorCompareIndex = i ;
      }); // Liste sıralandığında widget'i güncelle
    }
    snackBarWidget("Insertion Sort Finished");
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  height: 50,
                  decoration: colorCompareIndex == index
                      ? BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(70),
                        topLeft: Radius.circular(70)),
                    color: colorIndex == index
                        ? Colors.red
                        : (colorCompareIndex == index
                        ? Colors.tealAccent
                        : Colors.white),
                  )
                      : BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(70),
                        bottomLeft: Radius.circular(70)),
                    color: colorIndex+1 == index
                        ? Colors.yellowAccent
                        : (colorCompareIndex == index
                        ? Colors.tealAccent
                        : Colors.white),
                  ),
                  child: Center(
                    child: Text('Index $index: ${entries[index]}'),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
