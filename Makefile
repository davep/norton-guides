GUIDES := guides
OUTPUT := docs
NG_FILES := $(wildcard $(GUIDES)/*.ng)
OUTPUT_DIRS := $(patsubst $(GUIDES)/%.ng,$(OUTPUT)/%,$(NG_FILES))

.PHONY: all
all: $(OUTPUT_DIRS)

$(OUTPUT)/%: $(GUIDES)/%.ng
	@mkdir -p $@
	uv run ng2web --index --templates=templates/guides/ --output $@ $<

.PHONY: clean
clean:
	rm -rf docs/

### Makefile ends here
