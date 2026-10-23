import 'package:flutter/material.dart';
import '../state/shop_store.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.store});
  final ShopStore store;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: store,
    builder: (context, _) => SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Tài khoản', style: Theme.of(context).textTheme.headlineLarge),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF26313E), Color(0xFF4B5966)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 29,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Khách hàng MobiZone',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Thành viên thân thiết',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded, color: Colors.white),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _Stat(
                  value: '${store.orders}',
                  label: 'Đơn đã đặt',
                  icon: Icons.inventory_2_outlined,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Stat(
                  value: '${store.favoriteCount}',
                  label: 'Yêu thích',
                  icon: Icons.favorite_border_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            'Tiện ích',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Column(
              children: [
                _MenuTile(
                  Icons.local_shipping_outlined,
                  'Theo dõi đơn hàng',
                  'Đơn hàng demo được lưu trong phiên này',
                ),
                Divider(height: 1, indent: 55),
                _MenuTile(
                  Icons.card_giftcard_rounded,
                  'Ưu đãi của tôi',
                  'Giá tốt mỗi ngày tại MobiZone',
                ),
                Divider(height: 1, indent: 55),
                _MenuTile(
                  Icons.support_agent_rounded,
                  'Trung tâm hỗ trợ',
                  'Hỗ trợ khách hàng 24/7',
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.orange.withValues(alpha: .09),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.verified_outlined, color: AppColors.orange),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Cam kết hàng chính hãng, bảo hành uy tín và giao hàng miễn phí.',
                    style: TextStyle(fontSize: 12, height: 1.45),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'MobiZone demo • Phiên bản 1.0',
              style: TextStyle(color: AppColors.muted, fontSize: 11),
            ),
          ),
        ],
      ),
    ),
  );
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, required this.icon});
  final String value, label;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        Icon(icon, color: AppColors.orange),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: AppColors.muted),
            ),
          ],
        ),
      ],
    ),
  );
}

class _MenuTile extends StatelessWidget {
  const _MenuTile(this.icon, this.title, this.subtitle);
  final IconData icon;
  final String title, subtitle;
  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: AppColors.orange),
    title: Text(
      title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    ),
    subtitle: Text(
      subtitle,
      style: const TextStyle(fontSize: 11, color: AppColors.muted),
    ),
    trailing: const Icon(
      Icons.chevron_right_rounded,
      size: 20,
      color: AppColors.muted,
    ),
  );
}
