
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tflite/tflite.dart';


void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calorie tracker',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                SignScreen1()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image : DecorationImage(
            image: AssetImage("assets/images/launching screen.png"),
            fit: BoxFit.fill,
          )
      ),
    );
  }
}

class SignScreen1 extends StatefulWidget {
  const SignScreen1({Key? key}) : super(key: key);

  @override
  State<SignScreen1> createState() => _SignScreen1State();
}

class _SignScreen1State extends State<SignScreen1> {
  TextEditingController _passtext = TextEditingController();
  bool error = true;
  bool _vis = true;
  TextEditingController _emailtext = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body : Container(
          decoration: BoxDecoration(
              image : DecorationImage(
                image: AssetImage("assets/images/sign.png"),
                fit: BoxFit.fill,
              )
          ),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(130.0)),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Container(
                  child: Text("Sign Up",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(20.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller:_emailtext,
                    decoration: InputDecoration(
                        hintText: "Email Adderess",
                        hintStyle: TextStyle(fontSize: 23,color: Colors.black)
                    ),
                  )
              ),
              Padding(padding: EdgeInsets.all(20.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller:_passtext,
                    obscureText: _vis,
                    maxLength: 10,
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(fontSize: 23,color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _vis ? Icons.visibility_off : Icons.visibility
                          ),
                          onPressed: (){
                            setState(() {
                              _vis = !_vis;
                            });
                          },
                        )
                    ),
                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Row(
                    children: [
                      FlatButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => forpass()));
                      }, child: Text("Forgot password",
                        style: TextStyle(color: Colors.blue),
                        textAlign: TextAlign.left,
                      ),),
                      Padding(padding: EdgeInsets.all(10.0)),
                      FlatButton(onPressed: () {Navigator.push(context, MaterialPageRoute(
                          builder: (context) => Signup()));},
                          child: Text("Create Account",
                            style: TextStyle(color: Colors.blue),
                            textAlign: TextAlign.right,
                          ))
                    ],
                  )
              ),
              Padding(padding: EdgeInsets.all(20.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      image : DecorationImage(
                        image: AssetImage("assets/images/sbox.JPG"),
                        fit: BoxFit.fill,
                      )
                  ),
                  child: FlatButton(
                    onPressed: () {
                      if(_emailtext.text == "jan03112000@gmail.com" && _passtext.text == "jan3") {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Home()));
                      }
                      else
                      {
                        setState(() {
                          error = false;
                        });
                      }
                    },
                    child: Text("Sign In",
                      style: TextStyle(fontSize: 22),),

                  )
              ),
              Container(
                child: error?Text(""):Text("incorrect credentials",style: TextStyle(fontSize: 20,color: Colors.red)),
              )
            ],
          ),
        )
    );
  }
}




class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? imagetemp;
  Future<void> _openGallery() async{
    final XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(imageFile == null) return;
    setState((){imagetemp = File(imageFile.path);});
  }
  Future<void> _openCamera() async{
    final XFile? imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if(imageFile == null) return;
    setState((){imagetemp = File(imageFile.path);});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body : Container(
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
                image : DecorationImage(
                  image: AssetImage("assets/images/sign.png"),
                  fit: BoxFit.fill,
                )
            ),
            child: Column(
                children: [

                  //Padding(padding: EdgeInsets.all(130.0)),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.07,

                    child: Container(
                      child: Text("Welcome Janani!",
                        style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.27,
                    height: MediaQuery.of(context).size.height * 0.13,
                    // color: Colors.blue,
                    decoration: BoxDecoration(
                        image : DecorationImage(
                          image: AssetImage("assets/images/bbox.JPG"),
                          fit: BoxFit.fill,
                        )
                    ),
                    child: IconButton(
                      icon: Icon(Icons.camera_alt_outlined),
                      iconSize: 40,
                      color: Colors.black,
                      onPressed: (){
                        _openCamera();
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(20.0)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.27,
                    height: MediaQuery.of(context).size.height * 0.13,
                    decoration: BoxDecoration(
                        image : DecorationImage(
                          image: AssetImage("assets/images/bbox.JPG"),
                          fit: BoxFit.fill,
                        )
                    ),
                    child: IconButton(
                      icon: Icon(Icons.upload_outlined),
                      iconSize: 40,
                      color: Colors.black,
                      onPressed: (){

                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => StaticImage()));
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(20.0)),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.27,
                    height: MediaQuery.of(context).size.height * 0.13,
                    decoration: BoxDecoration(
                        image : DecorationImage(
                          image: AssetImage("assets/images/bbox.JPG"),
                          fit: BoxFit.fill,
                        )
                    ),
                    child: IconButton(
                      icon: Icon(Icons.history),
                      iconSize: 40,
                      color: Colors.black,
                      onPressed: (){Navigator.push(context, MaterialPageRoute(
                          builder: (context) => history()));},
                    ),
                  ),
                ]
            )
        )
    );
  }
}


