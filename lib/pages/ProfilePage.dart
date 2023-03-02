import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/CustomDrawer.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key, this.name});

  String? name;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  XFile? _pickedImage;
  String? _imageUrl;
  final ImagePicker _picker = ImagePicker();
  late final Future futureProfilePic;

  pick_image() async {
    final _pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if(_pickedImage != null){
      Reference _reference = FirebaseStorage.instance
        .ref()
        .child('profilepic.jpg');
      await _reference
          .putData(
        await XFile(_pickedImage.path).readAsBytes(),
        SettableMetadata(contentType: 'image/jpeg'),
      )
        .whenComplete(() async {
          await _reference.getDownloadURL().then((value) {
            setState(() {
              _imageUrl = value;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green, content: Text('Profile Picture Successfully Updated !')));
            });
          });
        });
    }
  }

  Future loadProfilePic() async {
    Reference ppRef = FirebaseStorage.instance.ref().child("profilepic.jpg");
    await ppRef.getDownloadURL().then((value) {
      setState(() {
        _imageUrl = value;
      });
    }).catchError((err) {
      setState(() {
          _imageUrl = "https://firebasestorage.googleapis.com/v0/b/test-test-31557.appspot.com/o/CACCIATORI_Hugo.jpg?alt=media&token=e3adbe1f-b3db-41cf-a8f3-209df8c8d01a";
        });
    });
  }

  @override
  void initState() {
    futureProfilePic = loadProfilePic();
    super.initState();
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: CustomDrawer(),
      body:LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints){
        return SingleChildScrollView(
            child:Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: constraints.maxWidth,
                height: 300,
                color: Colors.green[200],
                child: Center(
                  child: Column(
                    children: [
                      const Text('Page de profil', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 34)),
                      InkWell(
                        onTap: (){
                           pick_image();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child: FutureBuilder(
                            future: futureProfilePic,
                            builder: (context, snapshot) {
                              if(snapshot.connectionState == ConnectionState.done){
                                return Image.network(_imageUrl!, width: 150, height: 150, fit: BoxFit.cover,);
                              } else {
                                return Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0),child: CircularProgressIndicator(color: Colors.blue, value: 20,));
                              }
                            }),
                        ),
                      ),
                      Text(widget.name!, style: TextStyle(fontSize: 24))
                    ],
                  )
                  
                )
                
              ),
              
          ]),
          );
    })
    );
    
    
  }

}