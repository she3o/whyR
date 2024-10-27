# Makefile for managing the Quarto project

# Variables
BUILD_DIRS := _freeze dist .quarto
PREVIEW_LOG := preview.log
CLEAN_CMD := rm -rf $(BUILD_DIRS) $(PREVIEW_LOG)
QUARTO := quarto
PY := python3


# Declare phony targets to avoid conflicts with files of the same name
.PHONY: clean publish preview build serve rebuild default help \
        c p b s r h

# Default target: Render the Quarto project
default: build

# Display available commands
help:
	@echo "Available targets:"
	@echo "  clean       Remove build directories ($(BUILD_DIRS))"
	@echo "  publish     Publish the Quarto project"
	@echo "  preview     Preview the Quarto project locally"
	@echo "  build       Render the Quarto project"
	@echo "  serve       Serve the Quarto project locally"
	@echo "  rebuild     Clean and then render the Quarto project"
	@echo "  help        Show this help message"
	@echo ""
	@echo "Shortcodes (aliases):"
	@echo "  c           make clean"
	@echo "  p           make preview"
	@echo "  b           make build"
	@echo "  s           make serve"
	@echo "  r           make rebuild"
	@echo "  h           make help"

# Remove build directories
clean:
	$(CLEAN_CMD)

# Publish the Quarto project
publish:
	$(QUARTO) publish

# Watch the Quarto project
preview:
	@echo "Starting Quarto preview in the background..."
	@nohup $(QUARTO) preview > $(PREVIEW_LOG) 2>&1 &

# Render the Quarto project
build:
	$(QUARTO) render

# Serve the Quarto project locally
serve:
	$(QUARTO) serve

# Serve the entire repo over http
serve-repo:
	$(PY) -m http.server 8000

# Rebuild: clean and then render the Quarto project
rebuild: clean build

# Shortcode aliases
c: clean
p: preview
b: build
s: serve
r: rebuild
h: help
