{
  src = ./.;
  name = "oxlib";
  version = "0.0.1";
  library = {
    exposedModules = [
      "Ox1cb05558db7e795771f81d06051ecfecf204778ea709f34695d06de9e9284cfe"
      "Ox23519fe8a95c0a57286224ed219db813cbe08a2be70be7813ebf471018948947"
      "Ox669552b229f9bae85eeb5e089092ee70932c4ebb8bddfd9dff32152dbc9ba678"
      "Ox7f42ecf7089e877e137a4d8bab4f3e72158671a198d81f55ef8a6694318e8c78"
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
  ];
  cabalVersion = ">=1.10";
}
