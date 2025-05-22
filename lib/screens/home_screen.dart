import 'package:flutter/material.dart';
import 'package:plantshop_app/screens/cart_screen.dart';
import 'package:plantshop_app/screens/favourite_screen.dart';
import 'package:plantshop_app/screens/profile_screen.dart';
import 'package:plantshop_app/widgets/plant_grid_view.dart';

// Photo by <a href="https://unsplash.com/@aiony?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Aiony Haust</a> on <a href="https://unsplash.com/photos/3TLl_97HNJo?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // I use pageView so that duplicateBottomNavBar error is gone but it is still the same So,
  // I have to reuse index stack again to maintain the state of my app for chat feature.

  // final PageController _pageViewController = PageController();
  int activePage = 0;

  List<Widget> pages = [
    const PlantGridView(),
    const CartScreen(),
    const FavouriteScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    bool isTablet = MediaQuery.sizeOf(context).width > 600;
    bool isDesktop = MediaQuery.sizeOf(context).width > 840;
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            if (isTablet)
              NavigationRail(
                unselectedLabelTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                selectedLabelTextStyle: const TextStyle(
                  color: Colors.white,
                ),
                labelType: isDesktop
                    ? NavigationRailLabelType.none
                    : NavigationRailLabelType.all,
                extended: isDesktop ? true : false,
                groupAlignment: 0.0,
                indicatorShape: const CircleBorder(),
                indicatorColor: Theme.of(context).colorScheme.primary,
                backgroundColor: const Color(
                  0xff161D0D,
                ),
                destinations: const [
                  NavigationRailDestination(
                    padding: EdgeInsets.all(1.0),
                    icon: Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                    ),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                    label: Text('Cart'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.white,
                    ),
                    label: Text('Favourites'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(
                      Icons.person_outline,
                      color: Colors.white,
                    ),
                    label: Text('Profile'),
                  ),
                ],
                selectedIndex: activePage,
                onDestinationSelected: (navRailValue) {
                  setState(() {
                    activePage = navRailValue;
                  });
                },
              ),
            Flexible(
              child: IndexedStack(
                index: activePage,
                children: pages,
              ),
            ),
          ],
        ),
        bottomNavigationBar: isTablet
            ? null
            : ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  elevation: 10.0,
                  onTap: (tappedIndex) {
                    setState(() {
                      activePage = tappedIndex;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (activePage == 0)
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                // Color.fromARGB(248, 95, 129, 37),
                                shape: BoxShape.circle,
                              ),
                            ),
                          const Icon(
                            Icons.home_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (activePage == 1)
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                // Color.fromARGB(248, 95, 129, 37),
                                shape: BoxShape.circle,
                              ),
                            ),
                          const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (activePage == 2)
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Stack(
                        alignment: Alignment.center,
                        children: [
                          if (activePage == 3)
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          const Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      label: '',
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
