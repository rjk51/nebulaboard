import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:nebulaboard/theme/theme.dart';

class IntroScreens extends StatelessWidget {
  final Function() onDone;

  const IntroScreens({super.key, required this.onDone});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        // Screen 1: What is NebulaBoard?
        PageViewModel(
          title: "Turn Stories into Storyboards",
          body: "Upload your script or story, and let AI generate stunning visuals in seconds.",
          image: Center(
            child: Icon(Icons.auto_awesome, size: 120, color: NebulaBoardTheme.secondaryColor),
          ),
          decoration: _pageDecoration(),
        ),

        // Screen 2: How it works
        PageViewModel(
          title: "AI-Powered Art",
          body: "NebulaBoard uses Flux Schnell/SDXL to create unique, style-consistent frames.",
          image: Center(
            child: Icon(Icons.art_track, size: 120, color: NebulaBoardTheme.primaryColor),
          ),
          decoration: _pageDecoration(),
        ),

        // Screen 3: Get Started
        PageViewModel(
          title: "Ready to Create?",
          body: "Start prototyping your film, game, or comic ideas today!",
          image: Center(
            child: Icon(Icons.rocket_launch, size: 120, color: Colors.white),
          ),
          decoration: _pageDecoration(),
        ),
      ],
      onDone: onDone,
      showSkipButton: true,
      skip: const Text("Skip", style: TextStyle(color: NebulaBoardTheme.secondaryText)),
      next: const Icon(Icons.arrow_forward, color: NebulaBoardTheme.primaryColor),
      done: const Text("Start", style: TextStyle(fontWeight: FontWeight.bold, color: NebulaBoardTheme.primaryColor)),
      dotsDecorator: DotsDecorator(
        size: const Size(10, 10),
        color: NebulaBoardTheme.secondaryText,
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        activeColor: NebulaBoardTheme.primaryColor,
      ),
      globalBackgroundColor: NebulaBoardTheme.backgroundColor,
    );
  }

  // Shared page styling
  PageDecoration _pageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: NebulaBoardTheme.primaryText,
        fontFamily: 'Chelsea Market',
      ),
      bodyTextStyle: TextStyle(
        fontSize: 16,
        color: NebulaBoardTheme.secondaryText,
      ),
      imagePadding: EdgeInsets.only(top: 40),
      pageColor: NebulaBoardTheme.backgroundColor,
    );
  }
}