`include "LIB.v"

module reg8a (output wire [7:0] Reg_Out,
    input wire clk, res, EN,
    input wire [7:0] Reg_In);

    wire [7:0] muxwire;
    //muda entre receber novos dados e manter os antigos
    MUX8_2T1A mux (.F(muxwire), .A(Reg_Out),.B(Reg_In), .Sel(EN));

    //armazena
    dflipflop dff0 (.Q(Reg_Out[0]), .Qn(), .Clock(clk), .Reset(res), .Preset(1'b1), .D(muxwire[0]));
    dflipflop dff1 (.Q(Reg_Out[1]), .Qn(), .Clock(clk), .Reset(res), .Preset(1'b1), .D(muxwire[1]));
    dflipflop dff2 (.Q(Reg_Out[2]), .Qn(), .Clock(clk), .Reset(res), .Preset(1'b1), .D(muxwire[2]));
    dflipflop dff3 (.Q(Reg_Out[3]), .Qn(), .Clock(clk), .Reset(res), .Preset(1'b1), .D(muxwire[3]));
    dflipflop dff4 (.Q(Reg_Out[4]), .Qn(), .Clock(clk), .Reset(res), .Preset(1'b1), .D(muxwire[4]));
    dflipflop dff5 (.Q(Reg_Out[5]), .Qn(), .Clock(clk), .Reset(res), .Preset(1'b1), .D(muxwire[5]));
    dflipflop dff6 (.Q(Reg_Out[6]), .Qn(), .Clock(clk), .Reset(res), .Preset(1'b1), .D(muxwire[6]));
    dflipflop dff7 (.Q(Reg_Out[7]), .Qn(), .Clock(clk), .Reset(res), .Preset(1'b1), .D(muxwire[7]));

endmodule