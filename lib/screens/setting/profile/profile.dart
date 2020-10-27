import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OurProfileImage extends StatefulWidget {
  @override
  _OurProfileImageState createState() => _OurProfileImageState();
}

class _OurProfileImageState extends State<OurProfileImage> {
  File _selectedFile;
  bool _inProcess = false;
  List data = [];
  String email = "";

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email');
    });
  }

  Future getProfile()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email');
    });
    final response = await http.get("http://192.168.1.69/selectProfile.php?email="+email);
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
      return data;
    }else{
      print("error");
      return null;
    }
  }

  //function for image picking and crop it
  getImage(ImageSource source) async {
    this.setState(() {
      _inProcess = true;
    });
    // ignore: deprecated_member_use
    File image = await ImagePicker.pickImage(source: source);

    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.white,
            toolbarTitle: "Recadrez votre image",
            statusBarColor: Colors.white,
            backgroundColor: Colors.white,
          ));

      this.setState(() {
        _selectedFile = cropped;
        _inProcess = false;
      });
    } else {
      this.setState(() {
        _inProcess = false;
      });
    }
  }

  Future uploadImage()async{
    final uri = Uri.parse("http://192.168.1.69/uploadImageProfile.php?email="+email);
    var request = http.MultipartRequest('POST',uri);
    request.fields['name'] = _selectedFile.path;
    var pic = await http.MultipartFile.fromPath("image", _selectedFile.path);
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: "Profil mis à jour.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
    Navigator.pop(context);
      print('Image Uploded');
    }else{
      print('Image Not Uploded');
    }
    setState(() {
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();
    getProfile();
  }
  Widget getImageWidget() {
    if (_selectedFile != null) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(150.0)),
        child: Image.file(
          _selectedFile,
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
      );
    }else if ( data.isNotEmpty && data.length>0 && data[0]["imageUrl"] !="vide") {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(150.0)),
        child: Image.network(
          "http://192.168.1.69/profile_photos/"+data[0]["imageUrl"],
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
      );
    } else{
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        child: Image.asset(
          "assets/avatar.jpg",
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Mettre à jour votre photo de profil",
          style: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.black),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: getImageWidget(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: RaisedButton(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                          )),
                      color: Colors.white,
                      elevation: 5.0,
                      onPressed: () {
                        getImage(ImageSource.camera);
                      }),
                ),
                Center(
                  child: RaisedButton(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Icon(Icons.photo_library_outlined,
                            color: Colors.black),
                      ),
                      color: Colors.white,
                      elevation: 5.0,
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      }),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Enregitrer",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      color: Colors.green,
                      elevation: 5.0,
                      onPressed: () {
                        uploadImage();
                      }),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
