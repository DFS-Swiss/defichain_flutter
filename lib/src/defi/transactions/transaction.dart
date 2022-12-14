import 'dart:typed_data';
import 'package:defichain_flutter/src/utils/constants/signatures.dart';
import 'package:defichain_flutter/src/utils/push_data.dart';
import 'package:hex/hex.dart';

import '../../utils/constants/op.dart';
import '../../utils/script.dart' as bscript;

Uint8List makeDefiTransaction(ByteData defiData) {
  final push = encode(Uint8List(1), defiData.lengthInBytes, 0).buffer;
  final script = bscript.compile([
    OPS["OP_RETURN"],
    DEFI_SIGNATURE,
    0x43,
    defiData.buffer.asUint8List(),
  ]);

  final ByteData data = ByteData(100);
  data.setUint8(0, OPS["OP_RETURN"]);
  data.setUint32(1, DEFI_SIGNATURE);
  data.setUint8(DEFI_SIGNATURE.bitLength + 1, 0x43);
  data.setUint8(DEFI_SIGNATURE.bitLength + 2, push.first);
  data.buffer.asUint8List().setRange(
        DEFI_SIGNATURE.bitLength + 3,
        DEFI_SIGNATURE.bitLength + 3 + defiData.buffer.lengthInBytes,
        defiData.buffer.asUint8List(),
      );
  return script;
}
