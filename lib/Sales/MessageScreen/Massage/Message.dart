import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'Message_model.dart';
import 'SendMessage.dart';
import 'message_controller.dart';

class MessagesScreen extends StatefulWidget {
  int id;
  String firstname;
  MessagesScreen(this.id, this.firstname);
  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    Message item;
    return ChangeNotifierProvider(
      create: (context) => MessageController(
        context: context,
        customerid: widget.id.toString(),
      ),
      child: Consumer<MessageController>(builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:  AssetImage('assets/appbar.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            title: Row(
              children: [
                const BackButton(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:CircleAvatar(
                          backgroundColor: Colors.cyan[100],
                          backgroundImage:
                              const AssetImage('assets/Client dummy.png'),
                          radius: 20,
                        ),
                ),
                const SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.firstname.toString().capitalize(),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                )
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset('assets/Background.png').image,
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: controller.state == StateEnum.loading
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: const Center(child:  LoadingIcon()),
                        )
                      : controller.state == StateEnum.success
                          ? (controller.model != null &&
                                  controller.model!.messages != null &&
                                  controller.model!.messages!.isNotEmpty)
                              ? Container(
                                  child: ListView.builder(
                                      itemBuilder: (_, int index) => Data(
                                          controller.model!.messages![index],
                                          controller),
                                      itemCount:
                                          controller.model!.messages!.length),
                                )
                              : const Center(
                                  child: Text(
                                    "No Messages Available",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontFamily: 'Arial',
                                    ),
                                  ),
                                )
                          : Center(child: ErrorRefreshIcon(onPressed: () {})),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 250,
                    margin: const EdgeInsets.only(bottom: 10),
                    child:ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xffe14589) , // foreground (text) color
                        ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              ChatInputField(message: widget.id as int),
                          backgroundColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: const Radius.circular(20)),
                          ),
                        );
                      },
                      child: const Text(
                        "Type Your Message Here",
                        style:  TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Gilroy'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class Data extends StatelessWidget {
  Message item;
  MessageController controller;
  Data(this.item, this.controller);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20)),
        height: 110,
        width: 425,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      item.sender.toString().capitalize(),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            item.message.toString().capitalize(),
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          item.time.toString(),
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
