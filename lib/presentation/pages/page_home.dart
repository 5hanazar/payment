import 'package:flutter/material.dart';
import 'package:payment/location.dart';
import 'package:payment/presentation/views/location_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final locations = <LocationDto>[
    LocationDto(
      imageUrl: 'assets/img_tmcell.jpg',
      name: 'TM CELL',
      country: 'Turkmenistan',
    ),
    LocationDto(
      imageUrl: 'assets/img_astu.jpg',
      name: 'AŞTU',
      country: 'Turkmenistan',
    ),
    LocationDto(
      imageUrl: 'assets/img_telekom.jpg',
      name: 'Telekom',
      country: 'Turkmenistan',
    ),
  ];

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (final location in locations)
                LocationListItem(
                  imageUrl: location.imageUrl,
                  name: location.name,
                  country: location.country,
                ),
            ],
          ),
        )
      ),
    );
  }
}