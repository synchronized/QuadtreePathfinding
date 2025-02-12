default: build

install:
	conan install . --output-folder=Build --build=missing -s compiler.cppstd=20

cmake:
	@if [ ! -d Build ]; then \
		$(MAKE) install; \
	fi
	cmake -B Build \
        -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake \
        -DCMAKE_BUILD_TYPE=Release 

build:
	@if [ ! -d Build ]; then \
		$(MAKE) cmake; \
	fi
	cmake --build Build

.PHONY: build

