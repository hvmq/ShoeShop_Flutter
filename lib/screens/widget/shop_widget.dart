import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoeshop_flutter/constants.dart';
import 'package:shoeshop_flutter/providers/shoe_provider.dart';
import 'package:shoeshop_flutter/screens/widget/custom_pain.dart';
import 'package:shoeshop_flutter/screens/widget/list_item_shop.dart';

class ShopWidget extends StatefulWidget {
  const ShopWidget({super.key});

  @override
  State<ShopWidget> createState() => _ShopWidgetState();
}

class _ShopWidgetState extends State<ShopWidget> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      height: 600,
      width: 350,
      decoration: BoxDecoration(
          color: AppColor.colorWhite,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColor.colorGray.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
          ]),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CustomPaint(
              size: Size(size.width, size.height),
              painter: ContainerCustomPainter(),
            ),
          ),
          Positioned(
              top: 7,
              left: 20,
              child: Image.asset(
                "assets/images/nike.png",
                width: 50,
                height: 40,
              )),
          const Positioned(
            left: 20,
            top: 60,
            child: Text(
              "Our Products",
              style: TextStyle(fontSize: 25, fontFamily: "Rubik-Bold"),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 0,
            child: Consumer<ShoeProvider>(
                builder: (context, shoeData, child) => SizedBox(
                      height: 490,
                      width: 310,
                      child: shoeData.shoes.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: shoeData.shoes.length,
                              itemBuilder: (context, index) {
                                return ListItemShop(
                                  shoe: shoeData.shoes[index],
                                  index: index,
                                );
                              },
                            ),
                    )),
          ),
        ],
      ),
    );
  }
}
