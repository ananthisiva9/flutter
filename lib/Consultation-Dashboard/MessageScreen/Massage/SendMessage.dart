import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shebirth/Consultation-Dashboard/MessageScreen/Chat/Chat_view.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';

class ChatInputField extends StatefulWidget {
  final int? message;
  ChatInputField({Key? key, this.message}) : super(key: key);
  @override
  ChatInputFieldState createState() => ChatInputFieldState();
}

class ChatInputFieldState extends State<ChatInputField> {
  TextEditingController _messageController = TextEditingController();
  String sum = "0";
  bool isLoading = true;
  form1(String message) async {
    int receiver = widget.message as int;
    String url =consultantAPi.send_message;
    Map body = {"receiver": receiver.toString(), "message": message};
    String? token = await getToken();
    if (token != null) {
      var res = await http.post(
        Uri.parse(url),
        headers: {"Authorization": "Token ${token}"},
        body: body,
      );
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Your Message Submitted Successfully'),
          backgroundColor: Colors.green,
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Chat()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Message not Submitted ,Please Write your Message again'),
          backgroundColor: Colors.red,
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        });
      }
    }
  }

  late String message;
  Widget _buildMessage() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        minLines: 2,
        maxLines: 100,
        maxLength: 1500,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.multiline,
        onChanged: (value) {
          setState(() {
            message = value;
          });
        },
        controller: _messageController,
        decoration: InputDecoration(
          hintText: 'Type Your Message',
          hintStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 25),
          width: 5 * (MediaQuery.of(context).size.width / 09),
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589) , // foreground (text) color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: _messageController.text == "" + widget.message.toString()
                ? null
                : () {
                    setState(() {
                      isLoading = true;
                    });
                    form1(
                      _messageController.text,
                    );
                  },
            child: Text(
              "Send",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 20,
                fontFamily: 'Avenir',
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset('assets/Background.png').image,
                    fit: BoxFit.cover)),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildMessage(),
              _buildNextBtn(),
            ],
          ),
        ],
      ),
    );
  }

  getToken() async {
    dynamic userDetails = await Global.getUserDetails();
    if (userDetails != null && userDetails is LoginModel) {
      return userDetails.token;
    }
  }
}
