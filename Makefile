makefiles = \
  mk/precompiled-headers.mk \
  local.mk \
  src/libutil/local.mk \
  src/libstore/local.mk \
  src/libfetchers/local.mk \
  src/libmain/local.mk \
  src/libexpr/local.mk \
  src/libcmd/local.mk \
  src/nix/local.mk \
  src/resolve-system-dependencies/local.mk \
  scripts/local.mk \
  misc/bash/local.mk \
  misc/fish/local.mk \
  misc/zsh/local.mk \
  misc/systemd/local.mk \
  misc/launchd/local.mk \
  misc/upstart/local.mk \
  doc/manual/local.mk \
  doc/internal-api/local.mk

-include Makefile.config

ifeq ($(tests), yes)
makefiles += \
  tests/unit/libutil/local.mk \
  tests/unit/libutil-support/local.mk \
  tests/unit/libstore/local.mk \
  tests/unit/libstore-support/local.mk \
  tests/unit/libexpr/local.mk \
  tests/unit/libexpr-support/local.mk \
  tests/functional/local.mk \
  tests/functional/ca/local.mk \
  tests/functional/dyn-drv/local.mk \
  tests/functional/test-libstoreconsumer/local.mk \
  tests/functional/plugins/local.mk
else
makefiles += \
  mk/disable-tests.mk
endif

OPTIMIZE = 1

ifeq ($(OPTIMIZE), 1)
  GLOBAL_CXXFLAGS += -O3 $(CXXLTO)
  GLOBAL_LDFLAGS += $(CXXLTO)
else
  GLOBAL_CXXFLAGS += -O0 -U_FORTIFY_SOURCE
endif

GLOBAL_CFLAGS   += $(CPPFLAGS)
GLOBAL_CXXFLAGS += $(CPPFLAGS)
GLOBAL_LDFLAGS  += $(LDFLAGS)

include mk/lib.mk

GLOBAL_CXXFLAGS += -g -Wall -include config.h -std=c++2a -I src
