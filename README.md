## Demo of STM32 Using RIoT

[RIoT documentation](https://doc.riot-os.org/index.html).

This repo is based on the [lf-riot-uc-template template repository](https://github.com/lf-lang/lf-riot-uc-template).

### Boards used

This demo uses the following boards:

* [STM32 Nucleo-F446RE microprocessor board](https://doc.riot-os.org/group__boards__nucleo-f446re.html)
* [X-NUCLEO IKS4A1 sensor board](https://www.st.com/en/ecosystems/x-nucleo-iks4a1.html)

### Getting started

Please follow the setup instructions in that [README file](https://github.com/lf-lang/lf-riot-uc-template/blob/main/README.md). Then:

```bash
make BOARD=nucleo-f446re all
```

(or use gmake on macOS).
Connect your board and do:

```bash
make BOARD=nucleo-f446re flash
```

With the HelloWorld program, the LED should start blinking.

### Terminal output

```bash
make BOARD=nucleo-f446re term
```

(You should have done `pip install pyserial` for this to work.)

### Debugging (not tested)

```bash
gmake BOARD=nucleo-f446re debug
```

(requires installing gdb-multiarch)
