import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Dad%20Dashboard/Remedy.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'Symptoms_controller.dart';
import 'Symptoms_model.dart';

class SymptomsList extends StatefulWidget {
  @override
  _SymptomsListState createState() => _SymptomsListState();
}

class _SymptomsListState extends State<SymptomsList> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SymptomsController(context),
      child:
          Consumer<SymptomsController>(builder: (context, controller, child) {
        return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/appbar.jpeg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                elevation: 0,
                title: Text(
                  'Symptoms List',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            body: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Image.asset('assets/Background.png').image,
                          fit: BoxFit.cover)),
                ),
                controller.state == StateEnum.loading
                    ? Center(child: LoadingIcon())
                    : controller.state == StateEnum.success
                        ? (controller.model!.data == null ||
                                controller
                                    .model!.data!.isEmpty)
                            ? Center(
                                child: Text(
                                  'No Symptoms available',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : new ListView.builder(
                                itemBuilder: (_, int index) =>
                                    Details(controller.allSymptoms[index]),
                                itemCount: controller.allSymptoms.length,
                              )
                        : Center(
                            child: ErrorRefreshIcon(onPressed: () {
                              controller.fetchAllSymptoms();
                            }),
                          ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class Details extends StatelessWidget {
  Details(this.detail);
  Data detail;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20,top: 20.0,bottom: 8.0),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Remedy(detail.id!,detail.symptom!,detail.remedy!)),
              );
            },
            child: Text(' .  ' +
              (detail.symptom.toString().capitalize()),
              style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
              textAlign: TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
}
