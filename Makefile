DESTDIR ?= $(HOME)
SRCDIR  := src

LIST  := $(shell find $(SRCDIR) -type f)
FILES := $(patsubst $(SRCDIR)/%,$(DESTDIR)/.%,$(LIST))

define _FILE =
$(1): $(DESTDIR)/.%: $(SRCDIR)/% |
ifeq ($$(shell basename $$(shell dirname $(1))),bin)
	@install -D -T -m 755 -v "$$<" "$$@"
else
	@install -D -T -m 644 -v "$$<" "$$@"
endif

endef

all:

install: $(FILES)

.PHONY: all install

$(foreach var,$(FILES),$(eval $(call _FILE,$(var))))
