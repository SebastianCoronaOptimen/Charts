import 'package:fl_chart_pruebas/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeChanger extends ConsumerWidget {
  const ThemeChanger({super.key});

  void openDialog( BuildContext context){
    showDialog(context: context, 
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text('Autentificación'),
      content: const Text('Para acceder, la aplicación hará uso de tus datos biométricos. ¿Continuar?'),
      actions: [
        TextButton(onPressed: () {Navigator.of(context).pop();}, child: const Text('Cancelar')),
        FilledButton(onPressed: (){Navigator.of(context).pop();}, child: const Text('Aceptar'),)
      ],
    ),);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bool darkTheme = ref.watch(themeDarkProvider);

    return Scaffold(
      appBar: AppBar(),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Dark?'),
          Switch(value: darkTheme, onChanged: (value) {
            ref.read(themeDarkProvider.notifier).update((state) => value);
          },),
          FilledButton.tonal(onPressed: ()=> openDialog(context), child: const Text('Mostrar dialogo'))
        ],
      )
      )
      );

  }
}