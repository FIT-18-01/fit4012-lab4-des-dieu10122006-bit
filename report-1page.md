# Report 1 page - Lab 4 DES / TripleDES

## Mục tiêu

Cài đặt thuật toán DES (Data Encryption Standard) đầy đủ bao gồm:
- Mã hóa DES (DES encrypt)
- Giải mã DES (DES decrypt)
- Mã hóa TripleDES (E-D-E với 3 key)
- Giải mã TripleDES
- Hỗ trợ mã hóa đa block với zero padding

## Cách làm / Method

1. **Phân tích mã gốc:** Mã gốc đã có:
   - Hàm permutation (IP, IP^-1)
   - Lớp KeyGenerator tạo 16 round key
   - Lớp DES với phương thức encrypt
   
2. **Bổ sung:**
   - Thêm phương thức `decrypt()` trong lớp DES (sử dụng round key đảo ngược)
   - Thêm hàm `zero_pad_block()` để đệm zero cho block cuối
   - Viết lại `main()` để nhận input từ stdin theo 4 mode
   - Hỗ trợ multi-block encryption/decryption

3. **Các chế độ hoạt động:**
   - Mode 1: DES encrypt (support multi-block, zero padding)
   - Mode 2: DES decrypt (multi-block)
   - Mode 3: TripleDES encrypt (E-D-E: `E(K3, D(K2, E(K1, P)))`)
   - Mode 4: TripleDES decrypt (D-E-D: `D(K1, E(K2, D(K3, C)))`)

## Kết quả / Result

Chương trình đã cài đặt thành công:
- DES encryption/decryption với 16 rounds Feistel
- TripleDES encrypt/decrypt
- Multi-block support với zero padding
- Input/output chuỗi nhị phân 64-bit

Kết quả kiểm thử:
- Single block DES roundtrip: plaintext -> encrypt -> decrypt = plaintext gốc ✓
- Multi-block DES: chia block và mã hóa tuần tự ✓
- TripleDES: E-D-E và D-E-D hoạt động đúng ✓

## Kết luận / Conclusion

**Bài học kỹ thuật:**
- DES sử dụng 16 vòng Feistel với S-box, expansion, permutation.
- TripleDES tăng độ an toàn bằng cách áp dụng DES 3 lần với 3 key khác nhau.
- Zero padding đơn giản nhưng không phân biệt dữ liệu thật với bit padding.

**Hạn chế hiện tại:**
- Zero padding không an toàn (không phân biệt được dữ liệu thật).
- DES chỉ có block size 64-bit (nhỏ so với AES 128-bit).
- Không có xác thực message (MAC).
- Không có cipher mode nâng cao (CBC, CTR, GCM).

**Hướng mở rộng:**
- Thay thế zero padding bằng PKCS#7 padding (an toàn hơn).
- Implement AES thay DES (an toàn hơn, block size 128-bit).
- Thêm cipher mode (CBC, CTR, GCM) để tăng độ an toàn.
- Thêm xác thực message bằng HMAC.

