module cg (
    output logic o_clk,
    input  logic i_clk,
    input  logic i_en
);

logic latched;

always_latch begin
    if (~i_clk) begin
        latched = i_en;
    end
end

assign o_clk = i_clk & latched;

endmodule
