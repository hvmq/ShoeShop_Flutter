import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shoeshop_flutter/constants.dart';
import 'package:shoeshop_flutter/models/shoe.dart';
import 'package:shoeshop_flutter/providers/shoe_provider.dart';

class ListItemCart extends StatefulWidget {
  final Shoe cart;
  final int index;

  const ListItemCart({
    super.key,
    required this.cart,
    required this.index,
  });

  @override
  State<ListItemCart> createState() => _ListItemCartState();
}

class _ListItemCartState extends State<ListItemCart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    String? colorShoe = widget.cart.color?.substring(1);
    final shoeProvider = Provider.of<ShoeProvider>(context, listen: false);
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _animationController.value,
            child: Transform.scale(
              scale: _animationController.value,
              child: child,
            ),
          );
        },
        child: Stack(
          children: [
            Positioned(
              top: 10,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: Color(int.parse('0xFF${colorShoe!}')),
                    shape: BoxShape.circle),
              ),
            ),
            Transform.rotate(
                angle: -pi / 7,
                origin: const Offset(-110, 50),
                child: Image.network(
                  "${widget.cart.image}",
                  height: 150,
                  width: 150,
                )),
            Positioned(
              left: 110,
              right: 0,
              top: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cart.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'Rubik-Bold',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "\$${widget.cart.price}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Rubik-Bold',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFe1e7ed).withOpacity(0.7),
                            shape: const CircleBorder(
                              side: BorderSide.none,
                            ),
                          ),
                          onPressed: () {
                            if (widget.cart.number == 1) {
                              _animationController.reverse().then((_) {
                                shoeProvider.removeShoeInCart(widget.index);
                                _animationController.value = 1;
                              });
                            } else {
                              shoeProvider.updateNumber(widget.index,
                                  widget.cart.number! - 1, widget.cart.id);
                            }
                          },
                          child: Image.asset(
                            'assets/images/minus.png',
                            height: 7,
                            width: 7,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '${widget.cart.number}',
                          style: const TextStyle(
                              fontSize: 14, fontFamily: 'Rubik-Light'),
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFe1e7ed).withOpacity(0.7),
                            shape: const CircleBorder(
                              side: BorderSide.none,
                            ),
                          ),
                          onPressed: () {
                            shoeProvider.updateNumber(widget.index,
                                widget.cart.number! + 1, widget.cart.id);
                          },
                          child: Image.asset(
                            'assets/images/plus.png',
                            height: 7,
                            width: 7,
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.colorYellow,
                            shape: const CircleBorder(
                              side: BorderSide.none,
                            ),
                          ),
                          onPressed: () {
                            _animationController.reverse().then((_) {
                              shoeProvider.removeShoeInCart(widget.index);
                              _animationController.value = 1;
                            });
                          },
                          child: Image.asset(
                            'assets/images/trash.png',
                            height: 15,
                            width: 15,
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
