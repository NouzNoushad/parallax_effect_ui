import 'dart:math';

import 'package:flutter/material.dart';

class ParallaxEffect extends StatefulWidget {
  const ParallaxEffect({super.key});

  @override
  State<ParallaxEffect> createState() => _ParallaxEffectState();
}

class _ParallaxEffectState extends State<ParallaxEffect> {
  List<Map<String, dynamic>> shoes = [
    {
      'title': 'air solstice qs',
      'image': 'nike1.png',
      'color': Colors.amber,
      'bg1': Colors.blue,
      'bg2': Colors.yellow,
      'price': 129,
    },
    {
      'title': 'air structure',
      'image': 'nike_shoe4.png',
      'color': Colors.pink,
      'bg1': Colors.red,
      'bg2': Colors.orange,
      'price': 128,
    },
    {
      'title': 'air huarache',
      'image': 'nike_air.png',
      'color': Colors.green,
      'bg1': Colors.lightBlue,
      'bg2': Colors.lime,
      'price': 130,
    },
  ];

  // parallax effect
  late PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    pageController = PageController(viewportFraction: 1);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 153, 1, 180),
      body: PageView.builder(
          controller: pageController,
          physics: const BouncingScrollPhysics(),
          itemCount: shoes.length,
          itemBuilder: (context, index) {
            return ParallaxContainer(
              shoe: shoes[index],
              offset: pageOffset - index,
            );
          }),
    );
  }
}

class ParallaxContainer extends StatelessWidget {
  final double offset;
  final Map<String, dynamic> shoe;
  const ParallaxContainer(
      {super.key, required this.shoe, required this.offset});

  @override
  Widget build(BuildContext context) {
    // trick is in here
    double gauss = exp(-(pow(offset.abs() - 0.5, 2) / 0.08));
    return Stack(
      children: [
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: CardItem(
                  offset: gauss,
                  shoe: shoe,
                ),
              ),
            ),
          ),
        ),
        Positioned(
            bottom: MediaQuery.of(context).size.height / 4.5,
            left: 0,
            child: Transform.translate(
              offset: Offset(50 * offset, 0),
              child: Transform(
                transform: Matrix4.rotationZ(6),
                child: Image.asset(
                  'assets/${shoe['image']}',
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
              ),
            ))
      ],
    );
  }
}

class CardItem extends StatelessWidget {
  final double offset;
  final Map<String, dynamic> shoe;
  const CardItem({super.key, required this.shoe, required this.offset});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      shoe['bg1'],
                      shoe['bg2'],
                    ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Transform.translate(
                  offset: Offset(50 * offset, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/Nike.png',
                        width: 40,
                        color: Colors.white,
                      ),
                      Text(
                        '\$${shoe['price']}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(50 * offset, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shoe['title'].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'The Nike Air Solstice draws inspiration from the smooth classic running shoes of the 1980 updating the style with premium materials and impressive production quality',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Air'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 160,
                    fontWeight: FontWeight.bold,
                    color: Colors.black26,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: Transform.translate(
              offset: Offset(50 * offset, 0),
              child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
              Container(
                width: 200,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: shoe['color']),
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(50, 50))),
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Wish List'.toUpperCase(),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: shoe['color'],
                      ),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'mens shoe'.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              )
                      ],
                    ),
            )),
      ],
    );
  }
}
