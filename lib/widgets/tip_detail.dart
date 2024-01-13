import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:hearing_journey/models/tip.dart';
import 'package:hearing_journey/widgets/tip_category_item.dart';

class TippDetailWidget extends StatefulWidget {
  final Tip currentTip;
  final bool isNextTipAvailable;
  final bool isPreviousTipAvailable;
  final VoidCallback nextTip;
  final VoidCallback previousTip;
  final TipCategoryItem? tipCategoryItem;
  final List<Tip> allTips;
  int currentIndex;

  TippDetailWidget({
    required this.currentTip,
    required this.isNextTipAvailable,
    required this.isPreviousTipAvailable,
    required this.nextTip,
    required this.previousTip,
    required this.tipCategoryItem,
    required this.allTips,
    required this.currentIndex,
    super.key,
  });

  @override
  State<TippDetailWidget> createState() => _TippDetailWidgetState();
}

class _TippDetailWidgetState extends State<TippDetailWidget> {
  bool isNextTipAvailable() {
    return widget.currentIndex < widget.allTips!.length - 1;
  }

  void nextTip() {
    setState(() {
      if (isNextTipAvailable()) {
        widget.currentIndex++;
        widget.nextTip();
      }
    });
  }

  bool isPreviousTipAvailable() {
    return widget.currentIndex > 0;
  }

  void previousTip() {
    setState(() {
      if (isPreviousTipAvailable()) {
        widget.currentIndex--;
        widget.previousTip();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tipCategoryItem!.title),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/${widget.allTips[widget.currentIndex].image}',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              // Linker Button mit Hintergrund
              widget.currentIndex > 0
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
              widget.currentIndex < widget.allTips!.length - 1
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
                widget.allTips[widget.currentIndex].title,
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
                  child: Text(widget.allTips[widget.currentIndex].goal,
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
                leftIcon:
                    const Icon(Icons.tips_and_updates, color: Colors.white),
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
                  child: Text(widget.allTips[widget.currentIndex].tipp,
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
                  child: Text(widget.allTips[widget.currentIndex].description,
                      style: const TextStyle(
                          //  color: Color(0xff999999),
                          fontSize: 14,
                          fontWeight: FontWeight.normal)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
