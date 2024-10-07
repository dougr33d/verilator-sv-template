Verilator SV Template
==================

This repo has basic scaffolding for an Verilator project.

Useful files
------------

- `src/dut.sv` contains the DUT module, `dut`; most of your changes should go here.
- `src/top.sv` is the top module that instantiates `dut`.
- `tb_top.cpp` is the test bench that verilator uses to instantiate/drive `top`.

Pre-reqs
--------

You should install verilator, at minimum.  You also probably want gtkwave.

Commands
--------

Useful commands defined as make targets:

- `make Vtop` to compile
- `make run` to run your simulator
- `make gtkwave` to launch gtkwave

