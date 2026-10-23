import 'package:flutter/material.dart';
import '../models/product.dart';
import '../state/shop_store.dart';
import '../theme/app_theme.dart';
import '../widgets/phone_art.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.store, required this.onExplore});
  final ShopStore store;
  final VoidCallback onExplore;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: store,
    builder: (context, _) => SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Giỏ hàng',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Text(
                  '${store.cartCount} sản phẩm',
                  style: const TextStyle(color: AppColors.muted),
                ),
              ],
            ),
          ),
          if (store.cart.isEmpty)
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 108,
                        height: 108,
                        decoration: BoxDecoration(
                          color: AppColors.orange.withValues(alpha: .1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          color: AppColors.orange,
                          size: 48,
                        ),
                      ),
                      const SizedBox(height: 23),
                      const Text(
                        'Giỏ hàng đang trống',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Cùng khám phá những chiếc điện thoại tuyệt vời nhé!',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.muted),
                      ),
                      const SizedBox(height: 22),
                      FilledButton(
                        onPressed: onExplore,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.orange,
                        ),
                        child: const Text('Khám phá sản phẩm'),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else ...[
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                itemCount: store.cart.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final line = store.cart[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.line),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 96,
                          height: 110,
                          decoration: BoxDecoration(
                            color: line.product.accent.withValues(alpha: .25),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Center(
                            child: PhoneArt(
                              product: line.product,
                              colorIndex: line.color,
                              size: 87,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                line.product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${line.storage} • Màu ${line.color + 1}',
                                style: const TextStyle(
                                  color: AppColors.muted,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 9),
                              Text(
                                money(line.product.price),
                                style: const TextStyle(
                                  color: AppColors.orange,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 7),
                              Row(
                                children: [
                                  _QuantityButton(
                                    Icons.remove,
                                    () => store.changeQuantity(line.key, -1),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    child: Text(
                                      '${line.quantity}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  _QuantityButton(
                                    Icons.add,
                                    () => store.changeQuantity(line.key, 1),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () => store.changeQuantity(
                                      line.key,
                                      -line.quantity,
                                    ),
                                    icon: const Icon(
                                      Icons.delete_outline_rounded,
                                      size: 21,
                                      color: AppColors.muted,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 17, 20, 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.line)),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Tạm tính',
                        style: TextStyle(color: AppColors.muted),
                      ),
                      const Spacer(),
                      Text(
                        money(store.subtotal),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Text(
                        'Phí vận chuyển',
                        style: TextStyle(color: AppColors.muted),
                      ),
                      Spacer(),
                      Text(
                        'Miễn phí',
                        style: TextStyle(
                          color: Color(0xFF36A77A),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 25),
                  Row(
                    children: [
                      const Text(
                        'Tổng cộng',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        money(store.subtotal),
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                          color: AppColors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 13),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        store.checkout();
                        showDialog<void>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Đặt hàng thành công!'),
                            content: const Text(
                              'Đơn hàng demo đã được ghi nhận. Cảm ơn bạn đã mua sắm tại MobiZone!',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Đóng'),
                              ),
                            ],
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.orange,
                        minimumSize: const Size(0, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Đặt hàng ngay',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    ),
  );
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton(this.icon, this.onTap);
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.canvas,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Icon(icon, size: 16),
    ),
  );
}
