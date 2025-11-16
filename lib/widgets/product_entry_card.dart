import 'package:flutter/material.dart';
import 'package:oldschool_strike/models/product_entry.dart';

class ProductEntryCard extends StatelessWidget {
  final ProductEntry product;
  final VoidCallback onTap;

  const ProductEntryCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  String _formatCurrency(int value) {
    final s = value.toString().split('').reversed.toList();
    final parts = <String>[];
    for (var i = 0; i < s.length; i += 3) {
      parts.add(
        s.sublist(i, i + 3 > s.length ? s.length : i + 3).reversed.join(),
      );
    }
    return parts.reversed.join('.');
  }

  String _titleCase(String? s) {
    if (s == null || s.trim().isEmpty) return '';
    final t = s.trim();
    return t.length == 1
        ? t.toUpperCase()
        : (t[0].toUpperCase() + t.substring(1).toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    // fixed color for category
    const categoryColor = Color(0xFF0F6FB8);

    final categoryText = product.category ?? '';
    final hasCategory = categoryText.trim().isNotEmpty;
    final categoryLabel = hasCategory ? '[${_titleCase(categoryText)}] ' : '';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.blue.shade50),
        ),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail with fixed ratio
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.network(
                  // safe fallback if thumbnail null
                  'http://localhost:8000/proxy-image/?url=${Uri.encodeComponent(product.thumbnail ?? '')}',
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 40),
                    ),
                  ),
                ),
              ),
            ),

            // Header (price, then category + name on one line)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price
                  Text(
                    'Rp ${_formatCurrency(product.price ?? 0)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Category + Name on same line: "[Category] Product Name"
                  Text.rich(
                    TextSpan(
                      children: [
                        if (hasCategory)
                          TextSpan(
                            text: categoryLabel,
                            style: const TextStyle(
                              color: categoryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        TextSpan(
                          text: product.name ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Flexible middle area: description + spacer + divider + footer
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description (can be short)
                    Text(
                      product.description ?? '',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 13,
                        height: 1.25,
                      ),
                    ),

                    // push divider + footer to bottom
                    const Spacer(),

                    // light divider
                    Divider(height: 1, color: Colors.grey.shade200),

                    // footer row (featured + details)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Row(
                        children: [
                          if (product.isFeatured == true)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.greenAccent.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Featured',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          const Spacer(),
                          TextButton(
                            onPressed: onTap,
                            child: const Text('Details →'),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(50, 30),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
