import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(
        home: const MyApp(),
      ),
    ),
  );
}

final counterProvider = StateProvider<int>((Ref ref) {
  return 0;
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('build method loaded');
    return Scaffold(
      appBar: AppBar(title: Text('State Provider Tutorial')),
      body: Center(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final int counter = ref.watch(counterProvider);
            debugPrint('Consumer method loaded');
            return Text(counter.toString());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: const Icon(Icons.add),
      ),
    );
  }
}
