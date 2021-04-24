import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routerDelegate = BeamerRouterDelegate(
      locationBuilder: SimpleLocationBuilder(
        routes: {
          '/': (context) => TestPage(title: 'Welcome'),
          '/page': (context) {
            final id = context.currentBeamLocation.state.queryParameters['id'];
            print('about to load page: $id');
            return TestPage(
              key: ValueKey('page-id-$id'),
              title: 'Page $id',
            );
          }
        },
      ),
    );

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: routerDelegate,
      routeInformationParser: BeamerRouteInformationParser(),
      backButtonDispatcher: BeamerBackButtonDispatcher(
        delegate: routerDelegate,
      ),
    );
  }
}

class TestPage extends StatefulWidget {
  TestPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('open item $index'),
            onTap: () {
              context.beamToNamed('/page?id=$index');
            },
          );
        },
      ),
    );
  }
}
