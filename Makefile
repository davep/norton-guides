GUIDES := guides
OUTPUT := docs
INDEX := $(OUTPUT)/index.html
NG_FILES := $(wildcard $(GUIDES)/*.ng)
OUTPUT_DIRS := $(patsubst $(GUIDES)/%.ng,$(OUTPUT)/%,$(NG_FILES))

.PHONY: all
all: $(OUTPUT_DIRS) $(INDEX)

$(OUTPUT)/%: $(GUIDES)/%.ng
	@mkdir -p $@
	uv run ng2web --index --templates=templates/guides/ --output $@ $<

$(INDEX): $(NG_FILES) mkindex templates/index/index.html
	uv run ./mkindex

.PHONY: clean
clean:
	rm -rf docs/

### Makefile ends here
