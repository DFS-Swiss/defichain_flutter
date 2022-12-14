import 'dart:typed_data';
import 'package:bs58check/bs58check.dart';
import 'package:defichain_flutter/src/crypto.dart';
import 'package:crypto/crypto.dart';
import 'package:collection/collection.dart';

/// Convert a base58 string to its hash160 representation
Uint8List toHash160(String base58String) {
  final decoded = base58.decode(base58String);
  if (decoded.length != 25) {
    throw 'InvalidBase58Address';
  }
  final withPrefix = decoded.sublist(0, 21);
  final checksum = decoded.sublist(21, 25);

  final expectedChecksum = _checksum(withPrefix);
  if (!const ListEquality().equals(checksum, expectedChecksum)) {
    throw 'InvalidChecksum';
  }

  return decoded.sublist(1, 21);
}

//a function that generatest dSHA256 hash from the input Uint8List
Uint8List _checksum(Uint8List input) {
  final hash1 = sha256.convert(input).bytes;
  final hash2 = sha256.convert(hash1).bytes;
  return hash2.sublist(0, 4);
}
