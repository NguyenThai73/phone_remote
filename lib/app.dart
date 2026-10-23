import 'package:flutter/material.dart';
import 'screens/cart_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/detail_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'models/product.dart';
import 'state/shop_store.dart';
import 'theme/app_theme.dart';

class PhoneStoreApp extends StatelessWidget {
  const PhoneStoreApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'MobiZone',
    debugShowCheckedModeBanner: false,
    theme: buildTheme(),
    home: const ShopShell(),
  );
}

class ShopShell extends StatefulWidget {
  const ShopShell({super.key});
  @override
  State<ShopShell> createState() => _ShopShellState();
}

class _ShopShellState extends State<ShopShell> {
  final ShopStore store = ShopStore();
  int currentIndex = 0;
  int catalogVersion = 0;
  String selectedBrand = 'Tất cả';

  void openCatalog([String brand = 'Tất cả']) {
    setState(() {
      selectedBrand = brand;
      catalogVersion++;
      currentIndex = 1;
    });
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  void openProduct(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DetailScreen(
          product: product,
          store: store,
          onCart: () {
            Navigator.of(context).pop();
            setState(() => currentIndex = 2);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        store: store,
        onProduct: openProduct,
        onCatalog: openCatalog,
        onBrand: openCatalog,
      ),
      CatalogScreen(
        key: ValueKey(catalogVersion),
        store: store,
        onProduct: openProduct,
        initialBrand: selectedBrand,
      ),
      CartScreen(store: store, onExplore: openCatalog),
      ProfileScreen(store: store),
    ];
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: AnimatedBuilder(
        animation: store,
        builder: (context, _) => NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) =>
              setState(() => currentIndex = index),
          backgroundColor: Colors.white,
          indicatorColor: AppColors.orange.withValues(alpha: .12),
          height: 68,
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'Trang chủ',
            ),
            const NavigationDestination(
              icon: Icon(Icons.grid_view_outlined),
              selectedIcon: Icon(Icons.grid_view_rounded),
              label: 'Sản phẩm',
            ),
            NavigationDestination(
              icon: Badge(
                isLabelVisible: store.cartCount > 0,
                label: Text('${store.cartCount}'),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
              selectedIcon: const Icon(Icons.shopping_bag_rounded),
              label: 'Giỏ hàng',
            ),
            const NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon: Icon(Icons.person_rounded),
              label: 'Tài khoản',
            ),
          ],
        ),
      ),
    );
  }
}
