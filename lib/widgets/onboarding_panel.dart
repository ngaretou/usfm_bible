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
        width: 600,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
            // image:
            //     DecorationImage(image: AssetImage('images/linkbutton.png')),
            borderRadius: BorderRadius.circular(12),
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
        child: image,
        // width: 400,
      );
    }

    Widget pageTemplate(Widget top, Widget bottom, {Widget? button}) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 5, child: top),
          const SizedBox(height: 30),
          Expanded(flex: 0, child: bottom),
          Expanded(flex: 0, child: button ?? const SizedBox(height: 10))
        ],
      );
    }

    List<Widget> pages = [
      pageTemplate(
          imageWithShadow(
              const Image(image: AssetImage('images/menu.png')), true),
          // Image(image: AssetImage('images/linkbutton.png')),
          const Text(
            'Bësal ci ñeeti ponk yi ngir ubbi fi nga man tànn ay jumtukaay.',
            style: TextStyle(color: Colors.black),
          )),
      pageTemplate(
          imageWithShadow(
              const Image(image: AssetImage('images/linkbutton.png')), true),
          // Image(image: AssetImage('images/linkbutton.png')),
          const Text(
            'Bu button bi tàkke, kon mungiy ànd ak yeneen mbind yi. Bu tàkkul nag, day dox moom kenn.',
            style: TextStyle(color: Colors.black),
          )),
      // pageTemplate(
      //     Container(
      //       color: Colors.red,
      //       width: 400,
      //       height: 100,
      //     ),
      //     Text(
      //       '2',
      //       style: TextStyle(color: Colors.black),
      //     )),
    ];

    if (PWAInstall().installPromptEnabled) {
      pages.add(
        pageTemplate(
          imageWithShadow(
              const Image(image: AssetImage('images/screenshot.png')), false),
          const Text(
            'Man nga installer appli ci sa ordinateur. Bësal ci button bi ngir tambale installation bi.',
            style: TextStyle(color: Colors.black),
          ),
          button: IconButton(
              icon: Icon(
                FluentIcons.installation,
                color: Colors.teal,
                size: 30,
              ),
              onPressed: () => PWAInstall().promptInstall_()),
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

    void closePanelSavePref() {
      Navigator.of(context).pop();
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
                onPressed: closePanelSavePref,
              ),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                if (currentPage != 0)
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
                if (currentPage != pages.length)
                  IconButton(
                      icon: const Icon(
                        FluentIcons.caret_solid_right,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: nextPage),
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
