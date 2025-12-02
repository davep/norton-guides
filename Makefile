##############################################################################
# Commands.
run  := uv run
sync := uv sync

##############################################################################
# Configuration.
GUIDES      := guides
OUTPUT      := docs
INDEX       := $(OUTPUT)/index.html
NG_FILES    := $(wildcard $(GUIDES)/*.ng)
OUTPUT_DIRS := $(patsubst $(GUIDES)/%.ng,$(OUTPUT)/%,$(NG_FILES))

##############################################################################
# Targets for building and maintaining the site.
.PHONY: all
all: $(OUTPUT_DIRS) $(INDEX)

$(OUTPUT)/%: $(GUIDES)/%.ng
	@mkdir -p $@
	uv run ng2web --index --templates=templates/guides/ --output $@ $<

$(INDEX): $(NG_FILES) mkindex templates/index/index.html templates/index/index.css
	uv run ./mkindex

.PHONY: clean
clean:				# Erase the built version of the site
	rm -rf $(OUTPUT)/
	mkdir -p $(OUTPUT)
	echo norton-guides.davep.dev > $(OUTPUT)/CNAME

##############################################################################
# Setup/update packages the system requires.
.PHONY: ready
ready:				# Make the development environment ready to go
	$(sync)

.PHONY: setup
setup: ready			# Set up the repository for development
	$(run) pre-commit install

.PHONY: update
update:				# Update all dependencies
	$(sync) --upgrade

.PHONY: resetup
resetup: realclean		# Recreate the virtual environment from scratch
	make setup

##############################################################################
# Utility.
.PHONY: realclean
realclean: clean		# Clean the venv and build directories
	rm -rf .venv

.PHONY: help
help:				# Display this help
	@grep -Eh "^[a-z]+:.+# " $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.+# "}; {printf "%-20s %s\n", $$1, $$2}'

### Makefile ends here
