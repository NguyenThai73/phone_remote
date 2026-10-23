import 'package:flutter/material.dart';
import '../data/mock_products.dart';
import '../models/product.dart';
import '../state/shop_store.dart';
import '../theme/app_theme.dart';
import '../widgets/product_card.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({
    super.key,
    required this.store,
    required this.onProduct,
    required this.initialBrand,
  });
  final ShopStore store;
  final ValueChanged<Product> onProduct;
  final String initialBrand;
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String query = '';
  late String brand = widget.initialBrand;
  String sort = 'Nổi bật';

  @override
  Widget build(BuildContext context) {
    final products = mockProducts
        .where(
          (product) =>
              (brand == 'Tất cả' || product.brand == brand) &&
              ('${product.name} ${product.brand}'.toLowerCase().contains(
                query.toLowerCase(),
              )),
        )
        .toList();
    if (sort == 'Giá tăng dần') {
      products.sort((a, b) => a.price.compareTo(b.price));
    }
    if (sort == 'Giá giảm dần') {
      products.sort((a, b) => b.price.compareTo(a.price));
    }

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Khám phá',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 5),
                const Text(
                  'Chọn thiết bị hợp với phong cách của bạn',
                  style: TextStyle(color: AppColors.muted),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) => setState(() => query = value),
                  decoration: InputDecoration(
                    hintText: 'Tìm tên điện thoại, thương hiệu...',
                    prefixIcon: const Icon(Icons.search_rounded),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppColors.line),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppColors.line),
                    ),
                  ),
                ),
                const SizedBox(height: 17),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                for (final item in [
                  'Tất cả',
                  'Apple',
                  'Samsung',
                  'Xiaomi',
                  'OPPO',
                  'Google',
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(item),
                      selected: brand == item,
                      onSelected: (_) => setState(() => brand = item),
                      selectedColor: AppColors.ink,
                      backgroundColor: Colors.white,
                      showCheckmark: false,
                      labelStyle: TextStyle(
                        color: brand == item ? Colors.white : AppColors.ink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 17, 20, 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${products.length} sản phẩm',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                DropdownButton<String>(
                  value: sort,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  items: ['Nổi bật', 'Giá tăng dần', 'Giá giảm dần']
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => sort = value!),
                ),
              ],
            ),
          ),
          Expanded(
            child: products.isEmpty
                ? const Center(
                    child: Text(
                      'Không tìm thấy sản phẩm phù hợp.',
                      style: TextStyle(color: AppColors.muted),
                    ),
                  )
                : LayoutBuilder(
                    builder: (context, constraints) => GridView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: constraints.maxWidth > 650 ? 3 : 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        mainAxisExtent: 274,
                      ),
                      itemBuilder: (context, index) => ProductCard(
                        product: products[index],
                        store: widget.store,
                        onTap: () => widget.onProduct(products[index]),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
