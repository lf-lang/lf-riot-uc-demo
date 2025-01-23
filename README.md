reactor-uc RIOT-OS Template
======================

This is a template for Lingua Franca applications targeting RIOT OS on embedded boards. It is currently configured to support ARM-based boards.

If you have trouble, please refer to the platform-specific hints towards the end of these instructions.

## 1. Basic Prerequisites

Your system must have the following software packages (you likely have at least some of these already):

 - `git` — [a distributed version control system](https://git-scm.com/)
 - `make` — Need at least version 4.0 for RIOT (see [macOS Hints](#macos-hints))
 - `java` — [Java 17](https://openjdk.org/projects/jdk/17)
 - `nix` — [a purely functional package manager](https://nix.dev/tutorials/install-nix)

**Installation on Linux**

```bash
sudo apt update
sudo apt install git openjdk-17-jdk openjdk-17-jre nix cmake build-essential python3
sudo pip install pyserial
```

**Installation on macOS**

```bash
brew install git cmake openjdk@17 make
curl -L https://nixos.org/nix/install | sh
pip install pyserial
```

Note that `make` will be installed as `gmake` (see [macOS Hints](#macos-hints)), so all commands below should use `gmake` instead of `make`.

## 2. Micro C Target for Lingua Franca
This template uses [reactor-uc](https://github.com/lf-lang/reactor-uc), the "micro C" target for Lingua Franca. Clone this repo with one of the following:

```bash 
git clone https://github.com/lf-lang/reactor-uc.git --recurse-submodules
# or 
git clone git@github.com:lf-lang/reactor-uc.git --recurse-submodules
```

## 3. Install a cross-compiler for your board

This README only covers arm-based boards. For boards having a CPU with different architecture, please check which cross-compilers are available for your operating system.

A quick way to check if you already have an arm cross-compiler installed:
```bash 
which arm-none-eabi-gcc
```

## 3.1. Debian & Ubuntu

```bash
sudo apt install gcc-arm-none-eabi 
```

## 3.2. Nix

The template repo includes support for using the [nix](https://nix.dev) package manager to perform the installation. It is currently set to support ARM-based boards that use the `arm-none-eabi-gcc` cross-compiler.

The following command creates a shell environment in which all necessary dependencies are installed.

```bash 
nix develop
```

This creates a new shell in which the cross-compiler is available.
**IMPORTANT**: Don't forget to run ``nix develop`` again when you return to your project in a new shell.

## 4. Create a repository using this repo as the template

On GitHub, [create a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template) using [this template](https://github.com/lf-lang/lf-riot-uc-template).
Then clone this repo onto your development machine.
This will be your workspace for developing Lingua Franca programs.

The RIOT OS sources are provided as a submodule of the new repository, to fetch them do:

```bash
git submodule update --init --recursive
```

## 5. Configure the Makefile

Your new repository has a `Makefile` in the home directory that governs the build. It is set by default to compile a very simple LF program that you can find in `src/HelloWorld.lf`.  To compile a different LF program, edit the `Makefile` to point the `LF_MAIN` to your LF program and
set the `BOARD` variable to specify your board.  By default, these are defined in the `Makefile` as follows:

```Makefile
LF_MAIN ?= HelloWorld
BOARD ?= native
```

Setting `BOARD` to `native` should result in an executable that runs in your development machine, **but only if it is a Linux machine** (on other platforms, the generated code will fail to compile).  To specify, for example, the ST `nucleo-f446re`, you would write:

```Makefile
BOARD ?= nucleo-f446re
```

Alternatively, you can override the board on the command line. For example:

```sh
make BOARD=nucleo-f446re all
```

See [boards supported by RIOT](https://www.riot-os.org/boards.html).

## 6. Build

```bash
make all
```

or with parameters to override the `Makefile configuration

```bash
make LF_MAIN=HelloWorld BOARD=nucleo-f446re all
```

## 7. Flash the program onto your board

```bash
make flash
```

or with parameters to override the `Makefile configuration

```bash
make LF_MAIN=HelloWorld BOARD=nucleo-f446re flash
```

## 8. Open a Terminal

You can open a terminal that interacts with stdin and stdout of your program as follows:

```bash
make term
```

This will display any output your program generates using, for example, `printf`.

You can also get debug output from the `reactor-uc` runtime by changing the following line in the `Makefile`:

```
CFLAGS += -DLF_LOG_LEVEL_ALL=LF_LOG_LEVEL_ERR
```

to

```
CFLAGS += -DLF_LOG_LEVEL_ALL=LF_LOG_LEVEL_DEBUG
```

## 9. VS Code extensions

To edit Lingua Franca programs, it is convenient to use the [Lingua Franca extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=lf-lang.vscode-lingua-franca).
If you do not have [the Visual Studio Code IDE](https://code.visualstudio.com/download), you can install it using one of (for Linux and macOS, respectively):

```
sudo snap install code --classic
brew install --cask visual-studio-code
```

You may also benefit from the following extensions:

 - `ms-vscode.cmake-tools` — [Extended CMake support in Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
 - `ms-vscode.cpptools` — [C/C++ IntelliSense, debugging, and code browsing](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
 - `marus25.cortex-debug` — [ARM Cortex-M GDB Debugger support for VSCode](https://marketplace.visualstudio.com/items?itemName=marus25.cortex-debug)

To install them from the command line, run:

```bash
$ code --install-extension lf-lang.vscode-lingua-franca --pre-release
$ code --install-extension ms-vscode.cmake-tools
$ code --install-extension ms-vscode.cpptools
$ code --install-extension marus25.cortex-debug
```


## macOS Hints

The tools require `make` to be at least version 4.0, and, as of this writing, standard macOS distributions have an older version.  Check:

```
$ make --version
GNU Make 3.81
...
```

You can install a more recent version:

```
brew install make
```

Note that `make` will be installed as `gmake`, so all commands above should use `gmake` instead of `make`.

## Linux Hints

To use `nix` on Linux (or WSL), make sure that your user is a member of the `nix-users` group. To check this, run:

```bash
$ groups
```

If `nix-users` is not listed, run:

```bash
$ sudo usermod -aG nix-users $USER
```

Please note that you might need to reboot your system after running `usermod` in order for the new group membership to be reflected.


