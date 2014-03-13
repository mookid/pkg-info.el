EMACS ?= emacs
EMACSFLAGS =
CASK = cask
TESTARGS =
PKGDIR := $(shell EMACS=$(EMACS) $(CASK) package-directory)

export EMACS

SRCS = pkg-info.el
OBJECTS = $(SRCS:.el=.elc)

.PHONY: test compile clean

compile : $(OBJECTS)

clean :
	rm -rf $(OBJECTS)

test : compile
	$(CASK) exec ert-runner $(TESTARGS)

%.elc : %.el $(PKGDIR)
	$(CASK) exec $(EMACS) -Q -l compat/load.el --batch $(EMACSFLAGS) -f batch-byte-compile $<

$(PKGDIR) : Cask
	$(CASK) install
	touch $(PKGDIR)
