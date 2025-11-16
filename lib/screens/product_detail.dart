import 'package:flutter/material.dart';
import 'package:oldschool_strike/models/product_entry.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({super.key, required this.product});

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatCurrency(int? value) {
    final v = (value ?? 0).toString().split('').reversed.toList();
    final parts = <String>[];
    for (var i = 0; i < v.length; i += 3) {
      parts.add(
        v.sublist(i, i + 3 > v.length ? v.length : i + 3).reversed.join(),
      );
    }
    return parts.reversed.join('.');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
        backgroundColor: theme.colorScheme.secondary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF0F3FA),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;
          Widget imageWidget = ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail ?? '')}',
              width: double.infinity,
              height: isWide ? 520 : 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => Container(
                height: isWide ? 520 : 250,
                color: Colors.grey[200],
                child: const Center(child: Icon(Icons.broken_image, size: 48)),
              ),
            ),
          );

          Widget detailsCard = Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isWide ? 420 : double.infinity,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product.isFeatured == true)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        margin: const EdgeInsets.only(bottom: 12.0),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent.shade100,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const Text(
                          'Featured',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    Text(
                      product.name ?? '',
                      style: const TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Rp ${_formatCurrency(product.price)}',
                      style: const TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 6.0,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondary.withOpacity(
                              0.12,
                            ),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            (product.category ?? '').toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _formatDate(product.dateAdded),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 12),
                    Text(
                      product.description ?? '',
                      style: const TextStyle(fontSize: 15.0, height: 1.6),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(
                          0xFF395886,
                        ), // warna background
                        foregroundColor: Colors.white, // warna tulisan
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'ᯓ⚽︎LDSCHOOL STRIKEᯓ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

          if (isWide) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // left: image card (white background frame)
                  Expanded(
                    flex: 2,
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: imageWidget,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  // right: details
                  Expanded(flex: 1, child: detailsCard),
                ],
              ),
            );
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: imageWidget,
                  ),
                  const SizedBox(height: 16),
                  detailsCard,
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
