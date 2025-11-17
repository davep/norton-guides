GUIDES := guides
OUTPUT := docs
NG_FILES := $(wildcard $(GUIDES)/*.ng)
OUTPUT_DIRS := $(patsubst $(GUIDES)/%.ng,$(OUTPUT)/%,$(NG_FILES))

.PHONY: all
all: $(OUTPUT_DIRS)

$(OUTPUT)/%: $(GUIDES)/%.ng
	@mkdir -p $@
	ng2web --index --output $@ $<

.PHONY: clean
clean:
	rm -rf docs/

### Makefile ends here
