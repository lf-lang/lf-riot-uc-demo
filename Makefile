# The name of the LF application inside "./src" to build/run/flash etc.
LF_MAIN ?= AccelerometerDisplay

# Add modules used by the LF application
USEMODULE += periph_i2c
USEMODULE += periph_spi
USEMODULE += periph_pwm

# Enable reactor-uc features
# CFLAGS += -DNETWORK_CHANNEL_TCP_POSIX
# CFLAGS += -DNETWORK_CHANNEL_COAP_RIOT

# Make default debug output report only info and errors.
CFLAGS += -DLF_LOG_LEVEL_ALL=LF_LOG_LEVEL_ERROR

# Execute the LF compiler if build target is "all"
ifeq ($(firstword $(MAKECMDGOALS)),all)
  _ :=  $(shell $(REACTOR_UC_PATH)/lfc/bin/lfc-dev src/$(LF_MAIN).lf)
endif

# ---- RIOT specific configuration ----
# This has to be the absolute path to the RIOT base directory:
RIOTBASE = $(CURDIR)/RIOT

# If no BOARD is found in the environment, use this default:
BOARD ?= nucleo-f446re

# Comment this out to disable code in RIOT that does safety checking
# which is not needed in a production environment but helps in the
# development process:
DEVELHELP ?= 1

# Change this to 0 show compiler invocation lines by default:
QUIET ?= 1

EVENT_QUEUE_SIZE?=20
REACTION_QUEUE_SIZE?=20


include $(REACTOR_UC_PATH)/make/riot/riot-lfc.mk

