# MobiZone

Ứng dụng Flutter bán điện thoại để demo, dùng dữ liệu mẫu có sẵn trong ứng dụng và không cần API.

## Màn hình

1. **Trang chủ:** banner sản phẩm, thương hiệu và điện thoại nổi bật.
2. **Sản phẩm:** tìm kiếm theo tên, lọc thương hiệu, sắp xếp theo giá.
3. **Chi tiết:** xem thông số, chọn màu, dung lượng, số lượng và thêm vào giỏ.
4. **Giỏ hàng:** chỉnh số lượng, xóa sản phẩm, xem tổng tiền và đặt hàng demo.
5. **Tài khoản:** thông tin thành viên, số đơn hàng và số sản phẩm yêu thích.

## Chạy ứng dụng

```bash
flutter pub get
flutter run
```

Kiểm tra bằng `flutter test` và `flutter analyze`.

Dữ liệu sản phẩm ở `lib/data/mock_products.dart`. Trạng thái giỏ hàng và yêu thích chỉ lưu trong bộ nhớ; đặt hàng chỉ mô phỏng, không có thanh toán hoặc tài khoản thật.
# phone_remote
