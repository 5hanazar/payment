import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InternetColumnItem extends StatefulWidget {
  final String img;
  final String mb;
  final String price;

  const InternetColumnItem({super.key, required this.img, required this.mb, required this.price});

  @override
  State<InternetColumnItem> createState() => _InternetColumnItemState();
}

class _InternetColumnItemState extends State<InternetColumnItem> {
  @override
  void initState() {
    super.initState();
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
    return GestureDetector(
      onTap: () {
        _makePhoneCall("*0850*${widget.price}#");
      },
      child: Card(
        color: Colors.white,
        clipBehavior: Clip.hardEdge,
        child: Column(
            children: [
              Image.asset(widget.img),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.blue),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                        child: Text(widget.mb, style: const TextStyle(color: Colors.white, fontSize: 24)),
                      )),
                  Row(
                    children: [
                      Text(widget.price, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                      const Text(" TMT", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("30", style: TextStyle(fontSize: 20, color: Colors.grey)),
                      const Text(" GÜN ", style: TextStyle(fontSize: 14, color: Colors.grey)),
                      Container(margin: const EdgeInsets.only(bottom: 2), child: const Icon(Icons.calendar_month, size: 24, color: Colors.grey))
                    ],
                  ),
                ]),
              )
            ],
          ),
      ),
    );
  }
}