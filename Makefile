
dummy:
	@echo "Usage:"
	@echo "  make status - show current versions of packages"

status:
	head  -1 -q */debian/ch* | column -t

