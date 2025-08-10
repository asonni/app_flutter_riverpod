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

final textProvider = StateProvider<String>((Ref ref) => '');

final durationProvider = Provider((_) => const Duration(seconds: 2));

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _controller;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Initialize the controller and listen for changes
    _controller = TextEditingController();
    _controller.addListener(() {
      ref.read(textProvider.notifier).state = _controller.text;
    });

    final duration = ref.read(durationProvider);
    _animationController = AnimationController(
      vsync: this,
      duration: duration,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = ref.watch(textProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(controller: _controller),
            const SizedBox(height: 20),
            Text('You typed: $text'),
            const SizedBox(height: 120),
            const Text('Pulsing Circle'),
            const SizedBox(height: 20),
            Center(
              child: ScaleTransition(
                scale: _animationController.drive(Tween(begin: 0.5, end: 1.5)),
                child: const Icon(Icons.circle, size: 80, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
