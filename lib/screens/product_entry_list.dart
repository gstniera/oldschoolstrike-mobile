import 'package:flutter/material.dart';
import 'package:oldschool_strike/models/product_entry.dart';
import 'package:oldschool_strike/widgets/left_drawer.dart';
import 'package:oldschool_strike/screens/product_detail.dart';
import 'package:oldschool_strike/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductEntryListPage extends StatefulWidget {
  final bool onlyMine;
  const ProductEntryListPage({super.key, this.onlyMine = false});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    final response = await request.get('http://localhost:8000/json/');

    var data = response as List<dynamic>;

    String? myUsername;
    if (widget.onlyMine) {
      final whoami = await request.get('http://localhost:8000/auth/whoami/');
      if (whoami != null && whoami['username'] != null) {
        myUsername = whoami['username'] as String;
      }
    }

    List<ProductEntry> listProduct = [];
    for (var d in data) {
      if (d == null) continue;
      final Map<String, dynamic> obj = Map<String, dynamic>.from(d);

      if (widget.onlyMine) {
        if (myUsername == null) continue;

        dynamic ownerField =
            obj['owner'] ??
            obj['username'] ??
            obj['created_by'] ??
            obj['user'] ??
            obj['user_username'] ??
            obj['user_name'] ??
            obj['owner_username'];

        if ((ownerField == null || ownerField is Map) && obj['user'] is Map) {
          final userMap = Map<String, dynamic>.from(obj['user']);
          ownerField =
              ownerField ??
              userMap['username'] ??
              userMap['user_username'] ??
              userMap['name'];
        }

        if (ownerField == null) continue;
        if (ownerField.toString() != myUsername) continue;
      }

      listProduct.add(ProductEntry.fromJson(obj));
    }

    return listProduct;
  }

  int _crossAxisCountForWidth(double width) {
    if (width >= 1150) return 3;
    if (width >= 700) return 2;
    return 1;
  }

  double _childAspectRatioForWidth(double width) {
    if (width >= 1150) return 0.75; // wide screens: card a bit squarer
    if (width >= 700) return 0.8; // medium
    return 0.9; // mobile: taller card
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.onlyMine ? 'My Products' : 'Product Entry List'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      backgroundColor: const Color(0xFFEAF6FF),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // snapshot has completed; ensure we have a List
            final List<ProductEntry> products =
                (snapshot.data is List<ProductEntry>)
                ? snapshot.data as List<ProductEntry>
                : <ProductEntry>[];

            if (products.isEmpty) {
              return const Center(
                child: Text(
                  'There are no product in Oldschool Strike yet.',
                  style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                ),
              );
            } else {
              final width = MediaQuery.of(context).size.width;
              final crossAxisCount = _crossAxisCountForWidth(width);
              final childAspectRatio = _childAspectRatioForWidth(width);

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 12.0,
                ),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemBuilder: (context, index) {
                    final p = products[index];
                    return ProductEntryCard(
                      product: p,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(product: p),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
