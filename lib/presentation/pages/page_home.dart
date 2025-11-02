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
      imageUrl: 'assets/img_telekom.png',
      name: 'Grand Canyon',
      country: 'USA',
    ),
    LocationDto(
      imageUrl: 'assets/img_astu.webp',
      name: 'Tokyo Skytree',
      country: 'Japan',
    ),
    LocationDto(
      imageUrl: 'assets/img_tmcell.jpg',
      name: 'Eiffel Tower',
      country: 'France',
    ),
    LocationDto(
      imageUrl: 'assets/img_astu.webp',
      name: 'Colosseum',
      country: 'Italy',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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