class StaticImage extends StatefulWidget {

  @override
  _StaticImageState createState() => _StaticImageState();
}

class _StaticImageState extends State<StaticImage> {
   File? _image;
  List? _recognitions;
  bool? _busy;
  double? _imageWidth, _imageHeight;

  final picker = ImagePicker();

  // this function loads the model
  Future loadTfModel() async {
    Tflite.close();
    await Tflite.loadModel(
      model: "ssd_mobilenet.tflite",
      labels: "assets/moal.txt",
    );
  }

  // this function detects the objects on the image
  detectObject(File image) async {
    var recognitions = await Tflite.detectObjectOnImage(
        path: image.path,       // required
        model: "SSDMobileNet",
        imageMean: 127.5,
        imageStd: 127.5,
        threshold: 0.4,       // defaults to 0.1
        numResultsPerClass: 10,// defaults to 5
        asynch: true          // defaults to true
    );
    FileImage(image)
        .resolve(ImageConfiguration())
        .addListener((ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        _imageWidth = info.image.width.toDouble();
        _imageHeight = info.image.height.toDouble();
      });
    })));
    setState(() {
      _recognitions = recognitions!;
    });
  }

  @override
  void initState() {
    super.initState();
    _busy = true;
    loadTfModel().then((val) {{
      setState(() {
        _busy = false;
      });
    }});
  }
  // display the bounding boxes over the detected objects
  List<Widget> renderBoxes(Size screen) {
    if (_recognitions == null) return [];
    if (_imageWidth == null || _imageHeight == null) return [];

    double factorX = screen.width;
    double factorY = _imageHeight! / _imageHeight! * screen.width;

    Color blue = Colors.blue;

    return _recognitions!.map((re) {
      return Container(
        child: Positioned(
            left: re["rect"]["x"] * factorX,
            top: re["rect"]["y"] * factorY,
            width: re["rect"]["w"] * factorX,
            height: re["rect"]["h"] * factorY,
            child: ((re["confidenceInClass"] > 0.50))? Container(
              decoration: BoxDecoration(
                  border: Border.all(
                    color: blue,
                    width: 3,
                  )
              ),
              child: Text(
                "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                  background: Paint()..color = blue,
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ) : Container()
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> stackChildren = [];

    stackChildren.add(
        Positioned(
          // using ternary operator
          child: _image == null ?
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Please Select an Image"),
              ],
            ),
          )
              : // if not null then
          Container(
              child:Image.file(_image!)
          ),
        )
    );

    stackChildren.addAll(renderBoxes(size));

    if (_busy!) {
      stackChildren.add(
          Center(
            child: CircularProgressIndicator(),
          )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Object Detector"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "Fltbtn2",
            child: Icon(Icons.camera_alt),
            onPressed: getImageFromCamera,
          ),
          SizedBox(width: 10,),
          FloatingActionButton(
            heroTag: "Fltbtn1",
            child: Icon(Icons.photo),
            onPressed: getImageFromGallery,
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child:Stack(
          children: stackChildren,
        ),
      ),
    );
  }
  // gets image from camera and runs detectObject
  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if(pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image Selected");
      }
    });
    detectObject(_image!);
  }
  // gets image from gallery and runs detectObject
  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No image Selected");
      }
    });
    detectObject(_image!);
  }
}



