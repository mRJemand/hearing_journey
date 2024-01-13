import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:hearing_journey/models/tip.dart';

class TippDetailWidget extends StatelessWidget {
  final Tip currentTip;
  final bool isNextTipAvailable;
  final bool isPreviousTipAvailable;
  final VoidCallback nextTip;
  final VoidCallback previousTip;

  const TippDetailWidget({
    required this.currentTip,
    required this.isNextTipAvailable,
    required this.isPreviousTipAvailable,
    required this.nextTip,
    required this.previousTip,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Image.asset(
              'assets/${currentTip.image}',
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            // Linker Button mit Hintergrund
            isPreviousTipAvailable
                ? Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    child: Container(
                      color: Colors.black.withOpacity(
                          0.5), // Transparenter schwarzer Hintergrund
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => previousTip(),
                      ),
                    ),
                  )
                : Container(),

            // Rechter Button mit Hintergrund
            isNextTipAvailable
                ? Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      color: Colors.black.withOpacity(
                          0.5), // Transparenter schwarzer Hintergrund
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward, color: Colors.white),
                        onPressed: () => nextTip(),
                        // Fügen Sie hier Ihre next() Logik ein
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              currentTip.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
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
              content: Align(
                alignment: Alignment.centerLeft,
                child: Text(currentTip.goal,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        //  color: Color(0xff999999),
                        fontSize: 14,
                        fontWeight: FontWeight.normal)),
              ),
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
              content: Align(
                alignment: Alignment.centerLeft,
                child: Text(currentTip.tipp,
                    style: const TextStyle(
                        //  color: Color(0xff999999),
                        fontSize: 14,
                        fontWeight: FontWeight.normal)),
              ),
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
              content: Align(
                alignment: Alignment.centerLeft,
                child: Text(currentTip.description,
                    style: const TextStyle(
                        //  color: Color(0xff999999),
                        fontSize: 14,
                        fontWeight: FontWeight.normal)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
