import 'dart:developer';
import 'package:fakestore_ufc/data/providers/api_endpoints.dart';
import 'package:fakestore_ufc/data/providers/api_provider.dart';
import 'package:fakestore_ufc/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class HomeController extends GetxController {
  @override
  onInit() {
    super.onInit();
    fetchProducts();
  }

  RxList<ProductModel> products = <ProductModel>[].obs;
  RxBool isLoading = false.obs;
  final titleController = TextEditingController().obs;
  final descController = TextEditingController().obs;
  final priceController = TextEditingController().obs;
  final categController = TextEditingController().obs;
  final apiService = ApiProvider();

  Future<void> fetchProducts() async {
    try {
      List<dynamic>? data =
          await apiService.get(endpoint: ApiEndpoints.products);
      if (data != null) {
        log("Data: $data");
        List<ProductModel> product =
            data.map((item) => ProductModel.fromJson(item)).toList();
        products.addAll(product);
        print("Products: $products");
      } else {
        log("NO data found");
      }
    } catch (e) {
      log("Something Went Wrong: $e");
    }
  }

  Future<void> addProduct() async {
    if (titleController.value.text.isEmpty ||
        priceController.value.text.isEmpty ||
        descController.value.text.isEmpty ||
        categController.value.text.isEmpty) {
      Get.snackbar(
        "Adding Failed",
        "Fields cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return;
    }

    try {
      final double? price = double.tryParse(priceController.value.text);
      if (price == null) {
        Get.snackbar(
          "Adding Failed",
          "Invalid price format",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          maxWidth: mq.width,
        );
        return;
      }

      final response = await apiService.post(
        endpoint: ApiEndpoints.products,
        body: {
          "title": titleController.value.text,
          "price": price.toString(),
          "description": descController.value.text,
          "category": categController.value.text,
        },
      );

      if (response != null) {
        log("Response: $response");
        final newProduct = ProductModel.fromJson(response);
        products.add(newProduct);
        Get.back();
        products.refresh();
        titleController.value.clear();
        priceController.value.clear();
        descController.value.clear();
        categController.value.clear();
        log("Product added successfully: $newProduct");
      } else {
        log("Response is NULL");
      }
    } catch (e) {
      log("Something Went Wrong: $e");
    }
  }

  Future<void> deleteProduct(String pId) async {
    try {
      final url = "${ApiEndpoints.products}/$pId";
      final response = await apiService.delete(endpoint: url);

      if (response != null) {
        log('Deleted Product: $response');
        products.removeWhere((product) => product.id == int.parse(pId));
        products.refresh();
        log("Updated products list: $products");
      } else {
        log('Cannot Delete Product');
      }
    } catch (e) {
      log("Something Went Wrong: $e");
    }
  }
}
