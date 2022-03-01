import 'package:e_com/Pages/resetpass.dart';
import 'package:e_com/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:toast/toast.dart';
import 'package:velocity_x/velocity_x.dart';

class Emailverification extends StatefulWidget {
  const Emailverification({Key key}) : super(key: key);

  @override
  _EmailverificationState createState() => _EmailverificationState();
}

class _EmailverificationState extends State<Emailverification> {
  String email;
  String otp;
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _otpcontroller = TextEditingController();
  void sendotp() async {
    EmailAuth.sessionName = "Sinbad forget password";
    var res = await EmailAuth.sendOtp(receiverMail: email.toString());
    if (res) {
    } else {}
  }

  void verifyotp() async {
    var res = EmailAuth.validate(
        receiverMail: email.toString(), userOTP: otp.toString());
    if (res) {
      Toast.show(S.of(context).Verified, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ResetPassword(email: email)));
    } else {
      Toast.show(S.of(context).InvalidOTP, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).EmailVerification),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: context.theme.canvasColor,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey[600])),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 100,
                      width: 100,
                      margin: EdgeInsets.only(top: 30),
                      child: Image(image: AssetImage('assets/sinbad.png')),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      child: Text(
                        S.of(context).Verifyemail,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value.toString();
                      },
                      controller: _emailcontroller,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                          suffixIcon: TextButton(
                              onPressed: () {
                                sendotp();
                                Toast.show(
                                    S.of(context).TheOTPhassendtoyouremail,
                                    context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.CENTER);
                              },
                              child: Text(S.of(context).SendOtp)),
                          labelText: S.of(context).Email,
                          hintText: "Enter Email"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        otp = value.toString();
                      },
                      controller: _otpcontroller,
                      decoration: InputDecoration(
                          labelText: S.of(context).OTP, hintText: "Enter OTP"),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                      child: ElevatedButton(
                    onPressed: () {
                      if (email == null) {
                        Toast.show(S.of(context).emailerror1, context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      } else if (email.length < 5) {
                        Toast.show(S.of(context).emailerror2, context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
                      } else {
                        verifyotp();
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            context.theme.buttonColor)),
                    child: S.of(context).VerifyOTP.text.xl.white.make(),
                  ).w48(context)),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
