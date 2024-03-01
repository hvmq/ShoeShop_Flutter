import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoeshop_flutter/constants.dart';
import 'package:shoeshop_flutter/models/shoe.dart';
import 'package:shoeshop_flutter/providers/shoe_provider.dart';
import 'package:shoeshop_flutter/screens/widget/custom_pain.dart';
import 'package:shoeshop_flutter/screens/widget/list_item_cart.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  totalCart(List<Shoe> list) {
    double total = 0;
    for (int i = 0; i < list.length; i++) {
      total = total + (list[i].price * list[i].number!);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Consumer<ShoeProvider>(
      builder: (context, cartData, child) => Container(
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
                "Your Cart",
                style: TextStyle(fontSize: 25, fontFamily: "Rubik-Bold"),
              ),
            ),
            Positioned(
              right: 20,
              top: 60,
              child: Text(
                "\$${(totalCart(cartData.carts)).toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 25, fontFamily: "Rubik-Bold"),
              ),
            ),
            cartData.carts.isEmpty
                ? const Positioned(
                    left: 20, top: 100, child: Text('Your cart is empty.'))
                : Positioned(
                    left: 20,
                    bottom: 0,
                    child: SizedBox(
                      height: 490,
                      width: 310,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cartData.carts.length,
                          itemBuilder: (context, index) {
                            return ListItemCart(
                              cart: cartData.carts[index],
                              index: index,
                            );
                          }),
                    )),
          ],
        ),
      ),
    );
  }
}
