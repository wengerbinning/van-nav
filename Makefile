# Simple Makefile for a Go project

NPM=$(shell [ which pnpm 2>/dev/null ] && echo pnpm || echo npm)


# Build the application
# all: build test

world: build-app

build-web:
	@echo "Building UI ..."
	@rm -rf public
	@cd ./ui && $(NPM) run build
	@cp -rf ./ui/build public

build-app: build-web
	@echo "Building ..."
	@go build -o vannav .


run-ui:
	@cd ./ui && $(NPM) start

run-api:
	@go run .

# Run the application
run:
	@go run .  &
	@cd ./ui && $(NPM) run start

# Clean the binary
clean:
	@echo "Cleaning ..."
	@rm -f main

# Live Reload
watch:
	@if command -v air > /dev/null; then \
            air; \
            echo "Watching ...";\
        else \
            read -p "Go's 'air' is not installed on your machine. Do you want to install it? [Y/n] " choice; \
            if [ "$$choice" != "n" ] && [ "$$choice" != "N" ]; then \
                go install github.com/air-verse/air@latest; \
                air; \
                echo "Watching...";\
            else \
                echo "You chose not to install air. Exiting..."; \
                exit 1; \
            fi; \
        fi

.PHONY: world build run clean watch