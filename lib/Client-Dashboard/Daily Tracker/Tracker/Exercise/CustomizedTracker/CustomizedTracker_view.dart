import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shebirth/Client-Dashboard/Daily%20Tracker/Tracker/Exercise/Exercise_controller.dart';
import 'package:url_launcher/link.dart';

class CostomizedTracker extends StatefulWidget {
  CostomizedTracker(this.controller);
  ExerciseController controller;
  @override
  _CostomizedTrackerState createState() => _CostomizedTrackerState();
}

class _CostomizedTrackerState extends State<CostomizedTracker> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.1),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _buildImage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      height: 75,
      width: 300,
      child: Link(
          target: LinkTarget.blank,
          uri: Uri.parse(
              widget.controller.model!.url.toString()),
          builder: (context, followLink) {
            return TextButton(
                onPressed: followLink,
                child: Text(
                  widget.controller.model!.url.toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ));
          }),
    );
  }
}
