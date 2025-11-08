import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InternetRowItem extends StatefulWidget {
  final String img;
  final String mb;
  final String price;

  const InternetRowItem({super.key, required this.img, required this.mb, required this.price});

  @override
  State<InternetRowItem> createState() => _InternetRowItemState();
}

class _InternetRowItemState extends State<InternetRowItem> {
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(margin: const EdgeInsets.only(right: 16), child: Image.asset(widget.img, width: 100)),
              //const Expanded(child: Text("Internet-5\nBukjanyň göwrümi: 100 MB\nBahasy: 5 TMT\nHyzmat ediş bukjasynyň möhleti: 30 gün", style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis))),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(margin: const EdgeInsets.only(bottom: 4), decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.blue), child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  child: Text(widget.mb, style: const TextStyle(color: Colors.white, fontSize: 24)),
                )),
                Row(children: [
                  Text(widget.price, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                  const Expanded(child: Text(" TMT", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
                  const Text("30", style: TextStyle(fontSize: 20, color: Colors.grey)),
                  const Text(" GÜN ", style: TextStyle(fontSize: 14, color: Colors.grey)),
                  Container(margin: const EdgeInsets.only(bottom: 2), child: const Icon(Icons.calendar_month, size: 24, color: Colors.grey))
                ])
              ])),
            ],
          ),
        ),
      ),
    );
  }
}