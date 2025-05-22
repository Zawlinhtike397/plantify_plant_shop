import 'package:flutter/material.dart';
import 'package:plantshop_app/plant_data.dart';
import 'package:plantshop_app/screens/plant_details_screen.dart';
import 'package:plantshop_app/widgets/plant_card.dart';

class PlantGridView extends StatefulWidget {
  const PlantGridView({super.key});

  @override
  State<PlantGridView> createState() => _PlantGridViewState();
}

class _PlantGridViewState extends State<PlantGridView> {
  // var allItems = List.
  List<Map<String, Object>> plantItems = [];
  var searchHistory = [];
  final TextEditingController searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchTextController.addListener(queryListener);
  }

  @override
  void dispose() {
    searchTextController.removeListener(queryListener);
    searchTextController.dispose();
    super.dispose();
  }

  void queryListener() {
    search(searchTextController.text);
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        plantItems = plants;
      });
    } else {
      setState(() {
        plantItems = plants
            .where((plant) => (plant['name'] as String)
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(),
                Text(
                  'Search Products',
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                CircleAvatar(
                  backgroundImage: AssetImage('assets/image/femaleProfile.jpg'),
                  radius: 26,
                ),
              ],
            ),
          ),

          //Search Bar
          SearchBar(
            controller: searchTextController,
            hintText: 'Serach Plants',
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            leading: const Icon(Icons.search),
          ),
          if (searchTextController.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 9.0),
              child: Text(
                'Found ${plantItems.length} Result${plantItems.length > 1 ? 's' : ''}',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                textAlign: TextAlign.center,
              ),
            ),

          //Product Cards
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 840),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 240,
                    childAspectRatio: 0.62,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 12,
                  ),
                  itemCount:
                      plantItems.isEmpty ? plants.length : plantItems.length,
                  itemBuilder: (context, index) {
                    final plant =
                        plantItems.isEmpty ? plants[index] : plantItems[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PlantDetailsScreen(
                                plant: plant,
                              );
                            },
                          ),
                        );
                      },
                      child: PlantsCard(
                        image: (plant['imageUrl'] as List<String>)[0],
                        name: plant['name'] as String,
                        price: plant['price'] as double,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
