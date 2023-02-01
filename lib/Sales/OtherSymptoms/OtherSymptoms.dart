import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'OtherSymptoms_controller.dart';

class OtherSymptoms extends StatefulWidget {
  final int id;
  OtherSymptoms(this.id);
  @override
  _OtherSymptomsState createState() => _OtherSymptomsState();
}

class _OtherSymptomsState extends State<OtherSymptoms> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OtherSymptomsController(customerid: widget.id.toString(),
          context: context),
      child: Consumer<OtherSymptomsController>(
          builder: (context, controller, child) {
        return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/appbar.jpeg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                elevation: 0,
                title: Text(
                  'Other Symptoms',
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
                    ? const Center(child: LoadingIcon())
                    : controller.state == StateEnum.success
                        ? (controller.model!.items == null ||
                                controller.model!.items!.isEmpty)
                            ? Center(
                                child: Text(
                                  'Symptoms Not available',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemBuilder: (_, int index) => Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
                                              unselectedWidgetColor:
                                                  const Color(0xffe14589),
                                            ),
                                            child: Checkbox(
                                                value: controller.model!
                                                    .items![index].positive,
                                                onChanged: (value) {
                                                  controller.submitSymptoms(
                                                      value!, context, index);
                                                }),
                                          ),
                                        ),
                                        Text(
                                          (controller.model!.items![index].name
                                              .toString()
                                              .capitalize()),
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                itemCount: controller.model!.items!.length,
                              )
                        : Center(
                            child: ErrorRefreshIcon(onPressed: () {
                              controller.fetchOtherSymptoms();
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
