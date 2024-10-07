#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#define FST 1
#ifdef FST
#include <verilated_fst_c.h>
#else
#include <verilated_vcd_c.h>
#endif
#include "Vtop.h"
#include "Vtop___024root.h"

#define MAX_SIM_TIME 50000
vluint64_t sim_time=0;

double sc_time_stamp() {
    return (double)sim_time;
}

int main(int argc, char** argv, char** env) {
    Vtop *dut = new Vtop;

    Verilated::traceEverOn(true);
    Verilated::commandArgs(argc, argv);
#ifdef FST
    VerilatedFstC* m_trace = new VerilatedFstC;
    dut->trace(m_trace, 5);
    m_trace->open("waves.fst");
#else
    VerilatedVcdC* m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waves.vcd");
#endif

    dut->rst = 1;

    while (sim_time < MAX_SIM_TIME && !Verilated::gotFinish()) {
        dut->clk ^= 1;
        if (sim_time == 20) {
            dut->rst = 0;
        }

        dut->eval();
        if (sim_time >= 10) {
            m_trace->dump(sim_time);
        }
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
