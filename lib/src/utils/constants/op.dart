/// Script opcodes.
const OPS = {
  // Push value ops.
  'OP_0': 0x00,
  'OP_FALSE': 0x00,
  'OP_PUSHDATA1': 0x4c,
  'OP_PUSHDATA2': 0x4d,
  'OP_PUSHDATA4': 0x4e,
  'OP_1NEGATE': 0x4f,
  'OP_RESERVED': 0x50,
  'OP_1': 0x51,
  'OP_TRUE': 0x51,
  'OP_2': 0x52,
  'OP_3': 0x53,
  'OP_4': 0x54,
  'OP_5': 0x55,
  'OP_6': 0x56,
  'OP_7': 0x57,
  'OP_8': 0x58,
  'OP_9': 0x59,
  'OP_10': 0x5a,
  'OP_11': 0x5b,
  'OP_12': 0x5c,
  'OP_13': 0x5d,
  'OP_14': 0x5e,
  'OP_15': 0x5f,
  'OP_16': 0x60,

  // Control ops.
  'OP_NOP': 0x61,
  'OP_VER': 0x62,
  'OP_IF': 0x63,
  'OP_NOTIF': 0x64,
  'OP_VERIF': 0x65,
  'OP_VERNOTIF': 0x66,
  'OP_ELSE': 0x67,
  'OP_ENDIF': 0x68,
  'OP_VERIFY': 0x69,
  'OP_RETURN': 0x6a,

  // Stack ops.
  'OP_TOALTSTACK': 0x6b,
  'OP_FROMALTSTACK': 0x6c,
  'OP_2DROP': 0x6d,
  'OP_2DUP': 0x6e,
  'OP_3DUP': 0x6f,
  'OP_2OVER': 0x70,
  'OP_2ROT': 0x71,
  'OP_2SWAP': 0x72,
  'OP_IFDUP': 0x73,
  'OP_DEPTH': 0x74,
  'OP_DROP': 0x75,
  'OP_DUP': 0x76,
  'OP_NIP': 0x77,
  'OP_OVER': 0x78,
  'OP_PICK': 0x79,
  'OP_ROLL': 0x7a,
  'OP_ROT': 0x7b,
  'OP_SWAP': 0x7c,
  'OP_TUCK': 0x7d,

  // Splice ops.
  'OP_CAT': 0x7e,
  'OP_SUBSTR': 0x7f,
  'OP_LEFT': 0x80,
  'OP_RIGHT': 0x81,
  'OP_SIZE': 0x82,

  // Bit logic ops.
  'OP_INVERT': 0x83,
  'OP_AND': 0x84,
  'OP_OR': 0x85,
  'OP_XOR': 0x86,
  'OP_EQUAL': 0x87,
  'OP_EQUALVERIFY': 0x88,
  'OP_RESERVED1': 0x89,
  'OP_RESERVED2': 0x8a,

  // Numeric ops.
  'OP_1ADD': 0x8b,
  'OP_1SUB': 0x8c,
  'OP_2MUL': 0x8d,
  'OP_2DIV': 0x8e,
  'OP_NEGATE': 0x8f,
  'OP_ABS': 0x90,
  'OP_NOT': 0x91,
  'OP_0NOTEQUAL': 0x92,

  'OP_ADD': 0x93,
  'OP_SUB': 0x94,
  'OP_MUL': 0x95,
  'OP_DIV': 0x96,
  'OP_MOD': 0x97,
  'OP_LSHIFT': 0x98,
  'OP_RSHIFT': 0x99,

  'OP_BOOLAND': 0x9a,
  'OP_BOOLOR': 0x9b,
  'OP_NUMEQUAL': 0x9c,
  'OP_NUMEQUALVERIFY': 0x9d,
  'OP_NUMNOTEQUAL': 0x9e,
  'OP_LESSTHAN': 0x9f,
  'OP_GREATERTHAN': 0xa0,
  'OP_LESSTHANOREQUAL': 0xa1,
  'OP_GREATERTHANOREQUAL': 0xa2,
  'OP_MIN': 0xa3,
  'OP_MAX': 0xa4,

  'OP_WITHIN': 0xa5,

  // Crypto ops.
  'OP_RIPEMD160': 0xa6,
  'OP_SHA1': 0xa7,
  'OP_SHA256': 0xa8,
  'OP_HASH160': 0xa9,
  'OP_HASH256': 0xaa,
  'OP_CODESEPARATOR': 0xab,
  'OP_CHECKSIG': 0xac,
  'OP_CHECKSIGVERIFY': 0xad,
  'OP_CHECKMULTISIG': 0xae,
  'OP_CHECKMULTISIGVERIFY': 0xaf,

  // Expansion ops.
  'OP_NOP1': 0xb0,
  'OP_CHECKLOCKTIMEVERIFY': 0xb1,
  'OP_NOP2': 0xb1,
  'OP_CHECKSEQUENCEVERIFY': 0xb2,
  'OP_NOP3': 0xb2,
  'OP_NOP4': 0xb3,
  'OP_NOP5': 0xb4,
  'OP_NOP6': 0xb5,
  'OP_NOP7': 0xb6,
  'OP_NOP8': 0xb7,
  'OP_NOP9': 0xb8,
  'OP_NOP10': 0xb9,

  'OP_INVALIDOPCODE': 0xff,

  // DefiChain.
  "OP_DEFI_TX_UTXOS_TO_ACCOUNT": 0x55,
  "OP_DEFI_TX_ACCOUNT_TO_UTXOS": 0x62,
  "OP_DEFI_TX_ACCOUNT_TO_ACCOUNT": 0x42,
  "OP_DEFI_TX_ANY_ACCOUNT_TO_ACCOUNT": 0x61,
  "OP_DEFI_TX_FUTURE_SWAP": 0x51,
  "OP_DEFI_TX_SET_GOVERNANCE": 0x47,
  "OP_DEFI_TX_SET_GOVERNANCE_HEIGHT": 0x6a,
  "OP_DEFI_TX_CREATE_CFP": 0x7a,
  "OP_DEFI_TX_VOTE": 0x4f,
  "OP_DEFI_TX_ICX_CREATE_ORDER": 0x31,
  "OP_DEFI_TX_ICX_MAKE_OFFER": 0x32,
  "OP_DEFI_TX_ICX_SUBMIT_DFC_HTLC": 0x33,
  "OP_DEFI_TX_ICX_SUBMIT_EXT_HTLC": 0x34,
  "OP_DEFI_TX_ICX_CLAIM_DFC_HTLC": 0x35,
  "OP_DEFI_TX_ICX_CLOSE_ORDER": 0x36,
  "OP_DEFI_TX_ICX_CLOSE_OFFER": 0x37,
  "OP_DEFI_TX_SET_LOAN_SCHEME": 0x4c,
  "OP_DEFI_TX_DESTROY_LOAN_SCHEME": 0x44,
  "OP_DEFI_TX_SET_DEFAULT_LOAN_SCHEME": 0x64,
  "OP_DEFI_TX_SET_COLLATERAL_TOKEN": 0x44,
  "OP_DEFI_TX_SET_LOAN_TOKEN": 0x67,
  "OP_DEFI_TX_UPDATE_LOAN_TOKEN": 0x78,
  "OP_DEFI_TX_TAKE_LOAN": 0x58,
  "OP_DEFI_TX_PAYBACK_LOAN": 0x48,
  "OP_DEFI_TX_PAYBACK_LOAN_V2": 0x6B,
  "OP_DEFI_TX_CREATE_MASTER_NODE": 0x43,
  "OP_DEFI_TX_RESIGN_MASTER_NODE": 0x52,
  "OP_DEFI_TX_UPDATE_MASTER_NODE": 0x6d,
  "OP_DEFI_TX_AUTO_AUTH_PREP": 0x41,
  "OP_DEFI_TX_POOL_SWAP": 0x73,
  "OP_DEFI_TX_COMPOSITE_SWAP": 0x69,
  "OP_DEFI_TX_POOL_ADD_LIQUIDITY": 0x6c,
  "OP_DEFI_TX_POOL_REMOVE_LIQUIDITY": 0x72,
  "OP_DEFI_TX_POOL_CREATE_PAIR": 0x70,
  "OP_DEFI_TX_POOL_UPDATE_PAIR": 0x75,
  "OP_DEFI_TX_CREATE_VAULT": 0x56,
  "OP_DEFI_TX_UPDATE_VAULT": 0x76,
  "OP_DEFI_TX_DEPOSIT_TO_VAULT": 0x53,
  "OP_DEFI_TX_WITHDRAW_FROM_VAULT": 0x4A,
  "OP_DEFI_TX_CLOSE_VAULT": 0x65,
  "OP_DEFI_TX_AUCTION_BID": 0x49
};