class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
  DateTime _date = DateTime.now();
  _pickdate(BuildContext context) async {
    DateTime? date =await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year-1),
        lastDate: DateTime(DateTime.now().year+1) );
    setState(() { _date = date!; }); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body : Container(
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
              image : DecorationImage(
                image: AssetImage("assets/images/history.png"),
                fit: BoxFit.fill,
              )
          ),
          child: Column(children: [
            Padding(padding: EdgeInsets.all(70.0)),
      Row(children: [
        Padding(padding: EdgeInsets.all(15.0)),
        Text("Select the date :  ",
          style: TextStyle(color: Colors.black, fontSize: 25,
          fontWeight: FontWeight.w500, ),),
        Container(
          width: MediaQuery.of(context).size.width * 0.34,
          height: MediaQuery.of(context).size.height * 0.055,
          child:     RaisedButton(
            onPressed: (){ _pickdate(context); },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Colors.blueAccent,
            child: Text("${_date.day}-${_date.month}-${_date.year}",
              style: TextStyle( color: Colors.black, fontSize: 20,
                fontWeight: FontWeight.w500, ),),

          )
      )],),
            Padding(padding: EdgeInsets.all(200.0)),
            Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                    image : DecorationImage(
                      image: AssetImage("assets/images/sbox.JPG"),
                      fit: BoxFit.fill,
                    )
                ),
                child: FlatButton(
                  onPressed: () {
                    showAlertDialog(context);
                  },
                  child: Text("Total cal",
                    style: TextStyle(fontSize: 22),),

                )
            ),
     ],),
        )
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(""),
    content: Text("The total calories is: "),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var cond ="";
  TextEditingController _passtext = TextEditingController();
  bool error = true;
  bool _vis = true;
  TextEditingController _emailtext = TextEditingController();
  TextEditingController _nametext = TextEditingController();
  TextEditingController _phonetext = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body : Container(
          decoration: BoxDecoration(
              image : DecorationImage(
                image: AssetImage("assets/images/sign.png"),
                fit: BoxFit.fill,
              )
          ),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(130.0)),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Container(
                  child: Text("Sign Up",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(6.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller:_nametext,
                    decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle: TextStyle(fontSize: 20,color: Colors.black)
                    ),
                  )
              ),
              Padding(padding: EdgeInsets.all(6.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller:_phonetext,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      hintStyle: TextStyle(fontSize: 20,color: Colors.black),
                    ),
                  )
              ),
              Padding(padding: EdgeInsets.all(6.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller:_emailtext,
                    decoration: InputDecoration(
                        hintText: "Email Adderess",
                        hintStyle: TextStyle(fontSize: 20,color: Colors.black)
                    ),
                  )
              ),
              Padding(padding: EdgeInsets.all(6.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller:_passtext,
                    obscureText: _vis,
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(fontSize: 20,color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _vis ? Icons.visibility_off : Icons.visibility
                          ),
                          onPressed: (){
                           setState(() {
                            setState(() {
                              _vis = !_vis;
                            });
                           });
                          },
                        )
                    ),
                  )
              ),

              Padding(padding: EdgeInsets.all(20.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      image : DecorationImage(
                        image: AssetImage("assets/images/sbox.JPG"),
                        fit: BoxFit.fill,
                      )
                  ),
                  child: FlatButton(
                    onPressed: () {
                      const patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = new RegExp(patttern);
                      (_emailtext.text == "jan03112000@gmail.com")? setState((){cond = "Email already exist";}) :
                      (_phonetext.text == "9597413567")?setState((){cond = "Phone number already exist";}):
                      (!EmailValidator.validate(_emailtext.text))?setState((){cond ="Enter a valid email" ;}):
                      (!regExp.hasMatch(_phonetext.text) && _phonetext.text.length != 10)?setState((){cond ="Enter a valid phone number";}):
                      (_nametext.text == "" && _passtext == "")?setState((){cond ="Enter all credentials";}):
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => approve()));
                    },
                    child: Text("Sign Up",
                      style: TextStyle(fontSize: 22),),

                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Text("$cond",
                    style: TextStyle(color: Colors.red,fontSize: 20),textAlign: TextAlign.center,)
              )
            ],
          ),
        )
    );
  }
}



