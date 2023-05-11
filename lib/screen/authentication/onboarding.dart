import 'package:flutter/material.dart';
import 'package:hiro_app/model/index.dart';
import 'package:hiro_app/services/post/index.dart';
import 'package:hiro_app/theme/index.dart';
import 'package:hiro_app/widget/button.dart';
import 'package:hiro_app/widget/carousel.dart';
import 'package:hiro_app/widget/image.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<Carousel> _banners = [
    Carousel(
        image: 'assets/image_banner1.png',
        title: 'WELCOME TO HIRO LOYALTY MEMBERSHIP',
        subtitle: ''),
    Carousel(
        image: 'assets/image_banner2.png',
        title: 'EXCITING OFFER FOR HIRO MEMBERS',
        subtitle: 'Get special offer on all our brands'),
    Carousel(
        image: 'assets/image_banner3.png',
        title: 'SPECIAL BENEFIT',
        subtitle:
            'Collect your points & updgrade your tier to get exclusive treatment on all our brands'),
  ];

  @override
  void initState() {
    super.initState();
    // TODO: Implement logic to check if user is already logged in
  }

  void test() {
    postReqAuthToken(context: context).catchError((onError) {
      print('object');
      print(onError.toString());
    });
  }

  Widget _buildContent() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        AntiCarousel(
            viewportFraction: 1.0,
            aspectRatio: 16 / 10,
            passiveIndicator: Colors.white.withOpacity(0.5), //Colour.white.withOpacity(0.5),
            activeIndicator: Colors.white,
            height: height,
            pagerHeight: 4,
            pagerWidth: 28,
            activePagerHeight: 4,
            activePagerWidth: 28,
            pagerMarginBottom: height * 0.13,
            position: MainAxisAlignment.start,
            hasPagination: true,
            items: _banners.map((banner) {
              return Stack(
                children: <Widget>[
                  AntiImage(
                    imageUrl: banner.image!,
                    height: height,
                    width: width,
                  ),
                  AntiImage(
                    imageUrl: 'assets/onboarding_overlay.png',
                    height: height,
                    width: width,
                  ),
                  Container(
                    height: height,
                    width: width,
                    margin: const EdgeInsets.only(bottom: 32.0, left: 16.0, right: 16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          banner.title!,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        Text(banner.subtitle!,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white)),
                        SizedBox(
                          height: height * 0.13,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList()),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: AntiButton(
              loading: false,
              text: 'Get Started'.toUpperCase(),
              textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: hiroSwatch),
              onPressed: () => {
                test()
                // Navigator.pushNamed(context, '/login')
              },
              backgroundColor: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildContent());
  }
}
