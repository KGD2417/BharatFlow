import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_heatmap/flutter_map_heatmap.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});



  @override
  Widget build(BuildContext context) {
    List<WeightedLatLng> data = [];
    List<Map<double, MaterialColor>> gradients = [
      HeatMapOptions.defaultGradient,
      {0.25: Colors.blue, 0.55: Colors.red, 0.85: Colors.pink, 1.0: Colors.purple}
    ];


    return FlutterMap(
      options: MapOptions(
        initialCenter: const LatLng(19.0760, 72.8777), // Mumbai
        initialZoom: 13.0,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
        if (data.isNotEmpty)
          HeatMapLayer(
            heatMapDataSource: InMemoryHeatMapDataSource(data: data),
            heatMapOptions: HeatMapOptions(
                gradient: gradients[1], minOpacity: 0.1),
          ),
        MarkerLayer(
          markers: [
            Marker(
              width: 40.0,
              height: 40.0,
              point: const LatLng(19.0760, 72.8777),
              child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
            ),
          ],
        ),
      ],
    );
  }
}