class approve extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body : Container(
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
              image : DecorationImage(
                image: AssetImage("assets/images/sign.png"),
                fit: BoxFit.fill,
              )
          ),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(140.0)),

              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Text("SUCCESSFULL!",
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                  )
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Icon(Icons.check,
                    size: 80,
                    color: Colors.black,
                  )
              ),
              Padding(padding: EdgeInsets.all(40.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Text("Accont created succesfully",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )
              ),

              Padding(padding: EdgeInsets.all(20.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      image : DecorationImage(
                        image: AssetImage("assets/images/sbox.JPG"),
                        fit: BoxFit.fill,
                      )
                  ),
                  child: FlatButton(
                    onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => SignScreen1()));
                    },
                    child: Text("Sign In",
                      style: TextStyle(fontSize: 22),),

                  )
              ),
            ],
          ),
        )
    );
  }
}

class forpass extends StatefulWidget {
  const forpass({Key? key}) : super(key: key);

  @override
  State<forpass> createState() => _forpassState();
}

class _forpassState extends State<forpass> {
  TextEditingController _emailnum = TextEditingController();
  int error = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body : Container(
          decoration: BoxDecoration(
              image : DecorationImage(
                image: AssetImage("assets/images/sign.png"),
                fit: BoxFit.fill,
              )
          ),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(130.0)),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Container(
                  child: Text("Forgot Password",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(20.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller:_emailnum,
                    decoration: InputDecoration(
                        hintText: "Email Address / Phone Number",
                        hintStyle: TextStyle(fontSize: 20,color: Colors.black)
                    ),
                  )
              ),

              Padding(padding: EdgeInsets.all(20.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      image : DecorationImage(
                        image: AssetImage("assets/images/sbox.JPG"),
                        fit: BoxFit.fill,
                      )
                  ),
                  child: FlatButton(
                    onPressed: () {
                      (_emailnum.text == "jan03112000@gmail.com" ||_emailnum.text == "9597413567")?
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => RelaxingScreen())):
                     setState((){error = 0;}) ;
                    },
                    child: Text("Next",
                      style: TextStyle(fontSize: 22),),

                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: (error == 0)?Text("enter a valid email address/number",
                    style: TextStyle(color: Colors.red,fontSize: 20),textAlign: TextAlign.center,):
                  Text("")
              ) ],
          ),
        )
    );
  }
}

class RelaxingScreen extends StatefulWidget {
  const RelaxingScreen({Key? key}) : super(key: key);

  @override
  _RelaxingScreenState createState() => _RelaxingScreenState();
}

class _RelaxingScreenState extends State<RelaxingScreen> {
  //Declare a timer
  Timer? timer;


  @override
  void initState() {
    super.initState();

    /// Initialize timer for 3 seconds, it will be active as soon as intialized
    timer = Timer(
      const Duration(seconds: 20),
          () {
        /// Navigate to seconds screen when timer callback in executed
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  passapp(error: 0,),
          ),
        );
      },
    );
  }

  /// cancel the timer when widget is disposed,
  /// to avoid any active timer that is not executed yet
  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  TextEditingController otpnum = TextEditingController();
  bool error = true;
  bool _vis = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body : Container(
          decoration: BoxDecoration(
              image : DecorationImage(
                image: AssetImage("assets/images/sign.png"),
                fit: BoxFit.fill,
              )
          ),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(130.0)),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Container(
                  child: Text("CODE VERFICATION",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Text(" Your identity has been verified set your new password",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )
              ),
              Padding(padding: EdgeInsets.all(20.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller:otpnum,
                    obscureText: _vis,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "OTP",
                        hintStyle: TextStyle(fontSize: 20,color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _vis ? Icons.visibility_off : Icons.visibility
                          ),
                          onPressed: (){
                          setState(() {
                            _vis = !_vis;
                          });
                          },
                        )
                    ),
                  )
              ),

              Padding(padding: EdgeInsets.all(20.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      image : DecorationImage(
                        image: AssetImage("assets/images/sbox.JPG"),
                        fit: BoxFit.fill,
                      )
                  ),
                  child: FlatButton(
                    onPressed: () {
                      timer!.cancel();
                      if(otpnum.text == "123456") {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => uppass()));
                      }
                      else
                      {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => passapp(error: 1,)));
                      }
                    },
                    child: Text("Verify Code",
                      style: TextStyle(fontSize: 22),),

                  )
              ),
            ],
          ),
        )
    );
  }
}

class uppass extends StatefulWidget {
  const uppass({Key? key}) : super(key: key);

  @override
  State<uppass> createState() => _uppassState();
}

