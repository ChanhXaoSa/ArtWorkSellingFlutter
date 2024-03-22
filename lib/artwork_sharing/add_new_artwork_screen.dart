import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ArtworkModel {
  String imageUrl;
  String category;
  String name;
  String description;
  double price;

  ArtworkModel({required this.imageUrl, required this.category, required this.name, required this.description, required this.price});
}

class AddNewArtWorkScreen extends StatefulWidget {

  @override
  _AddArtWorkState createState() => _AddArtWorkState();
}

class _AddArtWorkState extends State<AddNewArtWorkScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _imageUrlController = TextEditingController();
  String _selectedCategory = '';
  late String _name;
  late String _description;
  late double _price;
  File? _image;

  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if(_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      String imageUrl = _imageUrlController.text;
      ArtworkModel newArtwork = ArtworkModel(
          imageUrl: imageUrl,
          category: _selectedCategory,
          name: _name,
          description: _description,
          price: _price
      );
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

  @override
  void initState() {
    super.initState();
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
                    value: _selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                  items: ['','Category 1', 'Category 2', 'Category 3']
                      .map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(category),
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
                    onPressed: _submitForm,
                    child: Text('Create Artwork'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}