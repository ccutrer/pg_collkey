EXTENSION    = pg_collkey
EXTVERSION   = $(shell grep default_version $(EXTENSION).control | \
               sed -e "s/default_version[[:space:]]*=[[:space:]]*'\([^']*\)'/\1/")

DATA         = $(filter-out $(wildcard *--*.sql),$(wildcard *.sql))
MODULE_big   = collkey_icu
OBJS         = collkey_icu.o
PG_CONFIG    = pg_config
PG91         = $(shell $(PG_CONFIG) --version | grep -qE " 8\.| 9\.0" && echo no || echo yes)
SHLIB_LINK   = $(shell icu-config --ldflags)
PG_CPPFLAGS  = $(shell icu-config --cppflags-searchpath)

ifeq ($(PG91),yes)
all: $(EXTENSION)--$(EXTVERSION).sql

$(EXTENSION)--$(EXTVERSION).sql: collkey_icu.sql
	cp $< $@

DATA = $(wildcard *--*.sql) $(EXTENSION)--$(EXTVERSION).sql
EXTRA_CLEAN = $(EXTENSION)--$(EXTVERSION).sql
endif

PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
