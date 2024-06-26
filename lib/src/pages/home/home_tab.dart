import 'package:flutter/material.dart';
import 'package:fruittrace/src/config/custom_colors.dart';
import 'package:fruittrace/src/models/item_model.dart';
import 'package:fruittrace/src/pages/home/components/category_tile.dart';
import 'package:fruittrace/src/config/app_data.dart' as app_data;
import 'package:fruittrace/src/pages/home/components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  String selectedCategory = 'Cítricas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
        backgroundColor: CustomColors.customSwatchColor[100],
        centerTitle: true,
        title: const Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 25.0,
              shadows: [
                Shadow(
                  color: Color.fromARGB(255, 68, 67, 67),
                  offset: Offset(2.0, 2.0),
                  blurRadius: 6.0
                ),
            ]
            ),
            children: [
              TextSpan(
                text: 'Fruit',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: 'Trace',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        
        // add carrinho com quantidade
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0, right: 15.0),
            child: GestureDetector(
              onTap: () {
                print('teste badge carrinho');
              },
              child: Badge(
                backgroundColor: Colors.red,
                label: Text(
                  app_data.cartItems.length.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: CustomColors.customSwatchColor,
                ),
              ),
            ),
          ),
        ],
      ),

      body: Column(
        children: [
          // Campo de pesquisa
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                hintText: 'Pesquise aqui...',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                prefixIcon: Icon(Icons.search, color: CustomColors.customContrastColor, size: 21),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  )
                ),
              ),
            ),
          ),
          
          // Categorias
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            height: 40.0,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => CategoryTitle(
                category: app_data.categories[index],
                isSelected: app_data.categories[index] == selectedCategory,
                onPressed: () {
                  setState(() {
                    selectedCategory = app_data.categories[index];                  
                  });
                },
              ),
              separatorBuilder: (_, index) => const SizedBox(width: 10.0,),
              itemCount: app_data.categories.length,
            ),
          ),

          // Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 9 / 11.5,
              ),
              itemCount: app_data.items.where((item) => item.category == selectedCategory).length,
              itemBuilder: (_, index) {
                
                List<ItemModel> filteredItems = app_data.items.where((item) => item.category == selectedCategory).toList();

                return  ItemTile(
                  item: filteredItems[index],
                );
              },
            ),
          )          
        ],
      ),
    );
  }
}