class _uppassState extends State<uppass> {
  TextEditingController _newpass = TextEditingController();
  bool error = true;
  bool _vis = true;
  bool error1 = true;
  bool _vis1 = true;
  int cond = 4 ;
  TextEditingController _compass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body : Container(
          decoration: BoxDecoration(
              image : DecorationImage(
                image: AssetImage("assets/images/sign.png"),
                fit: BoxFit.fill,
              )
          ),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(130.0)),
              Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Container(
                  child: Text("New Credential",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Text("Your identity has been verified set your new password",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )
              ),
              //Padding(padding: EdgeInsets.all(5.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller:_newpass,
                    obscureText: _vis1,
                    decoration: InputDecoration(
                        hintText: "New Password",
                        hintStyle: TextStyle(fontSize: 20,color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _vis1 ? Icons.visibility_off : Icons.visibility
                          ),
                          onPressed: (){
                            setState(() {
                              _vis = !_vis;
                            });
                          },
                        )
                    ),
                  )
              ),
              Padding(padding: EdgeInsets.all(6.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    controller:_compass,
                    obscureText: _vis,
                    decoration: InputDecoration(
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(fontSize: 20,color: Colors.black),
                        suffixIcon: IconButton(
                          icon: Icon(
                              _vis ? Icons.visibility_off : Icons.visibility
                          ),
                          onPressed: (){
                            setState(() {
                              _vis = !_vis;
                            });
                          },
                        )
                    ),
                  )
              ),

              Padding(padding: EdgeInsets.all(20.0)),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                    image : DecorationImage(
                      image: AssetImage("assets/images/sbox.JPG"),
                      fit: BoxFit.fill,
                    )
                ),
                child: FlatButton(
                  onPressed: () {
                    (_newpass.text == "")?
                    setState((){cond = 0;}) :
                    (_newpass.text == "jan3")?
                    setState((){cond = 1;}):
                    (_compass.text != _newpass.text)?
                    setState((){cond = 2;}):
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => passapp(error : 2)));
                  },
                  child: Text("Update",
                    style: TextStyle(fontSize: 22),),

                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: (cond == 0)?Text("please fill the new password",
                    style: TextStyle(color: Colors.red,fontSize: 20),textAlign: TextAlign.center,):
                  (cond == 1)?Text("old password cannot be your new password",
                    style: TextStyle(color: Colors.red,fontSize: 20),textAlign: TextAlign.center,):
                  (cond == 2)?Text("confirm password should be equal to password",
                    style: TextStyle(color: Colors.red,fontSize: 20),textAlign: TextAlign.center,):
                  Text("")
              )
            ],
          ),
        )
    );
  }
}

class passapp extends StatelessWidget {
  final error;
  const passapp({Key?key,@override this.error}):
      super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body : Container(
          width: MediaQuery.of(context).size.width * 1,
          decoration: BoxDecoration(
              image : DecorationImage(
                image: AssetImage("assets/images/sign.png"),
                fit: BoxFit.fill,
              )
          ),
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(140.0)),

              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.15,
                  child: (error == 0)?Text("TIMED OUT",
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                  ):(error == 1)?Text("INCORRECT PASSWORD",
                style: TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
              ):
                  Text("PASSWORD UPDATED",
                    style: TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                  )
              ),
              //Padding(padding: EdgeInsets.all(5.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: (error == 2)?Icon(Icons.check_circle_outline,
                    size: 80,
                    color: Colors.black,
                  ):
                  Icon(Icons.cancel_outlined,
                    size: 80,
                    color: Colors.black,
                  )
              ),
              Padding(padding: EdgeInsets.all(40.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: (error == 0)?Text("Page has been timed out please try again",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ):(error == 1)?Text("Incorret OTP please try again",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ):
                  Text("Your has password has been updated",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )
              ),

              Padding(padding: EdgeInsets.all(10.0)),
              Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      image : DecorationImage(
                        image: AssetImage("assets/images/sbox.JPG"),
                        fit: BoxFit.fill,
                      )
                  ),
                  child: FlatButton(
                    onPressed: () {
                      (error == 2)?Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignScreen1())):
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => forpass()));
                    },
                    child: (error == 2)?Text("Sign In",
                      style: TextStyle(fontSize: 22),):
                    Text("Try Again",
                      style: TextStyle(fontSize: 22),)
                  )
              ),
            ],
          ),
        )
    );
  }
}

