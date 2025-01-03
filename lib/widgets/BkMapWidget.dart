import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BkMapWidget extends StatefulWidget {
  final String latitude;
  final String longitude;
  final double zoom;
  final Function(GoogleMapController)? onMapCreated;
  final String? markerTitle;
  final String? schoolName;

  const BkMapWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    this.zoom = 15.0,
    this.onMapCreated,
    this.markerTitle,
    this.schoolName
  });

  @override
  State<BkMapWidget> createState() => _BkMapWidgetState();
}

class _BkMapWidgetState extends State<BkMapWidget> {
  late GoogleMapController _controller;
  late Set<Marker> _markers;

  @override
  void initState() {
    super.initState();
    _initializeMarkers();
  }

  void _initializeMarkers() {
    double parsedLatitude = double.tryParse(widget.latitude) ?? 0.0;
    double parsedLongitude = double.tryParse(widget.longitude) ?? 0.0;

    _markers = {
      Marker(
        markerId: const MarkerId('selected_location'),
        position: LatLng(parsedLatitude, parsedLongitude),
        infoWindow: InfoWindow(
          title: widget.markerTitle ?? "Seçilen Konum",
          snippet:widget.schoolName,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };
  }

  /// Harita Uygulamasını Aç
  Future<void> _openMapApp(double latitude, double longitude) async {
    final Uri googleMapsUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    final Uri appleMapsUrl = Uri.parse('http://maps.apple.com/?q=$latitude,$longitude');

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else if (await canLaunchUrl(appleMapsUrl)) {
      await launchUrl(appleMapsUrl);
    } else {
      throw 'Harita uygulaması açılamadı.';
    }
  }

  @override
  Widget build(BuildContext context) {
    double parsedLatitude = double.tryParse(widget.latitude) ?? 0.0;
    double parsedLongitude = double.tryParse(widget.longitude) ?? 0.0;

    if (parsedLatitude == 0.0 || parsedLongitude == 0.0) {
      return const Center(
        child: Text(
          'Geçersiz konum bilgisi',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    final CameraPosition initialPosition = CameraPosition(
      target: LatLng(parsedLatitude, parsedLongitude),
      zoom: widget.zoom,
    );

    return SizedBox(
      height: MediaQuery.of(context).size.height / 4,
      child: GoogleMap(
        initialCameraPosition: initialPosition,
        myLocationButtonEnabled: true,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        markers: _markers,
        onTap: (LatLng tappedPoint) {
          _openMapApp(parsedLatitude, parsedLongitude);
        },
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
          if (widget.onMapCreated != null) {
            widget.onMapCreated!(controller);
          }
        },
      ),
    );
  }
}
