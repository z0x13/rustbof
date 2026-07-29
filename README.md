# rustbof

![Rust](https://img.shields.io/badge/made%20with-Rust-red)
![License](https://img.shields.io/badge/license-MIT%2FApache--2.0-brightgreen)

This project enables the development of BOFs using Rust with full `no_std` support. It leverages Rust's safety features and modern tooling while producing small, efficient COFF objects.

The framework provides everything needed for BOF development. The build process compiles your code to a static library, which [boflink](https://github.com/MEhrn00/boflink) then links into a COFF object with proper relocations and imports for Beacon's dynamic function resolution.

## Requirements

- Rust nightly
- [boflink](https://github.com/MEhrn00/boflink)
- [cargo-make](https://github.com/sagiegurari/cargo-make)

## Quick Start

The easiest way to get started is using the project template with [cargo-generate](https://github.com/cargo-generate/cargo-generate). This will create a new BOF project with all the necessary configuration already set up:

```bash
cargo generate --git https://github.com/joaoviictorti/rustbof .template
cd <project-name>
cargo make
```

Alternatively, you can clone the repository and explore the `examples/` directory, which contains working BOF implementations demonstrating various use cases. These examples serve as practical references for building your own BOFs.

```bash
git clone https://github.com/joaoviictorti/rustbof
cd rustbof/examples/whoami
cargo make
```

You can also use Docker to build without installing the toolchain locally:

```bash
git clone https://github.com/joaoviictorti/rustbof
cd rustbof
docker build -t rustbof .
docker run -it rustbof
```

## Usage

The `#[rustbof::main]` attribute macro generates the entry point required by BOF loaders. Your main function can be simple with no arguments, or receive raw argument data for parsing.

A basic BOF that prints a message:

```rust
#![no_std]

use rustbof::println;

#[rustbof::main]
fn main() {
    println!("Hello from Rust BOF!");
}
```

For BOFs that need to receive arguments, use `DataParser` to extract typed values from the raw argument buffer:

```rust
#![no_std]

use rustbof::println; 
use rustbof::data::DataParser;

#[rustbof::main]
fn main(args: *mut u8, len: usize) {
    let mut parser = DataParser::new(args, len);
    let name = parser.get_str();
    println!("Hello, {name}!");
}
```

## Examples

The [examples](/examples) directory contains working BOFs: [whoami](/examples/whoami), [ipconfig](/examples/ipconfig) and [env](/examples/env).

## License

rustbof is licensed under either of

- Apache License, Version 2.0, ([LICENSE-APACHE](https://github.com/joaoviictorti/rustbof/tree/main/LICENSE-APACHE) or
  <https://www.apache.org/licenses/LICENSE-2.0>)
- MIT license ([LICENSE-MIT](https://github.com/joaoviictorti/rustbof/tree/main/LICENSE-MIT) or <https://opensource.org/licenses/MIT>)

at your option.

Unless you explicitly state otherwise, any contribution intentionally submitted for inclusion in rustbof
by you, as defined in the Apache-2.0 license, shall be dually licensed as above, without any
additional terms or conditions.
