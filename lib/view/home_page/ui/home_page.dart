import 'package:fakestore_ufc/utils/text_fields.dart';
import 'package:fakestore_ufc/view/detail_page/product_detail_page.dart';
import 'package:fakestore_ufc/view/home_page/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Fakestore'),
      ),
      body: Obx(
        () => Container(
          margin: EdgeInsets.symmetric(
            horizontal: mq.width * 0.03,
            vertical: mq.height * 0.02,
          ),
          child: GridView.builder(
            itemCount: controller.products.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = controller.products[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => ProductDetailPage(
                        product: item,
                      ));
                },
                child: Card(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(1, 5))
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          height: MediaQuery.of(context).size.height * 0.11,
                          child: Image(
                            image: NetworkImage(item.image ??
                                "https://expressdeco.com.au/wp-content/uploads/2017/05/placeholder.jpg"),
                            fit: BoxFit.cover,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          item.title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Rs ${item.price.toString()}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontSize: 16),
                          ),
                          IconButton(
                              onPressed: () {
                                controller.deleteProduct(item.id.toString());
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      )
                    ],
                  ),
                )),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 0.9),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: Colors.white,
                  title: const Text('Create New Product'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      textFormField(
                          labelText: 'Title',
                          controller: controller.titleController.value),
                      SizedBox(height: mq.height * 0.01),
                      textFormField(
                          labelText: 'Description',
                          controller: controller.descController.value),
                      SizedBox(height: mq.height * 0.01),
                      textFormField(
                          labelText: 'Price',
                          controller: controller.priceController.value),
                      SizedBox(height: mq.height * 0.01),
                      textFormField(
                          labelText: 'Category',
                          controller: controller.categController.value),
                      SizedBox(height: mq.height * 0.01),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          controller.addProduct();
                        },
                        minWidth: double.infinity,
                        height: mq.height * 0.05,
                        color: Colors.green,
                        textColor: Colors.white,
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
