
SHELL := /bin/bash

# For the benefit of dh_make...
export DEBFULLNAME = P. S. Clarke
export DEBEMAIL = debs@pscl4rke.net
year = $(shell date "+%Y")

dummy:
	@echo "Usage:"
	@echo "  make status - show current versions of packages"
	@echo "  make name=foo new - create a new package"

status:
	head  -1 -q */debian/ch* | column -t

new:
	@test "$(name)" || (echo Missing name && exit 1)
	@test ! -e "$(name)" || (echo $(name) exists already && exit 1)
	@echo Creating $(name)...
	mkdir $(name)-0.0.1
	cd $(name)-0.0.1 && dh_make --native --indep
	mv $(name)-0.0.1 $(name)
	rm -f $(name)/debian/*.ex
	rm -f $(name)/debian/*.EX
	rm -f $(name)/debian/README*
	rm -f $(name)/debian/docs*
	rm -f $(name)/debian/*.docs
	sed -i 's/unstable/UNRELEASED/' $(name)/debian/changelog
	sed -i 's/unknown/misc/' $(name)/debian/control
	sed -i 's/^Homep/#Homep/' $(name)/debian/control
	sed -i 's|<url://example.com>|(none)|g' $(name)/debian/copyright
	sed -i 's/: <years.*$$/: $(year) $(DEBFULLNAME) <$(DEBEMAIL)>/' $(name)/debian/copyright
	sed -i '/<years>/ d' $(name)/debian/copyright
	sed -i '/for another author/ d' $(name)/debian/copyright
	sed -i '/^# / d' $(name)/debian/copyright
	echo "$(name)/debian/$(name)/" >> .gitignore
	@echo
	@echo You still need to remove the extra section from the copyright file...
	@echo
	@echo You still need to fix a few things in the control file...
