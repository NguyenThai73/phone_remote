import 'package:flutter/material.dart';
import '../data/mock_products.dart';
import '../models/product.dart';
import '../state/shop_store.dart';
import '../theme/app_theme.dart';
import '../widgets/phone_art.dart';
import '../widgets/product_card.dart';
import '../widgets/section_heading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.store,
    required this.onProduct,
    required this.onCatalog,
    required this.onBrand,
  });
  final ShopStore store;
  final ValueChanged<Product> onProduct;
  final VoidCallback onCatalog;
  final ValueChanged<String> onBrand;

  @override
  Widget build(BuildContext context) => SafeArea(
    child: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.orange,
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: const Icon(
                        Icons.phone_iphone_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'mobizone.',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w900,
                          color: AppColors.ink,
                          letterSpacing: -1.2,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onCatalog,
                      icon: const Icon(Icons.search_rounded, size: 27),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Xin chào 👋',
                  style: TextStyle(color: AppColors.muted, fontSize: 14),
                ),
                const SizedBox(height: 3),
                Text(
                  'Tìm chiếc điện thoại\ndành riêng cho bạn.',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: onCatalog,
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.line),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search_rounded, color: AppColors.muted),
                        SizedBox(width: 10),
                        Text(
                          'Tìm điện thoại bạn yêu thích...',
                          style: TextStyle(color: AppColors.muted),
                        ),
                        Spacer(),
                        Icon(Icons.tune_rounded, color: AppColors.orange),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () => onProduct(mockProducts.first),
                  child: Container(
                    height: 205,
                    padding: const EdgeInsets.fromLTRB(20, 22, 0, 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF202936), Color(0xFF455362)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'MỚI RA MẮT',
                                style: TextStyle(
                                  color: Color(0xFFFFB995),
                                  fontSize: 11,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 9),
                              const Text(
                                'iPhone 16 Pro',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Sức mạnh trong tầm tay',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 13,
                                  vertical: 9,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.orange,
                                  borderRadius: BorderRadius.circular(9),
                                ),
                                child: const Text(
                                  'Khám phá ngay  →',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 138,
                          child: PhoneArt(
                            product: mockProducts.first,
                            size: 174,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                SectionHeading(
                  title: 'Thương hiệu',
                  action: 'Xem tất cả',
                  onAction: onCatalog,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 75,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (final brand in [
                        'Apple',
                        'Samsung',
                        'Xiaomi',
                        'OPPO',
                        'Google',
                      ])
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: InkWell(
                            onTap: () => onBrand(brand),
                            child: Container(
                              width: 82,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: AppColors.line),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _brandIcon(brand),
                                    color: AppColors.ink,
                                    size: 25,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    brand,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SectionHeading(
                  title: 'Nổi bật hôm nay',
                  action: 'Xem tất cả',
                  onAction: onCatalog,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 26),
          sliver: SliverLayoutBuilder(
            builder: (context, constraints) => SliverGrid.builder(
              itemCount: 4,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: constraints.crossAxisExtent > 650 ? 3 : 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                mainAxisExtent: 274,
              ),
              itemBuilder: (context, index) => ProductCard(
                product: mockProducts[index],
                store: store,
                onTap: () => onProduct(mockProducts[index]),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  IconData _brandIcon(String brand) => switch (brand) {
    'Apple' => Icons.apple_rounded,
    'Samsung' => Icons.smartphone_rounded,
    'Xiaomi' => Icons.bolt_rounded,
    'OPPO' => Icons.camera_alt_outlined,
    _ => Icons.g_mobiledata_rounded,
  };
}
