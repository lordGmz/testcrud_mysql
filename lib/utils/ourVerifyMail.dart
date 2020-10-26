

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import 'ourMailInfos.dart';

sendMail( String account_token, String email ) async {
  String username = EMAIL;
  String password = PASS;//passsword
  var url = "http://"+SERVER+"/verifyMail.php?email=$email&account_token=$account_token";
  print(url);

  final smtpServer = gmail(username, password);
  // Creating the Gmail server

  // Create our email message.
  final message = Message()
    ..from = Address(username)
    ..recipients.add(email) //recipient email
  //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
  //..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
    ..subject =
        'Flutter Send Mail from lordgmz : ${DateTime.now()}' //subject of the email
  //..text =
  //'This is the plain text.\nThis is line 2 of the text part.'
    ..html =
        "<h3>Thanks for connecting with us!</h3>\n<p>Verify your account by clicking here : <a href='$url'></a></p>"; //body of the email

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' +
        sendReport.toString()); //print if the email is sent
  } on MailerException catch (e) {
    print('Message not sent. \n' +
        e.toString()); //print if the email is not sent
    // e.toString() will show why the email is not sending
  }
}