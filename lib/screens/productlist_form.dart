import 'package:flutter/material.dart';
import 'package:oldschool_strike/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:oldschool_strike/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _description = "";
  String _category = "hot"; // default
  String _thumbnail = "";
  bool _isFeatured = false; // default

  final List<String> _categories = [
    'popular',
    'hot',
    'exclusive',
    'almost gone',
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ᯓ★Create New Product⋆˚࿔',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: const Color(0xFF395886),
        foregroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: LeftDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD5DEEF), Color(0xFFEAF6FF)],
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Form Container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF395886).withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      const Row(
                        children: [
                          Icon(
                            Icons.edit_note,
                            color: Color(0xFF395886),
                            size: 28.0,
                          ),
                          SizedBox(width: 12.0),
                          Text(
                            'Product Details',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF395886),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),

                      // === Name ===
                      _buildLabel('Product Name✰'),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        maxLength: 255,
                        decoration: _buildInputDecoration(
                          hint: "Enter product name",
                          icon: Icons.inventory_outlined,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _name = value ?? "";
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Product name cannot be empty!";
                          }
                          final length = value.trim().length;
                          if (length > 255) {
                            return "Product name cannot be over 255 letters (there's $length).";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16.0),

                      // === Price ===
                      _buildLabel('Price (IDR)✰'),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        decoration: _buildInputDecoration(
                          hint: "contoh: 150000",
                          icon: Icons.attach_money,
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (String? value) {
                          setState(() {
                            _price = int.tryParse(value ?? '') ?? 0;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Price cannot be empty!";
                          }
                          final n = int.tryParse(value);
                          if (n == null || n < 0) return "Price is not valid!";
                          return null;
                        },
                      ),

                      const SizedBox(height: 16.0),

                      // === Description ===
                      _buildLabel('Description✰'),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        maxLines: 4,
                        decoration: _buildInputDecoration(
                          hint: "Enter product description",
                          icon: Icons.description_outlined,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _description = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Product description cannot be empty!";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 16.0),

                      // === Category ===
                      _buildLabel('Category✰'),
                      const SizedBox(height: 8.0),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F3FA),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: const Color(0xFF628ECB).withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.category_outlined,
                              color: Color(0xFF628ECB),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 16.0,
                            ),
                          ),
                          value: _category,
                          items: _categories
                              .map(
                                (cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(
                                    cat[0].toUpperCase() + cat.substring(1),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _category = newValue!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Category cannot be empty!";
                            }
                            if (!_categories.contains(value)) {
                              return "Category is not valid!";
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 16.0),

                      // === Thumbnail URL ===
                      _buildLabel('Thumbnail URL✰'),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        decoration: _buildInputDecoration(
                          hint: "https://example.com/image.jpg",
                          icon: Icons.image_outlined,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _thumbnail = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Thumbnail cannot be empty!";
                          }
                          final uri = Uri.tryParse(value.trim());
                          if (uri == null ||
                              !(uri.hasScheme &&
                                  (uri.scheme == 'http' ||
                                      uri.scheme == 'https'))) {
                            return "Thumbnail must be a valid http/https URL!";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20.0),

                      // === Is Featured ===
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F3FA),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: const Color(0xFF628ECB).withOpacity(0.3),
                            width: 1.5,
                          ),
                        ),
                        child: SwitchListTile(
                          title: const Text(
                            "Mark as a featured product ⭐",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF395886),
                            ),
                          ),
                          activeColor: const Color(0xFF628ECB),
                          value: _isFeatured,
                          onChanged: (bool value) {
                            setState(() {
                              _isFeatured = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24.0),

                // === Save Button ===
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF628ECB), Color(0xFF395886)],
                    ),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF395886).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          final response = await request.postJson(
                            "http://localhost:8000/create-flutter/",
                            jsonEncode({
                              "name": _name,
                              "price": _price,
                              "description": _description,
                              "thumbnail": _thumbnail,
                              "category": _category,
                              "is_featured": _isFeatured,
                            }),
                          );
                          if (context.mounted) {
                            if (response['status'] == 'success') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("News successfully saved!"),
                                  backgroundColor: Color(0xFF395886),
                                ),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHomePage(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Something went wrong, please try again.",
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        }
                      },
                      borderRadius: BorderRadius.circular(16.0),
                      child: const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.save_outlined,
                              color: Colors.white,
                              size: 24.0,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              "Save Product⌯⌲",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFF395886),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hint,
    required IconData icon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
      prefixIcon: Icon(icon, color: const Color(0xFF628ECB)),
      filled: true,
      fillColor: const Color(0xFFF0F3FA),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
          color: const Color(0xFF628ECB).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(
          color: const Color(0xFF628ECB).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Color(0xFF628ECB), width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: const BorderSide(color: Colors.red, width: 2.0),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 16.0,
      ),
    );
  }
}
