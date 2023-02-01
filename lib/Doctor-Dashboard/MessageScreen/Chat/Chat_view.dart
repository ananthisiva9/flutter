import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Doctor-Dashboard/DisplayScreen/DisplayScreen_view.dart';
import 'package:shebirth/Doctor-Dashboard/MessageScreen/Massage/Message.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/global.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'chat_controller.dart';
import 'chat_model.dart';

class Chat extends StatefulWidget {
  final int? value;
  Chat({Key? key, this.value}) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatController(context),
      child: Consumer<ChatController>(builder: (context, controller, child) {
        return Scaffold(
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
                'Messages',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.start,
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Display()),
                    );
                  },
                ),
              ],
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
              controller.clients != null
                  ? Container(
                      child: new ListView.builder(
                          itemBuilder: (_, int index) => Data(
                              controller.clients![index],
                              controller,
                              widget.value),
                          itemCount: controller.clients!.length),
                    )
                  : Container(),
            ],
          ),
        );
      }),
    );
  }

  getToken() async {
    dynamic userDetails = await Global.getUserDetails();
    if (userDetails != null && userDetails is LoginModel) {
      return userDetails.token;
    }
  }
}

class Data extends StatelessWidget {
  ChatItem item;
  ChatController controller;
  final int? value;
  Data(this.item, this.controller, this.value);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.1),
                  ),
                  height: 100,
                  width: 420,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: item.profile_pic == null
                                  ? CircleAvatar(
                                backgroundColor: Colors.cyan[100],
                                backgroundImage: AssetImage('assets/Client dummy.png'),
                                radius: 35,
                              )
                                  : CircleAvatar(
                                backgroundColor: Colors.cyan[100],
                                backgroundImage: NetworkImage(
                                  item.profile_pic.toString(),
                                ),
                                radius: 35,
                              ),
                            ),
                            Text(
                              item.firstname.toString().capitalize() +
                                  item.lastname.toString().capitalize(),
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MessagesScreen(
                    item.id!, item.firstname!, item.profile_pic.toString())),
          );
        },
      ),
    );
  }
}
