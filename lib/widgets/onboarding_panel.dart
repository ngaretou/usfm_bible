import 'package:fluent_ui/fluent_ui.dart';
import 'package:pwa_install/pwa_install.dart';

class OnboardingPanel extends StatefulWidget {
  const OnboardingPanel({super.key});

  @override
  State<OnboardingPanel> createState() => _OnboardingPanelState();
}

class _OnboardingPanelState extends State<OnboardingPanel> {
  late PageController pageController;
  int currentPage = 0;
  late MediaQueryData mediaQuery;
  late bool isPhone;
  late bool isLandscape;
  late EdgeInsets cardPadding;
  late int value;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWithShadow(Image image, bool showShadow) {
      return Container(
        // padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(12),
            boxShadow: [
              if (showShadow)
                BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 5,
                  // spreadRadius: 00,
                  blurStyle: BlurStyle.outer,
                  color: Colors.black.withOpacity(0.3),
                )
            ]),
        height: image.height,
        child: image,
      );
    }

    Widget pageTemplate(Widget top, Widget bottom, {Widget? button}) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 1, child: top),
          const SizedBox(height: 20),
          bottom,
          const SizedBox(height: 20),
          if (button != null) button,
          if (button != null) const SizedBox(height: 20),
        ],
      );
    }

    List<Widget> pages = [
      pageTemplate(
          imageWithShadow(
              const Image(image: AssetImage('assets/images/menu.png')), true),
          const Text(
            'Bësal ci ñeeti ponk yi ngir ubbi fi nga man tànn ay jumtukaay.',
            style: TextStyle(color: Colors.black),
          )),
      pageTemplate(
        imageWithShadow(
            const Image(image: AssetImage('assets/images/book_selection.png')),
            true),
        const Text(
          'Ci xaaj bu nekk man nga tànn ban làkk nga bëgg gis.',
          style: TextStyle(color: Colors.black),
        ),
      ),
      pageTemplate(
        imageWithShadow(
            const Image(
                image: AssetImage('assets/images/bible_book_selection.png')),
            true),
        const Text(
          'Fii ngay tànn ban téere nga bëgg jàng.',
          style: TextStyle(color: Colors.black),
        ),
      ),
      pageTemplate(
        imageWithShadow(
            const Image(image: AssetImage('assets/images/ch_vs_selection.png')),
            true),
        const Text(
          'Fii ngay gis ban saar ak aaya ñooy feeñ.',
          style: TextStyle(color: Colors.black),
        ),
      ),
      pageTemplate(
        imageWithShadow(
            const Image(image: AssetImage('assets/images/font_size.png')),
            true),
        const Text(
          'Man nga soppi dayob mbind mi.',
          style: TextStyle(color: Colors.black),
        ),
      ),
      pageTemplate(
        imageWithShadow(
            const Image(image: AssetImage('assets/images/link_button.png')),
            true),
        const Text(
          'Bu button bi takke, xaaj bi day ànd ak yeneen xaaj yi.',
          style: TextStyle(color: Colors.black),
        ),
      ),
    ];

    if (PWAInstall().installPromptEnabled) {
      pages.add(
        pageTemplate(
          imageWithShadow(
              const Image(image: AssetImage('assets/images/screenshot.png')),
              true),
          const Text(
            'Man nga installer appli bi ci sa ordinateur. Bësal ci button bi ngir tambale installation bi.',
            style: TextStyle(color: Colors.black),
          ),
          button: GestureDetector(
              child: Card(
                backgroundColor: Colors.teal,
                child: const Text('Installation'),
              ),
              onTap: () {
                Navigator.of(context).pop();
                try {
                  PWAInstall().promptInstall_();
                } catch (e) {
                  print(e);
                }
              }),
        ),
      );
    }

    final int totalPages = pages.length;

    const Duration pageTurnDuration = Duration(milliseconds: 200);

    void previousPage() {
      pageController.previousPage(
          duration: pageTurnDuration, curve: Curves.linear);
    }

    void nextPage() {
      pageController.nextPage(duration: pageTurnDuration, curve: Curves.linear);
    }

    return Container(
      height: 500,
      width: 700,
      decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(FluentIcons.chrome_close, color: Colors.black),
                onPressed: Navigator.of(context).pop,
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                IconButton(
                    icon: const Icon(
                      FluentIcons.caret_solid_left,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: previousPage),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        currentPage = page;
                      });
                    },
                    children: pages,
                  ),
                ),
                IconButton(
                    icon: const Icon(
                      FluentIcons.caret_solid_right,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      if (currentPage + 1 == pages.length) {
                        Navigator.of(context).pop();
                      } else {
                        nextPage();
                      }
                    }),
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            for (int i = 0; i < totalPages; i++)
              i == currentPage
                  ? buildPageIndicator(true)
                  : buildPageIndicator(false)
          ]),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  Widget buildPageIndicator(bool isCurrentPage) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      height: isCurrentPage ? 18.0 : 10.0,
      width: isCurrentPage ? 18.0 : 10.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.teal : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}