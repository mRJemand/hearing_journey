import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:hearing_journey/models/tip.dart';

class TippDetailWidget extends StatelessWidget {
  final Tip currentTip;

  const TippDetailWidget({
    required this.currentTip,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          currentTip.image,
          height: 250,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            currentTip.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        Accordion(
          scaleWhenAnimating: true,
          openAndCloseAnimation: true,
          headerBackgroundColorOpened: Colors.red,
          headerBackgroundColor: Colors.red.shade200,
          contentBorderColor: Colors.red,
          maxOpenSections: 3,
          children: [
            AccordionSection(
              isOpen: true,

              // contentVerticalPadding: 200,
              leftIcon: const Icon(Icons.sports_score, color: Colors.white),
              headerPadding: const EdgeInsets.all(8 - 0),
              header: const Text(
                'Ziel',
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              content: Text(currentTip.goal,
                  style: const TextStyle(
                      //  color: Color(0xff999999),
                      fontSize: 14,
                      fontWeight: FontWeight.normal)),
            ),
            AccordionSection(
              isOpen: true,

              // contentVerticalPadding: 200,
              leftIcon: const Icon(Icons.tips_and_updates, color: Colors.white),
              headerPadding: EdgeInsets.all(8 - 0),
              header: const Text(
                'Tipp',
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              content: Text(currentTip.tipp,
                  style: const TextStyle(
                      //  color: Color(0xff999999),
                      fontSize: 14,
                      fontWeight: FontWeight.normal)),
            ),
            AccordionSection(
              isOpen: false,

              // contentVerticalPadding: 200,
              leftIcon: const Icon(Icons.description, color: Colors.white),
              headerPadding: EdgeInsets.all(8 - 0),
              header: const Text(
                'Erklärung',
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              content: Text(currentTip.description,
                  style: const TextStyle(
                      //  color: Color(0xff999999),
                      fontSize: 14,
                      fontWeight: FontWeight.normal)),
            ),
          ],
        ),
      ],
    );
  }
}
