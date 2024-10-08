`ifndef DUT_SV
`define DUT_SV

////////////////////////////////////////
// DUT /////////////////////////////////
//                                    //
// Go out and do something wonderful. //
//                                    //
////////////////////////////////////////

`include "macros.svh"
`include "genlib.svh"

module dut
    import genlib::find_first_funcs;
(
    input logic ck,
    input logic rst
);

////////////////////////////////////////
// Nets ////////////////////////////////
////////////////////////////////////////

logic[15:0] counter, counter_nxt;

////////////////////////////////////////
// Logic ///////////////////////////////
////////////////////////////////////////

assign counter_nxt = rst ? '0 : (counter + 1);
`DFF(counter, counter_nxt, ck);

logic ckqtr;
logic qtr_en;

assign qtr_en = ~|counter[1:0];
cg cgqtr (ckqtr, ck, qtr_en);

logic[15:0] foobar;
`DFF(foobar, counter, ckqtr)

logic[15:0] ff;
assign ff = find_first_funcs#(.WIDTH(16))::find_first1(foobar);

////////////////////////////////////////
// SVAs ////////////////////////////////
////////////////////////////////////////

endmodule

`endif // DUT_SV
