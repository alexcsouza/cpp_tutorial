CC := g++ # This is the main compiler

SRC_DIR := src
INCLUDE_DIR := include
TEST_SRC_DIR := test
BUILD_DIR := build
BIN_DIR := bin
COV_DIR := coverage
TEST_TARGET := $(BIN_DIR)/tests
TARGET := $(BIN_DIR)/app
SRC_EXT := cpp
MAIN:=$(SRCDIR)/main.$(SRC_EXT)
SOURCES := $(shell find $(SRCDIR) -type f -name *.$(SRC_EXT))
TEST_SOURCES := $(shell find $(TEST_SRC_DIR) -type f -name *.$(SRC_EXT))
OBJECTS := $(patsubst $(SRCDIR)/%,$(BUILD_DIR)/%,$(SOURCES:.$(SRC_EXT)=.o))
CFLAGS := # -Wall
LIB := #-pthread -lmongoclient -L lib -lboost_thread-mt -lboost_filesystem-mt -lboost_system-mt
INC := -I $(INCLUDE_DIR)

$(TARGET): clean $(OBJECTS)
	@echo " Linking"; 
	@echo " $(CC) build/main.o -o $(TARGET) $(LIB)"; $(CC) build/main.o -o $(TARGET) $(LIB)

$(BUILD_DIR)/%.o: $(SRCDIR)/%.$(SRC_EXT) 
	@echo " Building " $@
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(BIN_DIR)
	@echo " $(CC) $(CFLAGS) -c $< $(INC) -o $@ "; $(CC) $(CFLAGS) -c $< $(INC) -o $@

clean:
	@echo " Running Clean"; 
	@echo " $(RM) -r -f $(BUILD_DIR) $(BIN_DIR) $(COV_DIR)"; $(RM) -r $(BUILD_DIR) $(BIN_DIR) $(COV_DIR)
	@echo " $(RM) -f *.gcno"; $(RM) -f *.gcno
	@echo " $(RM) -f *.gcda"; $(RM) -f *.gcda
	@echo " $(RM) -f *.gcov"; $(RM) -f *.gcov
	
coverage: run-tests
	@echo " Running Coverage"; 
	mkdir -p $(COV_DIR)
#	mv -f *.gcno $(COV_DIR)
# mv -f *.gcda $(COV_DIR)
	gcov -lprdfk $(TEST_SRC_DIR)/*.cpp -o $(COV_DIR)
#	mv -f *.gcov $(COV_DIR)
	lcov --exclude='$(INCLUDE_DIR)/*' --no-external --capture --directory . --output-file $(COV_DIR)/coverage.info
	mkdir -p $(COV_DIR)/report
	genhtml $(COV_DIR)/coverage.info --output-directory $(COV_DIR)/report

tests: 
	@echo " Running Tests"; 
	@echo " $(RM) -f $(TEST_TARGET)*"; $(RM) -f $(TEST_TARGET)*
	@mkdir -p $(BIN_DIR)
	@echo " $(CC) $(CFLAGS) --coverage $(TEST_SOURCES) $(LIB) -o $(TEST_TARGET)";$(CC) $(CFLAGS) --coverage $(TEST_SOURCES) $(LIB) -o $(TEST_TARGET)

check: 
	@echo " Valgrid check"; 
	@echo " valgrind -s --tool=memcheck --leak-check=yes --show-reachable=yes ./bin/app ./$(TEST_TARGET) $(argv)"; valgrind -s --tool=memcheck --leak-check=yes --show-reachable=yes ./bin/app ./$(TEST_TARGET) $(argv)


run: $(TARGET)
	@echo " Running App"; 
	@echo " ./$(TARGET) $(argv)"; ./$(TARGET) $(argv)

run-tests: tests
	@echo " Running Tests"; 
	@echo " ./$(TEST_TARGET)"; ./$(TEST_TARGET)
	

.PHONY: clean
