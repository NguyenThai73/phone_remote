import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/shop_store.dart';
import '../theme/app_theme.dart';
import '../widgets/phone_art.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    super.key,
    required this.product,
    required this.store,
    required this.onCart,
  });
  final Product product;
  final ShopStore store;
  final VoidCallback onCart;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int colorIndex = 0;
  int quantity = 1;
  late String storage = widget.product.storage.first;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chi tiết sản phẩm',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        actions: [
          AnimatedBuilder(
            animation: widget.store,
            builder: (context, _) => IconButton(
              onPressed: () => widget.store.toggleFavorite(product.id),
              icon: Icon(
                widget.store.isFavorite(product.id)
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: widget.store.isFavorite(product.id)
                    ? AppColors.orange
                    : AppColors.ink,
              ),
            ),
          ),
          IconButton(
            onPressed: widget.onCart,
            icon: const Icon(Icons.shopping_bag_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 22),
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
              color: product.accent.withValues(alpha: .3),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: PhoneArt(
                product: product,
                colorIndex: colorIndex,
                size: 248,
              ),
            ),
          ),
          const SizedBox(height: 23),
          Row(
            children: [
              Text(
                product.brand.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.orange,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.star_rounded,
                color: Color(0xFFFFBA47),
                size: 19,
              ),
              Text(
                ' ${product.rating}  •  Đã bán ${product.sold}',
                style: const TextStyle(color: AppColors.muted, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(product.name, style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 9),
          Row(
            children: [
              Text(
                money(product.price),
                style: const TextStyle(
                  color: AppColors.orange,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                money(product.oldPrice),
                style: const TextStyle(
                  color: AppColors.muted,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            'Màu sắc',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var index = 0; index < product.colors.length; index++)
                Padding(
                  padding: const EdgeInsets.only(right: 11),
                  child: InkWell(
                    onTap: () => setState(() => colorIndex = index),
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: 38,
                      height: 38,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorIndex == index
                              ? AppColors.orange
                              : AppColors.line,
                          width: 2,
                        ),
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: product.colors[index],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Dung lượng',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              for (final item in product.storage)
                ChoiceChip(
                  label: Text(item),
                  selected: storage == item,
                  onSelected: (_) => setState(() => storage = item),
                  showCheckmark: false,
                  selectedColor: AppColors.ink,
                  labelStyle: TextStyle(
                    color: storage == item ? Colors.white : AppColors.ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'Thông số nổi bật',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(17),
            ),
            child: Column(
              children: [
                _Spec(Icons.smartphone_outlined, 'Màn hình', product.screen),
                _Spec(Icons.camera_alt_outlined, 'Camera', product.camera),
                _Spec(
                  Icons.battery_charging_full_rounded,
                  'Pin',
                  product.battery,
                ),
                _Spec(Icons.memory_rounded, 'Vi xử lý', product.chip),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Mô tả sản phẩm',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            product.description,
            style: const TextStyle(color: AppColors.muted, height: 1.5),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Icon(
                Icons.local_shipping_outlined,
                color: AppColors.orange,
                size: 19,
              ),
              SizedBox(width: 8),
              Text(
                'Miễn phí giao hàng toàn quốc',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: AppColors.line)),
          ),
          child: Row(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.line),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: quantity > 1
                          ? () => setState(() => quantity--)
                          : null,
                      icon: const Icon(Icons.remove, size: 18),
                    ),
                    Text(
                      '$quantity',
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    IconButton(
                      onPressed: () => setState(() => quantity++),
                      icon: const Icon(Icons.add, size: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    widget.store.add(
                      product,
                      color: colorIndex,
                      storage: storage,
                      quantity: quantity,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Đã thêm $quantity sản phẩm vào giỏ hàng',
                        ),
                        action: SnackBarAction(
                          label: 'XEM GIỎ',
                          onPressed: widget.onCart,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.shopping_bag_outlined),
                  label: const Text('Thêm vào giỏ'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(0, 50),
                    backgroundColor: AppColors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Spec extends StatelessWidget {
  const _Spec(this.icon, this.label, this.value);
  final IconData icon;
  final String label, value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        Icon(icon, size: 21, color: AppColors.orange),
        const SizedBox(width: 12),
        SizedBox(
          width: 75,
          child: Text(
            label,
            style: const TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          ),
        ),
      ],
    ),
  );
}
