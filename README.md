# Template project for LF applications based on RIOT OS

This is a template for Lingua Franca applications targeting RIOT OS.

## Getting started

1. Configure the name of the LF application you want to build inside the `Makefile` by specifying the `LF_MAIN` variable.
2. Configure the board to flash in the `Makefile` by specifying the `BOARD` variable.

### Example

```Makefile
LF_MAIN ?= HelloWorld
BOARD ?= native
```

## Build

```bash
make all
```

or with parameters to override the `Makefile configuration

```bash
LF_MAIN=HelloWorld BOARD=native make all
```

## Flash

```bash
make flash
```

or with parameters to override the `Makefile configuration

```bash
LF_MAIN=HelloWorld BOARD=native make flash
```

## Open Terminal

This allows to run CLI commands if a CLI is enabled or seeing debug logs etc.

```bash
make term
```

or with parameters to override the `Makefile configuration

```bash
LF_MAIN=HelloWorld BOARD=native make term
```
