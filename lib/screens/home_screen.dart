import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:provider/provider.dart';
import 'package:shoeshop_flutter/constants.dart';
import 'package:shoeshop_flutter/providers/cart_provider.dart';
import 'package:shoeshop_flutter/providers/shoe_provider.dart';
import 'package:shoeshop_flutter/screens/widget/cart_widget.dart';
import 'package:shoeshop_flutter/screens/widget/custom_pain.dart';
import 'package:shoeshop_flutter/screens/widget/shop_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  final Tween<double> _upDownTween =
      Tween<double>(begin: 0.0, end: 50.0); // Adjust end value as needed
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // Adjust duration as needed
      reverseDuration: Duration(seconds: 2),
    )..repeat(reverse: true); // Loop the animation
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // var box = await Hive.openBox<Shoe>('shoeBox');
      // box.clear();
      Provider.of<ShoeProvider>(context, listen: false)
          .getAllProductsServerandSaveLocal();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: AppColor.colorWhite,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              double offset = _upDownTween.evaluate(_animationController);
              return CustomPaint(
                size: Size(size.width,
                    size.height + offset), // Adjust size calculation if needed
                painter: RPSCustomPainter(
                    offset: offset), // Pass the offset to the painter
              );
            },
          ),
          SingleChildScrollView(
            child: size.width < 800
                ? const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                      child: Column(
                        children: [
                          ShopWidget(),
                          SizedBox(
                            height: 40,
                          ),
                          CartWidget()
                        ],
                      ),
                    ),
                  )
                : const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShopWidget(),
                        SizedBox(
                          width: 40,
                        ),
                        CartWidget()
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
