import 'package:flutter/material.dart';
import 'package:ur_provider/features/providers/domain/domain.dart';
import 'package:ur_provider/features/providers/domain/entities/product.dart';


class SupplierCard extends StatelessWidget {

  final Supplier supplier;

  const SupplierCard({
    super.key,
    required this.supplier
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ImageViewer( image: supplier.image ),
        Text( supplier.supplierName, textAlign: TextAlign.center, ),
        const SizedBox(height: 20)
      ],
    );
  }
}

class _ImageViewer extends StatelessWidget {

  final String image;

  const _ImageViewer({ required this.image });

  @override
  Widget build(BuildContext context) {

    if ( image.isEmpty ) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset('assets/images/no-image.jpg',
          fit: BoxFit.cover,
          height: 250,
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: FadeInImage(
        fit: BoxFit.cover,
        height: 250,
        fadeOutDuration: const Duration(milliseconds: 100),
        fadeInDuration: const Duration(milliseconds: 200),
        image: NetworkImage( image ),
        placeholder: const AssetImage('assets/loaders/bottle-loader.gif'),
      ),
    );

  }
}