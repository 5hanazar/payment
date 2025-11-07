import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:payment/location.dart';
import 'package:payment/presentation/views/location_list_item.dart';
import 'package:payment/presentation/views/sim_card_item.dart';
import 'package:sim_card_info/sim_card_info.dart';
import 'package:sim_card_info/sim_info.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
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
                  if (simInfo == null ? false : simInfo!.isNotEmpty)
                  Stack(
                    children: [
                      Container(margin: const EdgeInsets.only(top: 24, right: 8, bottom: 6, left: 8),
                          child: const Text("SIM Kartlar", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white))),
                      Positioned(bottom: -20, right: 8, child: Lottie.asset('assets/lottie_signal.json', width: 120, height: 120, frameRate: const FrameRate(60))),
                    ],
                  ),
                  for (final sim in simInfo ?? []) SimCardItem(operator: sim.displayName, phone: sim.number == "" ? "N/A" : sim.number),
                  Container(margin: const EdgeInsets.only(top: 24, right: 8, bottom: 6, left: 8), child: const Text("Operatorlar", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white))),
                  for (final location in locations)
                    GestureDetector(
                      onTap: () {

                      },
                      child: LocationListItem(
                        imageUrl: location.imageUrl,
                        name: location.name,
                        country: location.country,
                      ),
                    ),
                  Container(margin: const EdgeInsets.only(top: 24, right: 8, bottom: 6, left: 8), child: const Text("Internet Bukjalar", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white))),
                  GestureDetector(
                    onTap: () {
                      _makePhoneCall("*0850*3#");
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Image.asset("assets/internet_3.png"),
                            const Text("Internet-3\nBukjanyň göwrümi: 50 MB\nBahasy: 3 TMT\nHyzmat ediş bukjasynyň möhleti: 30 gün", style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _makePhoneCall("*0850*5#");
                    },
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(margin: const EdgeInsets.only(right: 16), child: Image.asset("assets/internet_5.png", width: 100)),
                            //const Expanded(child: Text("Internet-5\nBukjanyň göwrümi: 100 MB\nBahasy: 5 TMT\nHyzmat ediş bukjasynyň möhleti: 30 gün", style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis))),
                            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Container(margin: const EdgeInsets.only(bottom: 4), decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.blue), child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                child: Text("100 MB", style: TextStyle(color: Colors.white, fontSize: 24)),
                              )),
                              Row(children: [
                                const Text("5", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                                const Expanded(child: Text(" TMT", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                                const Text("30", style: TextStyle(fontSize: 24, color: Colors.grey)),
                                const Text(" GÜN ", style: TextStyle(fontSize: 18, color: Colors.grey)),
                                Container(margin: const EdgeInsets.only(bottom: 2), child: const Icon(Icons.calendar_month, size: 28, color: Colors.grey))
                              ])
                            ])),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _makePhoneCall("*0850*10#");
                    },
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                        child: Column(
                          children: [
                            Image.asset("assets/internet_10.png"),
                            const Text("Internet-10\nBukjanyň göwrümi: 250 MB\nBahasy: 10 TMT\nHyzmat ediş bukjasynyň möhleti: 30 gün", style: TextStyle(fontSize: 18)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _makePhoneCall("*0850*15#");
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Image.asset("assets/internet_15.png", width: 100),
                            const Expanded(child: Text("Internet-15\nBukjanyň göwrümi: 500 MB\nBahasy: 15 TMT\nHyzmat ediş bukjasynyň möhleti: 30 gün", style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis))),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _makePhoneCall("*0850*60#");
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Image.asset("assets/internet_60.png", width: 100),
                            const Expanded(child: Text("Internet-60\nBukjanyň göwrümi: 1.5 GB\nBahasy: 60 TMT\nHyzmat ediş bukjasynyň möhleti: 30 gün", style: TextStyle(fontSize: 18))),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _makePhoneCall("*0850*160#");
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Image.asset("assets/internet_160.png"),
                            const Text("Internet-60\nBukjanyň göwrümi: 4 GB\nBahasy: 160 TMT\nHazmat ediş bukjasynyň möhleti: 30 gün", style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _makePhoneCall("*0850*200#");
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Image.asset("assets/internet_200.png", width: 100),
                            const Expanded(child: Text("Internet-200\nBukjanyň göwrümi: 20 GB\nBahasy: 200 TMT\nHyzmat ediş bukjasynyň möhleti: 30 gün", style: TextStyle(fontSize: 18))),
                          ],
                        ),
                      ),
                    ),
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