// ignore_for_file: file_names
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:railway_super_app/Network/NetworkValidation.dart';
import 'package:railway_super_app/User/Contest/Contest.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Crop.dart';

class ImageContest extends StatefulWidget {
  int? id, type;
  ImageContest(this.id, this.type, {super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ImageContestState createState() => _ImageContestState();
}

class _ImageContestState extends State<ImageContest> {
  final _picker = ImagePicker();
  File? fileImage;
  BaseWidget? baseWidget;
  String? message;
  bool _clicked = false;

  @override
  void initState() {
    super.initState();
    baseWidget = BaseWidget();
    logStart();
  }

  @override
  dispose() {
    super.dispose();
  }
  logStart() async {
    String url =
        '${ApiEndPoint.log_start}?app_label=Railway&Module_name=App Name Contest';
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (res.statusCode == 200) {
      message = jsonDecode(res.body)['message'];
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  logEnd() async {
    String url = '${ApiEndPoint.log_end}?id=$message';
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (res.statusCode == 200) {} else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }
    void imageSuccess(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: AlertDialog(
            title: Column(
              children: [
                const Image(
                  image: AssetImage('asset/Congratulation.png'),
                  height: 200,
                ),
                Text(
                  'Thanks For Submitting',
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            actions: [
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2DCAA9), // foreground (text) color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                     logEnd();
                     uploadImage(fileImage!);
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => const Contest()),
                     );
                    },
                    child: Text(
                      "Done",
                      style: GoogleFonts.roboto(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void imageFailed(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(""),
          content: const Text("Image Upload Failed"),
          actions: <Widget>[
            TextButton(
                child: const Text("Retry"),
                onPressed: () async {
                  if (await baseWidget!.isInternet(context)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ImageContest(widget.id,widget.type)),
                    );
                  }
                }),
          ],
        );
      },
    );
  }

  _getImageFrom({required ImageSource source}) async {
    final pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      var image = File(pickedImage.path.toString());
      // final sizeInKbBefore = image.lengthSync() / 1024;
      // var compressedImage = await AppHelper.compress(image: image);
     // final sizeInKbAfter = compressedImage.lengthSync() / 1024;
      var croppedImage = await AppHelper.cropImage(image);
      if (croppedImage == null) {
        return;
      }
      setState(() {
        fileImage = croppedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        //wrap with PreferredSize
        preferredSize: const Size.fromHeight(10),
        child: AppBar(
          backgroundColor: const Color(0xff0093dd),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(image: AssetImage('asset/Add1.png')),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/80,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3.5,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.asset('asset/Appback.png').image,
                            fit: BoxFit.cover)),
                    child: Column(
                      children: [
                        const Image(
                          image: AssetImage('asset/ImageContest.jpg'),
                          height: 145,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height / 15,
                            width: MediaQuery.of(context).size.width / 0.5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.3)),
                            child: const Center(
                              child: Text(
                                "Image Contest",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (fileImage == null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: GestureDetector(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 15,
                          width: MediaQuery.of(context).size.width / 1.6,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff0093dd),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async {
                              _openChangeImageBottomSheet();
                            },
                            label: const Text(
                              'Image Upload',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            icon: const Icon(Icons.upload),
                          ),
                        ),
                      ),
                      // child: const Text('Select An Image'),
                      // onTap: () => imageController.pickImage(),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (fileImage != null)
                          Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 5,
                                width: MediaQuery.of(context).size.width / 1,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black12, width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    color: Colors.grey,
                                    image: DecorationImage(
                                      image: FileImage(fileImage!),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              const SizedBox(height: 35),
                              Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.height/15,
                                        width: MediaQuery.of(context).size.width/3,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          onPressed: () async {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ImageContest(widget.id,widget.type)),
                                            );
                                          },
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      //     )), const Text('Server upload'),
                                     // onTap:()=> Get.find<ImageController>().upload(),
                                    ),
                                    GestureDetector(
                                      child: SizedBox(
                                        height: MediaQuery.of(context).size.height/15,
                                        width: MediaQuery.of(context).size.width/3,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xff2DCAA9),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),

                                         onPressed: (){
                                           imageSuccess(context);},
                                          child: const Text(
                                            'Submit',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                      //     )), const Text('Server upload'),
                                      // onTap:()=> Get.find<ImageController>().upload(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/80,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(image: AssetImage('asset/Add3.png')),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/80,
                ),
              ]),
        ),
      ),
    );
  }

  _openChangeImageBottomSheet() {
    return showCupertinoModalPopup(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              _buildCupertinoActionSheetAction(
                icon: Icons.camera_alt,
                title: ' Camera ',
                voidCallback: () {
                  Navigator.pop(context);
                  _getImageFrom(source: ImageSource.camera);
                },
              ),
              _buildCupertinoActionSheetAction(
                icon: Icons.image,
                title: ' Gallery ',
                voidCallback: () {
                  Navigator.pop(context);
                  _getImageFrom(source: ImageSource.gallery);
                },
              ),
            ],
          );
        });
  }

  _buildCupertinoActionSheetAction({
    IconData? icon,
    required String title,
    required VoidCallback voidCallback,
    Color? color,
  }) {
    return CupertinoActionSheetAction(
      onPressed: voidCallback,
      child: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              color: color ?? const Color(0xFF2564AF),
            ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: color ?? const Color(0xFF2564AF),
              ),
            ),
          ),
          if (icon != null)
            const SizedBox(
              width: 25,
            ),
        ],
      ),
    );
  }

  Future<void> uploadImage(File imageFile) async {
    String? token;
   String url = ApiEndPoint.image_upload;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(url));

    Map<String, String> body = {
      "contest_type_id": widget.type.toString(),
      "contest_module_id": widget.id.toString(),
    };
    request.headers.addAll(<String, String>{'Authorization': 'Token $token'});
    request.fields.addAll(body);
    File file = File(imageFile.path);
    request.files.add(http.MultipartFile(
        'image', file.readAsBytes().asStream(), file.lengthSync(),
        filename: file.path.split('/').last));

    var response = await request.send();

    if (response.statusCode == 200) {
      String message;
      Map map = jsonDecode(await response.stream.bytesToString());
      if (map['status'] == 200) {
        message = map["message"];
        // ignore: use_build_context_synchronously
      } else {
        message = map["description"];
        // ignore: use_build_context_synchronously
        imageFailed(context);
      }
    }
  }
}
