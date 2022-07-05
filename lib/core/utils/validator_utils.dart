import 'package:flavoring/core/extension/extension_barrel.dart';

class ValidatorUtils {
  static bool validateEmpty(String? text) => text == null || (text).isEmpty;

  static bool validateLateTime(String dateTime) =>
      dateTime.toDateTime().isBefore(DateTime.now());

  /// Không giới hạn ký tự.
  static bool validateFullName(String string) {
    return RegExp(
            r"^[a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽếềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵýỷỹ ]{1,}$")
        .hasMatch(string.trim());
  }

  static bool validateEmail(String email) => RegExp(
          r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$")
      .hasMatch(email.trim());

  static bool validatePhone(String? phone) =>
      RegExp(r"^(03|05|07|08|09|01)+([0-9]{8})$").hasMatch(phone?.trim() ?? "");

  /// Ít nhất 6 kí tự.
  /// Ít nhất 1 letter và 1 số, 1 ký tự viết hoa, 1 ký tự đặc biệt
  static bool validatePassword(String? password) {
    if (password == null) {
      return false;
    }
    return RegExp(
            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-{}:]).{8,100}$")
        .hasMatch(password);
  }

  static bool validate0to9Character(String string) {
    return RegExp(r"([0-9])").hasMatch(string);
  }

  static bool validateAddressWithNumber(String string) {
    return RegExp(
            r"^[\.\-\,a-z0-9A-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽếềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵýỷỹ ]{1,256}$")
        .hasMatch(string.trim());
  }
}
