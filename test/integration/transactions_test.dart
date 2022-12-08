import 'package:test/test.dart';
import '../../lib/src/ecpair.dart';
import '../../lib/src/transaction_builder.dart';
import '../../lib/src/models/networks.dart' as NETWORKS;
import '../../lib/src/payments/p2wpkh.dart' show P2WPKH;
import '../../lib/src/payments/index.dart' show PaymentData;

main() {
  group('bitcoinjs-lib (transactions)', () {
    test('can create a 1-to-1 Transaction', () {
      final alice = ECPair.fromWIF(
          'L1uyy5qTuGrVXrmrsvHWHgVzW9kKdrp27wBC7Vs6nZDTF2BRUVwy');
      final txb = new TransactionBuilder();

      txb.setVersion(1);
      txb.addInput(
          '61d520ccb74288c96bc1a2b20ea1c0d5a704776dd0164a396efec3ea7040349d',
          0); // Alice's previous transaction output, has 15000 satoshis
      txb.addOutput('8KTCUNx3LTxgav5vftJQEnghFcTWsrChcP', 12000);
      // (in)15000 - (out)12000 = (fee)3000, this is the miner fee

      txb.sign(vin: 0, keyPair: alice);

      // prepare for broadcast to the Bitcoin network, see 'can broadcast a Transaction' below
      expect(txb.build().toHex(),
          '01000000019d344070eac3fe6e394a16d06d7704a7d5c0a10eb2a2c16bc98842b7cc20d561000000006a473044022045f45fa50f7b0b18d6a70a2dd2356a7eee339acdf1b35bf69a3da2ef5c4e553d0220558ea8a1b0b1100cdc14c937c788d5d0f529dba28b6e9c1995d41293af78d2ea0121029f50f51d63b345039a290c94bffd3180c99ed659ff6ea6b1242bca47eb93b59fffffffff01e02e0000000000001976a9142fe9b944d520fdbf9cb7ec044f20b292b2509bfd88ac00000000');
    });

    test('can create a 2-to-2 Transaction', () {
      final alice = ECPair.fromWIF(
          'L1Knwj9W3qK3qMKdTvmg3VfzUs3ij2LETTFhxza9LfD5dngnoLG1');
      final bob = ECPair.fromWIF(
          'KwcN2pT3wnRAurhy7qMczzbkpY5nXMW2ubh696UBc1bcwctTx26z');

      final txb = new TransactionBuilder();
      txb.setVersion(1);
      txb.addInput(
          'b5bb9d8014a0f9b1d61e21e796d78dccdf1352f23cd32812f4850b878ae4944c',
          6); // Alice's previous transaction output, has 200000 satoshis
      txb.addInput(
          '7d865e959b2466918c9863afca942d0fb89d7c9ac0c99bafc3749504ded97730',
          0); // Bob's previous transaction output, has 300000 satoshis
      txb.addOutput('8KTCUNx3LTxgav5vftJQEnghFcTWsrChcP', 180000);
      txb.addOutput('8VcuVXqtQcRg8MgxyZwsMBaxiixdguH5LQ', 170000);
      // (in)(200000 + 300000) - (out)(180000 + 170000) = (fee)150000, this is the miner fee

      txb.sign(
          vin: 1,
          keyPair:
              bob); // Bob signs his input, which was the second input (1th)
      txb.sign(
          vin: 0,
          keyPair:
              alice); // Alice signs her input, which was the first input (0th)

      // prepare for broadcast to the Bitcoin network, see 'can broadcast a Transaction' below
      expect(txb.build().toHex(),
          '01000000024c94e48a870b85f41228d33cf25213dfcc8dd796e7211ed6b1f9a014809dbbb5060000006b483045022100a3a47b60cc3b4446a5e2b68a321a97cb22c309747367e75513b5e869bcc42d1b02205598470b78e7867293520e4ccdae28861e803721bae7693c203d15f27795f3cd012103e05ce435e462ec503143305feb6c00e06a3ad52fbf939e85c65f3a765bb7baacffffffff3077d9de049574c3af9bc9c09a7c9db80f2d94caaf63988c9166249b955e867d000000006b483045022100c51ca60e643e08ff7e69bbd34d1bc813a33a93272bd4cd93f46cbe61f4f4ccba02206618643275aed60f99aeef6a01e57972712abdcb087c6aa44dd280a3a5de6c66012103df7940ee7cddd2f97763f67e1fb13488da3fbdd7f9c68ec5ef0864074745a289ffffffff0220bf0200000000001976a9142fe9b944d520fdbf9cb7ec044f20b292b2509bfd88ac10980200000000001976a9149f70f7853327c8a49f0d334ab79c4ea87734c87d88ac00000000');
    });

    test('can create an OP_RETURN Transaction', () {
      final alice = ECPair.fromWIF(
          'L1uyy5qTuGrVXrmrsvHWHgVzW9kKdrp27wBC7Vs6nZDTF2BRUVwy');
      final txb = new TransactionBuilder();

      txb.setVersion(1);
      txb.addInput(
          '61d520ccb74288c96bc1a2b20ea1c0d5a704776dd0164a396efec3ea7040349d',
          0); // Alice's previous transaction output, has 15000 satoshis
      txb.addOutputData('Hey this is a random string without Bitcoins');

      txb.sign(vin: 0, keyPair: alice);

      // prepare for broadcast to the Bitcoin network, see 'can broadcast a Transaction' below
      expect(txb.build().toHex(),
          '01000000019d344070eac3fe6e394a16d06d7704a7d5c0a10eb2a2c16bc98842b7cc20d561000000006a47304402200852194e22d2b5faf9db66407d769b13278708b77e55df5d9c8638367af4c0870220638083bdaf06d8147ad4bfaddb975a2a4a056cca806a717e956d334c01482b3a0121029f50f51d63b345039a290c94bffd3180c99ed659ff6ea6b1242bca47eb93b59fffffffff0100000000000000002e6a2c486579207468697320697320612072616e646f6d20737472696e6720776974686f757420426974636f696e7300000000');
    });

    test('can create (and broadcast via 3PBP) a Transaction, w/ a P2WPKH input',
        () {
      final alice = ECPair.fromWIF(
          'cUNfunNKXNNJDvUvsjxz5tznMR6ob1g5K6oa4WGbegoQD3eqf4am',
          network: NETWORKS.testnet);
      final p2wpkh = new P2WPKH(
              data: new PaymentData(pubkey: alice.publicKey),
              network: NETWORKS.testnet)
          .data;
      final txb = new TransactionBuilder(network: NETWORKS.testnet);
      txb.setVersion(1);
      txb.addInput(
          '53676626f5042d42e15313492ab7e708b87559dc0a8c74b7140057af51a2ed5b',
          0,
          null,
          p2wpkh
              .output); // Alice's previous transaction output, has 200000 satoshis
      txb.addOutput('tb1qchsmnkk5c8wsjg8vxecmsntynpmkxme0yvh2yt', 1000000);
      txb.addOutput('tb1qn40fftdp6z2lvzmsz4s0gyks3gq86y2e8svgap', 8995000);

      txb.sign(vin: 0, keyPair: alice, witnessValue: 10000000);
      // // prepare for broadcast to the Bitcoin network, see 'can broadcast a Transaction' below
      expect(txb.build().toHex(),
          '010000000001015beda251af570014b7748c0adc5975b808e7b72a491353e1422d04f5266667530000000000ffffffff0240420f0000000000160014c5e1b9dad4c1dd0920ec3671b84d649877636f2fb8408900000000001600149d5e94ada1d095f60b701560f412d08a007d11590247304402203c4670ff81d352924af311552e0379861268bebb2222eeb0e66b3cdd1d4345b60220585b57982d958208cdd52f4ead4ecb86cfa9ff7740c2f6933e77135f1cc4c58f012102f9f43a191c6031a5ffae27c5f9911218e78857923284ac1154abc2cc008544b200000000');
    });
  });
}
