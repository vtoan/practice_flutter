import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/apiService.dart';
import 'package:my_app/productModel.dart';

class FormEditPage extends StatefulWidget {
  final Product product;
  FormEditPage({required this.product});
  @override
  _FormEdit createState() => _FormEdit(product);
}

class _FormEdit extends State<FormEditPage> {
  final emtpy = "/icons/user.png";

  int id = 0;
  String d6Ctrl = "";

  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();

  final d0Ctrl = TextEditingController();
  final d1Ctrl = TextEditingController();
  final d2Ctrl = TextEditingController();
  final d3Ctrl = TextEditingController();
  final d4Ctrl = TextEditingController();
  final d5Ctrl = TextEditingController();

  _FormEdit(var p) {
    id = p.id;
    d0Ctrl.text = p.p0;
    d1Ctrl.text = p.p1;
    d2Ctrl.text = p.p2;
    d3Ctrl.text = p.p3;
    d4Ctrl.text = p.p4;
    d5Ctrl.text = p.p5;
    d6Ctrl = p.p6;
  }

  Product getData() => Product(
      id: id,
      p0: d0Ctrl.text,
      p1: d1Ctrl.text,
      p2: d2Ctrl.text,
      p3: d3Ctrl.text,
      p4: d4Ctrl.text,
      p5: d5Ctrl.text,
      p6: d6Ctrl == "" ? emtpy : d6Ctrl);

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // File _image = File(pickedFile.path);
      setState(() {
        d6Ctrl = pickedFile.path;
      });
      // getting a directory path for saving
      // final Directory extDir = await getApplicationDocumentsDirectory();
      // final Directory savedDir = Directory(_image.path);
      // String dirPath = extDir.path;
      // final String filePath = '$dirPath/image.png';
      // copy the file to a new path
      // final File newImage = await _image.copy(filePath);
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff9f9f9),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black54),
          backgroundColor: Color(0xfff9f9f9),
          elevation: 0.0,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${id == 0 ? 'Create' : 'Edit'} Product",
                style: Theme.of(context).textTheme.headline5?.apply(
                      fontWeightDelta: 2,
                    ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (id == 0)
                    ApiService.createProduct(getData())
                        .then((value) => Navigator.pushNamed(context, "/"));
                  else
                    ApiService.updateProduct(getData())
                        .then((value) => Navigator.pushNamed(context, "/"));
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "SAVE",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Container(
                            height: 150,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.network(
                                  d6Ctrl == "" ? emtpy : d6Ctrl,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                getImage();
                              },
                              child: const Text('Browser'),
                            ),
                          ),
                        ],
                      )),
                  TextFormField(
                    controller: d0Ctrl,
                    decoration: InputDecoration(labelText: "D0"),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter some text for D0'
                        : null,
                  ),
                  TextFormField(
                    controller: d1Ctrl,
                    decoration: InputDecoration(labelText: "D1"),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter some text for D1'
                        : null,
                  ),
                  TextFormField(
                    controller: d2Ctrl,
                    decoration: InputDecoration(labelText: "D2"),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter some text for D2'
                        : null,
                  ),
                  TextFormField(
                    controller: d3Ctrl,
                    decoration: InputDecoration(labelText: "D3"),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter some text for D3'
                        : null,
                  ),
                  TextFormField(
                    controller: d4Ctrl,
                    decoration: InputDecoration(labelText: "D4"),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter some text for D4'
                        : null,
                  ),
                  TextFormField(
                    controller: d5Ctrl,
                    decoration: InputDecoration(labelText: "D5"),
                    validator: (value) => (value == null || value.isEmpty)
                        ? 'Please enter some text for D5'
                        : null,
                  ),
                ],
              )),
        ));
  }
}
