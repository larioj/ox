{
  src = ./.;
  name = "oxlib";
  version = "0.0.1";
  library = {
    exposedModules = [
      "Ox1cb05558db7e795771f81d06051ecfecf204778ea709f34695d06de9e9284cfe"
      "Ox23519fe8a95c0a57286224ed219db813cbe08a2be70be7813ebf471018948947"
      "Ox41f3dd81ad49a76616afeca53570713522218bee8f562ce26e6aec4b60edfa7c"
      "Ox669552b229f9bae85eeb5e089092ee70932c4ebb8bddfd9dff32152dbc9ba678"
      "Ox7f42ecf7089e877e137a4d8bab4f3e72158671a198d81f55ef8a6694318e8c78"
      "Ox88110558d9bc0fc99d6d3c2393912206c75a8610e7d0201698879f2bcda87f71"
      "Ox96fbf03b0db2615442ebebbc8d364568f4bb5715314c360c1dfe4ad177ba7846"
      "Oxb4e01c9c75b148605bd73178da03cc59f2fc4f1fbc19b6016a7e773282ef3679"
      "Oxb7a00fa696fcef772655d362ae3453e0badff869b84f961c13230172fd7cb933"
      "Oxc602fdae6c0cb90de319ab7b2a2c2c52b46891936f77150d478579476126a7b0"
      "Oxc8bf6d5cfb4dca83ac176ce7ef16a0a9d8c7c8ce6b322403648cda1c226fd644"
      "Oxea291a39171517dfee51928348fbf732ca6d1deb8732a005db535919cba37969"
    ];
  };
  dependencies = [
    "base"
    "regex-pcre"
    "directory"
    "filepath"
    "split"
    "cryptohash"
    "base16-bytestring"
    "bytestring"
    "containers"
  ];
  cabalVersion = ">=1.10";
}
