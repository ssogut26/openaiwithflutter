import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/image');
                  },
                  child: const SelectionContainer(
                    text: 'Go to Image Generator',
                    color: Colors.blue,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/text');
                  },
                  child: const SelectionContainer(
                    text: 'Go to Text Generator',
                    color: Colors.red,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                SelectionContainer(
                  text: 'Will be added soon',
                  color: Colors.yellow,
                ),
                SelectionContainer(
                  color: Colors.green,
                  text: 'Will be added soon',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SelectionContainer extends StatelessWidget {
  const SelectionContainer({
    required this.text,
    required this.color,
    super.key,
  });

  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(child: Text(text)),
    );
  }
}
