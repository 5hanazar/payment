import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:payment/location.dart';
import 'package:payment/presentation/views/location_list_item.dart';
import 'package:payment/presentation/views/sim_card_item.dart';
import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final locations = <LocationDto>[
    LocationDto(
      imageUrl: 'assets/img_tmcell.jpg',
      name: 'TM CELL - Telefon',
      country: 'Turkmenistan',
    ),
    LocationDto(
      imageUrl: 'assets/img_astu.jpg',
      name: 'AŞTU - Internet',
      country: 'Turkmenistan',
    ),
    LocationDto(
      imageUrl: 'assets/img_telekom.jpg',
      name: 'Telekom - Internet',
      country: 'Turkmenistan',
    ),
  ];
  List<SimInfo>? simInfo;

  @override
  void initState() {
    super.initState();
    _getSimInfo();
  }

  void _getSimInfo() async {
    super.initState();
    final simCardInfoPlugin = SimCardInfo();
    simInfo = await simCardInfoPlugin.getSimInfo() ?? [];
    print(simInfo);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFB3E5FC), // vibrant blue
              Color(0xFFFFFFFF), // deep blue
              Color(0xFFF8BBD0), // soft pink
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Container(margin: const EdgeInsets.only(top: 24, right: 8, bottom: 6, left: 8),
                          child: const Text("SIM Kartlar", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white))),
                      Positioned(bottom: -20, right: 8, child: Lottie.asset('assets/lottie_signal.json', width: 120, height: 120, frameRate: const FrameRate(60))),
                    ],
                  ),
                  for (final sim in simInfo ?? [])
                    SimCardItem(operator: sim.displayName, phone: sim.number == "" ? "N/A" : sim.number),
                  Container(margin: const EdgeInsets.only(top: 24, right: 8, bottom: 6, left: 8),
                      child: const Text("Operatorlar", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white))),
                  for (final location in locations)
                    LocationListItem(
                      imageUrl: location.imageUrl,
                      name: location.name,
                      country: location.country,
                    ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}