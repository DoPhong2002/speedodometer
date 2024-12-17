import 'package:encrypt/encrypt.dart';

final key = Key.fromUtf8('16charslongkey!!'); // Khóa phải có đúng 16 ký tự

class EncryptManager {
// IV là dữ liệu ngẫu nhiên được thêm vào mỗi lần mã hóa
  final iv = IV.fromLength(16);

// Tạo đối tượng mã hóa AES
  final encrypter = Encrypter(AES(key));

// Hàm mã hóa dữ liệu
  String encryptData(String data) {
    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64; // Trả về dữ liệu mã hóa dưới dạng chuỗi base64
  }

// Hàm giải mã dữ liệu
  String decryptData(String encryptedData) {
    final decrypted = encrypter.decrypt64(encryptedData, iv: iv);
    return decrypted; // Trả về dữ liệu gốc sau khi giải mã
  }
}
