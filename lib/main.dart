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

final staticStringProvider = Provider((Ref ref) {
  return 'Hello, Riverpod!';
});

final intProvider = Provider((Ref ref) {
  return 42;
});

final doubleProvider = Provider((Ref ref) {
  return 42.65;
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(staticStringProvider);
    final resultInt = ref.watch(intProvider);
    final resultDouble = ref.watch(doubleProvider);
    return Scaffold(
      body: Center(
        child: Text(result + resultInt.toString() + resultDouble.toString()),
      ),
    );
  }
}
