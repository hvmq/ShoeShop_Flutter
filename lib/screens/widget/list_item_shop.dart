import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:provider/provider.dart';
import 'package:shoeshop_flutter/constants.dart';
import 'package:shoeshop_flutter/models/shoe.dart';
import 'package:shoeshop_flutter/providers/shoe_provider.dart';

class ListItemShop extends StatefulWidget {
  final Shoe shoe;
  final int index;
  const ListItemShop({super.key, required this.shoe, required this.index});

  @override
  State<ListItemShop> createState() => _ListItemWidgetState();
}

class _ListItemWidgetState extends State<ListItemShop> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
  }

  @override
  Widget build(BuildContext context) {
    String? colorShoe = widget.shoe.color?.substring(1);
    final shoeProvider = Provider.of<ShoeProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 300,
          height: 370,
          decoration: BoxDecoration(
              color: Color(int.parse('0xFF${colorShoe!}')),
              borderRadius: BorderRadius.circular(30)),
          child: Transform.rotate(
              angle: -pi / 7,
              origin: const Offset(0, 50),
              child: Center(child: Image.network(widget.shoe.image))),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.shoe.name,
          style: const TextStyle(
            fontSize: 18,
            fontFamily: 'Rubik-SemiBold',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          widget.shoe.description!,
          style: const TextStyle(
              fontSize: 13, fontFamily: 'Rubik-Light', height: 2),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "\$${widget.shoe.price}",
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Rubik-SemiBold',
                ),
              ),
            ),
            widget.shoe.isCart == false
                ? ElevatedButton(
                    onPressed: () async {
                      shoeProvider.updateIsCart(widget.index, true, 1);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.colorYellow,
                        minimumSize: const Size(80, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: const Text(
                      'ADD TO CART',
                      style: TextStyle(
                          fontFamily: 'Rubik-SemiBold',
                          color: AppColor.colorBlack),
                    ))
                : Container(
                    height: 45,
                    width: 45,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColor.colorYellow),
                    child: Center(
                      child: Image.asset(
                        'assets/images/check.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                  )
          ],
        ),
        const SizedBox(
          height: 60,
        )
      ],
    );
  }
}
