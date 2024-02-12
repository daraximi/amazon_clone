import 'dart:io';

import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("dlidmlicv", 'edeaz9pg');
      List<String> imageUrls = [];
      for (File image in images) {
        CloudinaryResponse response = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(image.path, folder: name));
        imageUrls.add(response.secureUrl);
      }
      Product product = Product(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrls,
          category: category,
          price: price);
      //POST TO SERVER
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
