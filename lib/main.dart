import 'package:fl_chart_pruebas/presentation/providers/theme_provider.dart';
import 'package:fl_chart_pruebas/screens/line_chart_example2.dart';
import 'package:fl_chart_pruebas/screens/radar_chart_example1.dart';
import 'package:fl_chart_pruebas/screens/theme_chager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(themeDarkProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      brightness: isDark ? Brightness.dark : Brightness.light, // Asegúrate de establecer la misma brightness aquí
    ),
    useMaterial3: true,
  ),
      home: const MyHomePage(title: 'Fl Chart'),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: const Icon(Icons.area_chart_rounded,),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              title: const Text('Line Chart Example 2'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=> const LineChartExample2())
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.radar,),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              title: const Text('Radar Chart Sample 1'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=> const RadarChartExample1())
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.palette_rounded,),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              title: const Text('Change theme'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=> const ThemeChanger())
                );
              },
            )
          ],
        ),
      )
    );
  }
}
