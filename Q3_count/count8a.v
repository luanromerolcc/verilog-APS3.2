`timescale 1ns/1ps
`include "LIB.v"

module count8a (output wire [7:0] CNT, 
                input wire clk, res, EN, load,
                input wire [7:0] CNT_In);

wire [7:0] CNTn;
wire [7:0] reset_mux_out;
wire [7:0] preset_mux_out;
wire [7:0] d_mux_out;

MUX8_2T1A reset_mux(.F(reset_mux_out), .A({8{res}}), .B(CNT_In), .Sel(load));
MUX8_2T1A preset_mux(.F(preset_mux_out), .A(8'b11111111), .B(~CNT_In), .Sel(load));
MUX8_2T1A d_mux(.F(d_mux_out), .A(CNT), .B(CNTn), .Sel(EN));

dflipflop FF0 (.Q(CNT[0]), .Qn(CNTn[0]), .Clock(clk), .Reset(reset_mux_out[0]), .Preset(preset_mux_out[0]), .D(d_mux_out[0]));
dflipflop FF1 (.Q(CNT[1]), .Qn(CNTn[1]), .Clock(CNTn[0]), .Reset(reset_mux_out[1]), .Preset(preset_mux_out[1]), .D(d_mux_out[1]));
dflipflop FF2 (.Q(CNT[2]), .Qn(CNTn[2]), .Clock(CNTn[1]), .Reset(reset_mux_out[2]), .Preset(preset_mux_out[2]), .D(d_mux_out[2]));
dflipflop FF3 (.Q(CNT[3]), .Qn(CNTn[3]), .Clock(CNTn[2]), .Reset(reset_mux_out[3]), .Preset(preset_mux_out[3]), .D(d_mux_out[3]));
dflipflop FF4 (.Q(CNT[4]), .Qn(CNTn[4]), .Clock(CNTn[3]), .Reset(reset_mux_out[4]), .Preset(preset_mux_out[4]), .D(d_mux_out[4]));
dflipflop FF5 (.Q(CNT[5]), .Qn(CNTn[5]), .Clock(CNTn[4]), .Reset(reset_mux_out[5]), .Preset(preset_mux_out[5]), .D(d_mux_out[5]));
dflipflop FF6 (.Q(CNT[6]), .Qn(CNTn[6]), .Clock(CNTn[5]), .Reset(reset_mux_out[6]), .Preset(preset_mux_out[6]), .D(d_mux_out[6]));
dflipflop FF7 (.Q(CNT[7]), .Qn(CNTn[7]), .Clock(CNTn[6]), .Reset(reset_mux_out[7]), .Preset(preset_mux_out[7]), .D(d_mux_out[7]));

endmodule
