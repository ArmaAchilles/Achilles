# Targets
.PHONY: all install uninstall clean _dll _move _remove
.DEFAULT_GOAL := all

# Params
DEBUG = 0

# Folders
SRC_DIR = src/
BIN_DIR = bin/
POSTFIX =
OBJ_DIR = bin/obj$(POSTFIX)/

# Files
DLL_NAME = achilles_sqe_api
DLL = $(BIN_DIR)$(DLL_NAME)$(POSTFIX).dll
SOURCES = $(wildcard $(SRC_DIR)*.cpp)
OBJECTS = $(patsubst $(SRC_DIR)%.cpp, $(OBJ_DIR)%.o, $(SOURCES))

# Commands
FINECHO = @echo; echo

# Flags
CXXFLAGS = -O3

ifeq ($(DEBUG),1)
	CXXFLAGS += -Wall -Wextra -g
endif

all:
	$(MAKE) _dll CXX=i686-w64-mingw32-g++
	$(MAKE) _dll CXX=x86_64-w64-mingw32-g++ POSTFIX=_x64
	$(FINECHO) "SQE API built!"

_dll: $(DLL)

$(DLL): $(OBJECTS)
	mkdir -p $(BIN_DIR)
	$(CXX) -shared $(CXXFLAGS) $^ -o $@

$(OBJ_DIR)%.o: $(SRC_DIR)%.cpp
	mkdir -p $(OBJ_DIR)
	$(CXX) -c $(CXXFLAGS) $< -o $@

clean:
	$(RM) -r bin/
	$(FINECHO) "SQE API cleaned!"

install:
	$(MAKE) _move CXX=i686-w64-mingw32-g++
	$(MAKE) _move CXX=x86_64-w64-mingw32-g++ POSTFIX=_x64
	$(FINECHO) "SQE API installed!"

_move:
	cp $(DLL) ../../@AresModAchillesExpansion/.

uninstall:
	$(MAKE) _remove CXX=i686-w64-mingw32-g++
	$(MAKE) _remove CXX=x86_64-w64-mingw32-g++ POSTFIX=_x64
	$(FINECHO) "SQE API uninstalled!"

_remove:
	rm ../../@AresModAchillesExpansion/$(DLL_NAME)$(POSTFIX).dll
