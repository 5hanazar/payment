import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SimCardItem extends StatefulWidget {
  final String operator;
  final String phone;

  const SimCardItem({super.key, required this.operator, required this.phone});

  @override
  State<SimCardItem> createState() => _SimCardItemState();
}

class _SimCardItemState extends State<SimCardItem> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 10),
      color: const Color(0xFFF0F9FD),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 24, left: 120, bottom: 24, right: 24),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(widget.operator, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
              Text(widget.phone, style: const TextStyle(fontSize: 16))
            ]),
          ),
          Positioned(top: -30, child: SvgPicture.asset('assets/svg_sim_card.svg', height: 120)),
          Positioned(right: -42, top: 18, child: SvgPicture.asset('assets/svg_chip.svg', height: 150)),
          // Positioned(bottom: -20, right: 8, child: Lottie.asset('assets/lottie_signal.json', width: 120, height: 120, frameRate: FrameRate(60), controller: _controller,
          //     onLoaded: (composition) {
          //       _controller
          //         ..duration = composition.duration * 2
          //         ..repeat();
          //     })),
        ],
      ),
    );
  }
}