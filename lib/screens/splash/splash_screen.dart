import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:krishak_farma/MobileAuth/mobile_register.dart';
import 'package:krishak_farma/screens/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../size_config.dart';
import 'dart:async';
import 'dart:math';
import 'dart:math' as math;
import 'dart:ui' as UI;
import 'package:flutter/services.dart';
class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 2000));
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '';
    print("-------------------------------------");
    print(data);

    // Check if the user is already signed in
    User? user = _auth.currentUser;
    if (data != '') {
      // User is signed in, navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()), // Replace HomeScreen with the actual home screen
      );
    } else {
      // User is not signed in, navigate to RegisterScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RegisterScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Material(
      color: Colors.white, // Set the background color here
      child: GestureDetector(
        onTap: () {
          // Handle tap by navigating to the appropriate screen
          _navigateToHome();
        },
        child: Scaffold(
          backgroundColor:Colors.white,
          body: Stack(
            children: <Widget>[
              Center(
                  child: WidgetRingAnimator(
                    size: 120,
                    ringIcons: const [
                      'assets/store.png',
                      'assets/product.png',
                      'assets/cart.png',
                      'assets/rupee.png',
                      'assets/delivery.png',
                    ],
                    ringIconsSize: 3,
                    ringIconsColor: Colors.deepOrangeAccent??Colors.deepOrangeAccent,
                    ringAnimation: Curves.linear,
                    ringColor: Colors.green,
                    reverse: false,
                    ringAnimationInSeconds: 10,
                    child: Container(
                      child: Material(
                        elevation: 8.0,
                        shape: CircleBorder(),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                            'assets/Agri_safe_logo_b.png',
                            
                            height: 65,
                          ),
                          radius: 45.0,
                        ),
                      ),
                    ),
                  )
              ),
              Center(
                child: AvatarGlow(
                  glowColor: Color(0xFFFFECDF),
                  endRadius: 200.0,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  child: Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        'assets/Agri_safe_logo_b.png',
                        
                        height: 65,
                      ),
                      radius: 45.0,
                    ),
                  ),
                ),
              ),

            ],
          )),
      ),
    );
  }
}



class WidgetRingAnimator extends StatefulWidget {
  const WidgetRingAnimator({
    required this.child,
    this.ringColor = Colors.deepOrange,
    this.ringAnimation = Curves.linear,
    this.ringAnimationInSeconds = 30,
    this.ringIconsSize = 3,
    this.size = 200,
    this.reverse = true,
    required this.ringIcons,
    this.ringIconsColor = Colors.deepOrange
  }) : assert(child != null);

  final Color ringColor;
  final Curve ringAnimation;
  final int ringAnimationInSeconds;
  final List<String> ringIcons;
  final Color ringIconsColor;
  final double ringIconsSize;
  final double size;
  final Widget child;
  final bool reverse;

  @override
  _WidgetAnimatorState createState() => _WidgetAnimatorState();
}

class _WidgetAnimatorState extends State<WidgetRingAnimator>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  List<UI.Image> image = <UI.Image>[];

  @override
  void initState() {
    super.initState();
    initAnimations();
    initUiImages();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          _ringArc(),
          _child(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Center _child() {
    return Center(
      child: Container(
        width: widget.size * 0.7,
        height: widget.size * 0.7,
        child: widget.child,
      ),
    );
  }

  Center _ringArc() {
    return Center(
      child: RotationTransition(
        turns: animation,
        child: CustomPaint(
          painter: Arc2Painter(
              color: widget.ringColor,
              iconsSize: widget.ringIconsSize,
              image: image,
              imageColor: widget.ringIconsColor),
          child: Container(
            width: widget.size,
            height: widget.size,
          ),
        ),
      ),
    );
  }

  Future _loadUiImage(String imageAssetPath) async {
    final data = await rootBundle.load(imageAssetPath);
    final bytes = data.buffer.asUint8List();
    final decodeImage = await decodeImageFromList(bytes);
    image.add(decodeImage);

    setState(() {
      image = image;
    });
  }

  void initUiImages() async {
    for (var imageAssetPath in widget.ringIcons) {
      await _loadUiImage(imageAssetPath);
    }
  }

  void initAnimations() {
    controller = AnimationController(
        duration: Duration(seconds: widget.ringAnimationInSeconds),
        vsync: this);

    final _ringAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 1.0, curve: widget.ringAnimation)));

    // reverse or same direction animation
    widget.reverse
        ? animation = ReverseAnimation(_ringAnimation)
        : animation = _ringAnimation;

    controller.repeat();
  }
}

class Arc2Painter extends CustomPainter {
  Arc2Painter({required this.color, this.iconsSize = 3, required this.image, required this.imageColor});

  final Color color;
  final double iconsSize;
  final List<UI.Image> image;
  final Color imageColor;


  @override
  Future<void> paint(Canvas canvas, Size size) async {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final ColorFilter filter = ColorFilter.mode(imageColor, BlendMode.srcATop);

    num degreesToRads(num deg) {
      return deg * (pi / 180.0);
    }

    // draw the ring arcs with imagesIcons
    final Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final Offset center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final noOfImages = image.length;
    final arcAngle = 360 / noOfImages;

    for (var i = 0; i < noOfImages; i++) {
      final radians = degreesToRads(i * arcAngle).toDouble();
      final Offset pointOnArc = Offset(
        radius * math.cos(radians) + center.dx,
        radius * math.sin(radians) + center.dy,
      );
      canvas.drawImage(
          image[i],
          pointOnArc + Offset(-(image[i].width / 2).toDouble(), -(image[i].height / 2).toDouble()),
          Paint()..colorFilter = filter);
      canvas.drawArc(
          rect,
          degreesToRads((i * arcAngle) + image[i].width / 2).toDouble(), //startAngle
          degreesToRads(arcAngle - image[i].width).toDouble(),  //sweepAngle
          false, p);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}