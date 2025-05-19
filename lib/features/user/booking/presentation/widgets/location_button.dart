import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({
    super.key,
    this.onPressed,
    required this.latitude,
    required this.longitude,
  });
  final void Function()? onPressed;
  final double latitude;
  final double longitude;

  void _launchMaps() async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&origin=My+Location&destination=$latitude,$longitude',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[300],
      ),
      child: MaterialButton(
        onPressed: _launchMaps,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Get Directions', style: TextStyles.font14BlackMedium),
            SizedBox(width: 3),
            Icon(Icons.location_on_rounded, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
