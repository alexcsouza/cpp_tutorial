CC := g++ # This is the main compiler

SRCDIR := src
TESTSRCDIR := test
BUILDDIR := build
BINDIR := bin
COVDIR := coverage
TESTTARGET := $(BINDIR)/tests
TARGET := $(BINDIR)/app
SRCEXT := cpp
MAIN:=$(SRCDIR)/main.$(SRCEXT)
SOURCES := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
TESTSOURCES := $(shell find $(TESTSRCDIR) -type f -name *.$(SRCEXT))
OBJECTS := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.o))
CFLAGS := -g # -Wall
LIB := #-pthread -lmongoclient -L lib -lboost_thread-mt -lboost_filesystem-mt -lboost_system-mt
INC := -I include

$(TARGET): clean $(OBJECTS)
	@echo " Linking"; 
	@echo " $(CC) build/main.o -o $(TARGET) $(LIB)"; $(CC) build/main.o -o $(TARGET) $(LIB)

$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT) 
	@echo " Building"
	@mkdir -p $(BUILDDIR)
	@mkdir -p $(BINDIR)
	@echo " $(CC) $(CFLAGS) -c $< $(INC) -o $@ "; $(CC) $(CFLAGS) -c $< $(INC) -o $@

clean:
	@echo " Running Clean"; 
	@echo " $(RM) -r -f $(BUILDDIR) $(BINDIR) $(COVDIR)"; $(RM) -r $(BUILDDIR) $(BINDIR) $(COVDIR)
	@echo " $(RM) -f *.gcno"; $(RM) -f *.gcno
	@echo " $(RM) -f *.gcda"; $(RM) -f *.gcda
	
coverage: run-tests
	@echo " Running Coverage"; 
	@mkdir -p $(COVDIR)
	@gcov -lpr $(TESTSRCDIR)/*.cpp -o $(COVDIR)
	@mv *.gcno $(COVDIR)
	@mv *.gcda $(COVDIR)
	@mv *.gcov $(COVDIR)
	lcov --no-external --capture --directory . --output-file $(COVDIR)/coverage.info
	genhtml $(COVDIR)/coverage.info --output-directory $(COVDIR)

tests: 
	@echo " Running Tests"; 
	@echo " $(RM) -f $(TESTTARGET)*"; $(RM) -f $(TESTTARGET)*
	@mkdir -p $(BINDIR)
	@echo " $(CC) $(CFLAGS) --coverage $(TESTSOURCES) $(INC) $(LIB) -o $(TESTTARGET)";$(CC) $(CFLAGS) --coverage $(TESTSOURCES) $(INC) $(LIB) -o $(TESTTARGET)
	
run: $(TARGET)
	@echo " Running App"; 
	@echo " ./$(TARGET) $(argc)"; ./$(TARGET) $(argc)

run-tests: tests
	@echo " Running Tests"; 
	@echo " ./$(TESTTARGET)"; ./$(TESTTARGET)
	

.PHONY: clean
