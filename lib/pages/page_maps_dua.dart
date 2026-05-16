import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';


class PageMapsDua extends StatefulWidget {
  const PageMapsDua({super.key});

  @override
  State<PageMapsDua> createState() => _PageMapsDuaState();
}

class _PageMapsDuaState extends State<PageMapsDua> {
  
  final Set<Marker> _markers = {};
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.add(
      Marker(
        markerId: const MarkerId("Campus"),
        position: const LatLng(-0.9145679, 100.4635761),
        infoWindow: const InfoWindow(title: "Kampus PNP")
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return GoogleMap(initialCameraPosition: const CameraPosition(target: LatLng(-0.9145679, 100.4635761), zoom: 15),
    mapType: .satellite,
    markers: _markers,);
  }
}

//LATIHAN
// tambahkan beberapa page untuk maps
// 1. Buat maps tipe satelite
// 2. Buat maps normal
// 3. Buat maps yg hybrid
// 4. Buat maps yg terrain
// 5. Bikin maps dengan multiple markers ( Marker PNP, UNAND, UNP, dll )