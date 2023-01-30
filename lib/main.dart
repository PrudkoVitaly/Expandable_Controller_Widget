import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expandable Widget',
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
  late ExpandableController controller;

  @override
  void initState() {
    super.initState();
    controller = ExpandableController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expandable Widget"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          buildCard("Title -1",
              "https://bipbap.ru/wp-content/uploads/2017/04/0_7c779_5df17311_orig.jpg"),
        ],
      ),
    );
  }

  Widget buildCard(String title, String urlImage) {
    final loremIpsum =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas magna nisl, auctor in dui vel, consequat pellentesque massa. Praesent mattis quam vel mi imperdiet accumsan. Sed eget rhoncus nisi, at vestibulum est. Nam semper lorem eu odio porta porta quis sed velit. Donec non malesuada lacus. Nulla dignissim neque vitae tellus porta commodo.";
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => controller.toggle(),
                child: Image.network(urlImage),
              ),
              ScrollOnExpand(
                // package expandable: ^5.0.1
                child: ExpandablePanel(
                  controller: controller,
                  theme: const ExpandableThemeData(
                    expandIcon: Icons.arrow_downward,
                    collapseIcon: Icons.arrow_upward,
                    tapBodyToCollapse: true,
                    tapBodyToExpand: true,
                  ),
                  header: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  collapsed: GestureDetector(
                    onTap: () => controller.toggle(),
                    child: Text(
                      loremIpsum,
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  expanded: Text(
                    List.generate(5, (_) => loremIpsum).join("\n\n"),
                    style: const TextStyle(fontSize: 18),
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0).copyWith(top: 0),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
