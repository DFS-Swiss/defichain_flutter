import 'dart:typed_data';
import 'package:bs58check/bs58check.dart';
import 'package:defichain_flutter/src/crypto.dart';

import '../../utils/bs58.dart';
import '../../utils/script.dart' as bscript;

ByteData createMasterNode(
    String operatorAdress, int operatorType, int timelock) {
  final operatorTypeBuffer = Uint8List(1);
  operatorTypeBuffer[0] = operatorType;

  base58.decode(operatorAdress);
  final operatorAddressBuffer = toHash160(operatorAdress);

  final buffer = ByteData(timelock != null ? 23 : 21);
  buffer.setUint8(0, operatorType);
  buffer.buffer.asUint8List().setRange(1, 21, operatorAddressBuffer);
  if (timelock != null) {
    buffer.setUint16(21, timelock, Endian.little);
  }
  return buffer;
}
