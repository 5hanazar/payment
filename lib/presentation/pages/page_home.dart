import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:payment/presentation/views/internet_column_item.dart';
import 'package:payment/presentation/views/internet_row_item.dart';
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

  _caption(String text) {
    return Container(margin: const EdgeInsets.only(top: 24, right: 8, bottom: 8, left: 8), child: Text(text, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "Roboto", shadows: <Shadow>[
      Shadow(
        blurRadius: 16,
        color: Color.fromARGB(100, 0, 0, 100), // Semi-transparent black
      ),
    ])));
  }

  _callService(String text, String phone) {
    return SizedBox(
      height: 150,
      width: (MediaQuery.of(context).size.width / 2) - 14,
      child: Card(clipBehavior: Clip.hardEdge, color: Colors.white, child: InkWell(
          onTap: () {
            _makePhoneCall(phone);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(margin: const EdgeInsets.only(bottom: 6), child: Text(text, style: const TextStyle(fontSize: 20, height: 1.1, fontWeight: FontWeight.bold))),
                Row(
                  children: [
                    Icon(Icons.phone, size: 20, color: Colors.blue.shade700),
                    Expanded(child: Text(phone, style: TextStyle(color: Colors.blue.shade700, overflow: TextOverflow.ellipsis),)),
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    );
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
              Color(0xFFE0F2F1), // vibrant blue
              Color(0xFFB3E5FC), // deep blue
              Color(0xFFE0F2F1), // soft pink
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 0, right: 14, bottom: 16, left: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (simInfo == null ? false : simInfo!.isNotEmpty)
                  Stack(
                    children: [
                      Container(margin: const EdgeInsets.only(top: 24), child: _caption("SIM Kartlar")),
                      Positioned(bottom: -28, right: 8, child: Lottie.asset('assets/lottie_signal.json', width: 120, height: 120, frameRate: const FrameRate(60))),
                    ],
                  ),
                  for (final sim in simInfo ?? []) SimCardItem(operator: sim.displayName, phone: sim.number == "" ? "N/A" : sim.number),
                  _caption("Operatorlar"),
                  LocationListItem(
                    imageUrl: 'assets/img_tmcell.jpg',
                    name: 'TM CELL - Telefon',
                    country: 'Turkmenistan',
                  ),
                  LocationListItem(
                    imageUrl: 'assets/img_astu.jpg',
                    name: 'AŞTU - Internet',
                    country: 'Turkmenistan',
                  ),
                  LocationListItem(
                    imageUrl: 'assets/img_telekom.jpg',
                    name: 'Telekom - Internet',
                    country: 'Turkmenistan',
                  ),
                  Container(margin: const EdgeInsets.only(top: 64, bottom: 8), child:  _caption("Internet Bukjalar")),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const InternetColumnItem(img: "assets/internet_3.png", mb: "50 MB", price: "3"),
                      Positioned(bottom: 100, left: (MediaQuery.of(context).size.width / 2) - 64, child: Lottie.asset('assets/the_network.json', width: 320, frameRate: const FrameRate(60))),
                    ],
                  ),
                  const InternetRowItem(img: "assets/internet_5.png", mb: "100 MB", price: "5"),
                  const InternetColumnItem(img: "assets/internet_10.png", mb: "250 MB", price: "10"),
                  const InternetRowItem(img: "assets/internet_15.png", mb: "500 MB", price: "15"),
                  const InternetRowItem(img: "assets/internet_60.png", mb: "1.5 GB", price: "60"),
                  const InternetColumnItem(img: "assets/internet_160.png", mb: "4 GB", price: "160"),
                  const InternetRowItem(img: "assets/internet_200.png", mb: "20 GB", price: "200"),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Lottie.asset('assets/tech_support.json', frameRate: const FrameRate(60)),
                      Container(margin: const EdgeInsets.only(bottom: 28), child: _caption("Hyzmatlar"))
                    ],
                  ),
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      _callService("Aragatnaşygyň görnüşi", "*0809*1#"),
                      _callService("Şäherara hyzmaty açmak", "*0809*1*1#"),
                      _callService("Halkara hyzmatyny açmak", "*0809*1*2#"),
                      _callService("Hyzmatlaryň görnüşi", "*0809*2#"),
                      _callService("Täleýnama", "*110#"),
                      _callService("Ulanylýan nyrhnamany bilmek", "*0809*6*1*1#"),
                      _callService("Nyrhnamany üýtgetmek", "*0809*6*1*2#"),
                      _callService("WCDMA 3G-Internet", "*0809*6*1*2*104#"),
                      _callService("Tygşytly", "*0809*6*1*2*106#"),
                      _callService("Amatly", "*0809*6*1*2*109#"),
                      _callService("Seniň ulgamyň 1", "*0809*6*1*2*119#"),
                      _callService("Sada", "*0809*6*1*2*122#"),
                      _callService("Gürleşiber", "*0809*6*1*2*126#"),
                      _callService("Sowgat-2000", "*0809*6*1*2*130#"),
                      _callService("Sowgat 1000+", "*0809*6*1*2*131#"),
                      _callService("Çäksiz gepleşikler +", "*0809*6*1*2*132#"),
                      _callService("Internet 50", "*0809*6*1*2*133#"),
                      _callService("Sowgat 500", "*0809*6*1*2*140#")
                    ],
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