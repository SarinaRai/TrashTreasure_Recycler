import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:trashtreasure_recycler/pages/home_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  File? _image;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productTypeController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future addProduct(context) async {
    final Uri uri = Uri.parse('http://192.168.56.1:5000/addProduct');
    final request = http.MultipartRequest('POST', uri);
    request.fields['product_name'] = productNameController.text;
    request.fields['product_price'] = productPriceController.text;
    request.fields['product_type'] = productTypeController.text;
    request.fields['product_description'] = productDescriptionController.text;
    if (_image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', _image!.path));
    }

    final response = await request.send();
    if (response.statusCode == 200) {
      print('Product added successfully');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('TrashTreasure'),
          content: const Text('Product added successfully'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      // Handle success
    } else if (response.statusCode == 400) {
      print('Please fill all the fields');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('TrashTreasure'),
          content: const Text('Please fill all the fields.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      print('Failed to add product');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('TrashTreasure'),
          content: const Text('Failed to add Product'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      // Handle failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Text(
                AppLocalizations.of(context)!.add,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 2, 62, 33)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: productNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: AppLocalizations.of(context)!.productName),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 35, 10, 0),
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: productPriceController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: AppLocalizations.of(context)!.productPrice,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 35, 10, 0),
              child: SizedBox(
                height: 50,
                child: TextField(
                  controller: productTypeController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      hintText: AppLocalizations.of(context)!.productType),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 35, 10, 0),
              child: SizedBox(
                height: 120, // Increased height to accommodate more lines
                child: TextField(
                  maxLines: null, // Allow unlimited lines
                  controller: productDescriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    hintText: AppLocalizations.of(context)!.description,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10), // Added padding
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              child: InkWell(
                onTap: getImage,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.upload,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Upload Image",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
                height: 50,
                width: 370,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 2, 62, 33)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  child: Text(
                    AppLocalizations.of(context)!.add,
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () => addProduct(context),
                )),
          ],
        ),
      ),
    );
  }
}
