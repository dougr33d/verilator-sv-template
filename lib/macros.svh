`define DFF(q,d,clk) always @(posedge clk) q <= d;
`define DFF_EN(q,d,clk,en) always @(posedge clk) if (en) q <= d;
