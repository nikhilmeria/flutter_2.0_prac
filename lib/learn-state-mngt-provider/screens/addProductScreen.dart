import 'package:coffee_shop_ui/learn-state-mngt-provider/models/product.dart';
import 'package:coffee_shop_ui/learn-state-mngt-provider/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  bool isLoading = false;
  TextEditingController _imageUrlController = TextEditingController();
  FocusNode _imageUrlFocusNode = FocusNode();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //Video no 231

  Product newProduct = Product(
    id: "",
    title: "",
    description: "",
    price: 0.0,
    imageUrl: "",
  );

  @override
  void initState() {
    print("initState called");
    _imageUrlFocusNode.addListener(_imageUpload); // video no 230
    super.initState();
  }

  @override
  void dispose() {
    print("dispose called");
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    // _imageUrlFocusNode.removeListener(_imageUpload); // video no 230
    super.dispose();
  } // always dispose all "TextEditingController" to avoid mem leak.

  void _imageUpload() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    setState(() {
      isLoading = true;
    });
    _formKey.currentState!.save();
    print("_saveForm 1 => ${newProduct.title}");
    print("_saveForm 2 => ${newProduct.description}");
    print("_saveForm 3 => ${newProduct.price}");
    print("_saveForm 4 => ${newProduct.imageUrl}");

    Provider.of<ProductProvider>(context, listen: false)
        .addProduct(newProduct)
        .catchError((err) {
      return showDialog<Null>(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Something went wrong, try again...'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Okay'),
                ),
              ],
            );
          });
    }).then((_) {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Title",
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please input a title...";
                  }
                  return null;
                },
                onSaved: (newValue) => newProduct.title = newValue,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Price",
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please input a Price...";
                  }
                  if (double.tryParse(value) == null) {
                    return "Please input  a valid Price...";
                  }
                  if (double.parse(value) <= 0) {
                    return "Please input a Price greater than zero...";
                  }
                  return null;
                },
                onSaved: (newValue) =>
                    newProduct.price = double.parse(newValue!),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Description",
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please input a Description...";
                  }
                  return null;
                },
                onSaved: (newValue) => newProduct.description = newValue,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? Center(
                            child: Text(
                              'Enter a URL',
                              textAlign: TextAlign.center,
                            ),
                          )
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onEditingComplete: () {
                        setState(() {});
                      },
                      onFieldSubmitted: (value) => _saveForm(),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please input a ImageUrl...";
                        }
                        return null;
                      },
                      onSaved: (newValue) => newProduct.imageUrl = newValue,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  alignment: Alignment.center,
                  fixedSize: MaterialStateProperty.all(
                    Size(100, 50),
                  ),
                ),
                onPressed: _saveForm,
                child: isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
