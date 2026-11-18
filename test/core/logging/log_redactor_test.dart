import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_standard/core/logging/log_redactor.dart';

void main() {
  test('masks passwords and tokens in JSON-like text', () {
    final out = LogRedactor.redact(
      '{"username":"emily","password":"pw123","token":"abc.def"}',
    );
    expect(out, contains('emily'));
    expect(out, isNot(contains('pw123')));
    expect(out, isNot(contains('abc.def')));
  });

  test('masks Authorization headers including the Bearer prefix', () {
    final out = LogRedactor.redact({'Authorization': 'Bearer abc123'});
    expect(out, isNot(contains('abc123')));
    expect(out, contains(LogRedactor.mask));
  });

  test('masks key=value forms from toString output', () {
    final out = LogRedactor.redact('User(id: 1, token: secretvalue)');
    expect(out, isNot(contains('secretvalue')));
  });

  test('leaves non-sensitive text untouched', () {
    expect(LogRedactor.redact('GET /products?limit=20'), 'GET /products?limit=20');
  });

  test('truncates long payloads', () {
    final out = LogRedactor.redactAndTruncate('a' * 5000, maxLength: 100);
    expect(out.length, lessThan(130));
  });
}
