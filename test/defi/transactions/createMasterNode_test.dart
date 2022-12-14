import 'package:defichain_flutter/src/defi/transactions/masternode.dart';
import 'package:defichain_flutter/src/defi/transactions/transaction.dart';
import 'package:hex/hex.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test("create valid createMasternode data buffer", (() {
    final buffer = createMasterNode("8bdDkJsAB3q5FC3RpMozHfuCWVcdAPFgka", 1, 0);
    expect(HexEncoder().convert(buffer.buffer.asUint8List()),
        "01e150f5bb2eee38427bb0fc62f37faba3bdab47610000");

    print(buffer);
  }));

  test("create a valid createMasternode script", () {
    final script = makeDefiTransaction(
        createMasterNode("8bdDkJsAB3q5FC3RpMozHfuCWVcdAPFgka", 1, 0));
    print(script.lengthInBytes);
    expect(
      HexEncoder().convert(script.buffer.asUint8List()),
      "1c6a1a446654784301e150f5bb2eee38427bb0fc62f37faba3bdab4761",
    );
  });
}
