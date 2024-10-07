TOP_MODULE     := top
WAVES          := waves.fst
RTL_F          := rtl.f
RTL_FILES      := $(shell cat ${RTL_F})
LIB_DIR        := lib/
SRC_DIR        := src/

VERILATOR      := $(shell which verilator) -Wall -Wno-PINCONNECTEMPTY -Wno-UNUSEDSIGNAL -Wno-UNUSEDPARAM --assert --timing
VL_TRACE_FLAGS := --trace-fst --trace-structs --trace-params

VL_DEFINES     := +define+SIMULATION=1 +define+ASSERT=1 #+define+DEBUGON=1
VL_WAIVER_OUT  := --waiver-output new_waivers.txt

.PHONY: run
run: Vtop
	obj_dir/Vtop ${SIM_FLAGS} | tee run.log

Vtop: verilated
	make -C obj_dir -f Vtop.mk Vtop  -j 8

.PHONY: verilated
verilated: $(RTL_FILES)
	$(VERILATOR) $(VL_TRACE_FLAGS) --exe tb_top.cpp --cc -y $(LIB_DIR) -I$(SRC_DIR) -f $(RTL_F) $(VL_DEFINES) -o Vtop --top-module ${TOP_MODULE} #$(VL_WAIVER_OUT)

.PHONY: clean
clean:
	rm -rf obj_dir/
	rm -f ${WAVES}
	rm -f *.log

.PHONY: gtkwave
gtkwave:
	gtkwave ${WAVES}
