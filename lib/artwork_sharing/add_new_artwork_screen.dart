import 'dart:convert';
import 'dart:io';

import 'package:aws_flutter/api/base_client.dart';
import 'package:aws_flutter/model/art_work.dart';
import 'package:aws_flutter/model/category.dart';
import 'package:aws_flutter/model/login_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddNewArtWorkScreen extends StatefulWidget {

  @override
  _AddArtWorkState createState() => _AddArtWorkState();
}

class _AddArtWorkState extends State<AddNewArtWorkScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // final TextEditingController _imageUrlController = TextEditingController();
  String _selectedCategory = '';
  late String _name;
  late String _description;
  late double _price;
  File? _image;
  late String _imageUrl;

  late Future<List<Category>> futureCategory;
  late List<Category> listCategory = [];

  final storage = FlutterSecureStorage();
  late Future<Accinfo?> accInfoFuture;
  late Future<String?> tokenFuture;
  late Accinfo accinfo = Accinfo.empty();
  late String token = '';

  @override
  void dispose() {
    // _imageUrlController.dispose();
    super.dispose();
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<Accinfo?> getAccInfo() async {
    String? accinfoJsonString = await storage.read(key: 'accinfo');
    if (accinfoJsonString != null) {
      Map<String, dynamic> accinfoJson = json.decode(accinfoJsonString);
      Accinfo accinfo = Accinfo.fromJson(accinfoJson);
      return accinfo;
    }
    return null;
  }

  void _submitForm() {
    if(_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      ArtworkModel newArtwork = ArtworkModel(
          imageUrl: _imageUrl,
          categoryId: _selectedCategory,
          name: _name,
          description: _description,
          price: _price
      );
      final response = BaseClient().createArtWork(
          userAccountId: accinfo.id,
          categoryId: newArtwork.categoryId,
          name: newArtwork.name,
          description: newArtwork.description,
          price: newArtwork.price,
          imageUrl: newArtwork.imageUrl);
      response.then((value) {
        if(value.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Add artwork success'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Add artwork fail'),
            ),
          );
        }
      });
      print('New Artwork: $newArtwork');
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateImage() async {
    if(_image == null) return;
    try {
      Reference ref = FirebaseStorage.instance.ref().child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = ref.putFile(_image!);
      uploadTask.whenComplete(() async {
        String url = await ref.getDownloadURL();
        setState(() {
          _imageUrl = url;
        });
        _submitForm();
      });
    } catch (e) {
      print('Error updating image : $e');
    }
  }

  @override
  void initState() {
    initializedData();
    super.initState();
  }

  Future<void> initializedData() async {
    futureCategory = BaseClient().fetchCategories();
    await futureCategory.then((value) => setState(() {
      listCategory = value.toList();
    }));
    tokenFuture = getToken();
    tokenFuture.then((value) => {
      setState(() {
        token = value!;
      })
    });
    accInfoFuture = getAccInfo();
    accInfoFuture.then((value) => {
      setState(() {
        accinfo = value!;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Artwork'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  onTap: _getImage,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: _image != null
                        ? Image.file(_image!, fit: BoxFit.cover)
                        : Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
                  ),
                ),
                DropdownButtonFormField(
                    value: listCategory[0].id,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  items: listCategory
                      .map((category) => DropdownMenuItem(
                    value: category.id,
                    child: Text(category.categoryName),
                  ))
                      .toList(),
                  decoration: InputDecoration(labelText: 'Category'),
                  validator: (value) {
                      if(value == '') {
                        return 'Please select a category.';
                      }
                      return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'Please enter artwork name.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'Please enter a description.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _description = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(value!.isEmpty) {
                      return 'Please enter a price.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _price = double.parse(value!);
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: _updateImage,
                    child: Text('Create'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}