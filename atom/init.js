const ON_MAC = document.body.classList.contains('platform-darwin');
const HOME_PATH = ON_MAC ? '/Users/dsifford' : '/home/dsifford';

atom.config.set('atom-typescript.typescriptServices', `${HOME_PATH}/.config/yarn/global/node_modules/typescript/lib/typescriptServices.js`);
atom.config.set('racer.racerBinPath', `${HOME_PATH}/.cargo/bin/racer`);
atom.config.set('atom-beautify.rust.rustfmt_path', `${HOME_PATH}/.cargo/bin/rustfmt`);

if (ON_MAC) initForMac();
else initForLinux();

function initForMac() {
    atom.config.set('linter-rust.cargoPath', '/Users/dsifford/.cargo/bin/cargo');
    atom.config.set('linter-rust.rustcPath', '/Users/dsifford/.cargo/bin/rustc');
    atom.config.set('racer.rustSrcPath', '/Users/dsifford/.multirust/toolchains/nightly-x86_64-apple-darwin/lib/rustlib/src/rust/src');
    atom.packages.disablePackage('hidpi');
}

function initForLinux() {
    atom.config.set('linter-rust.cargoPath', '/usr/bin/cargo');
    atom.config.set('linter-rust.rustcPath', '/usr/bin/rustc');
    atom.config.set('racer.rustSrcPath', '/home/dsifford/.multirust/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src');
    atom.packages.enablePackage('hidpi');
}
