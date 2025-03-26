module xory(output F, input A, B);

    wire wire1;
    wire wire1a;
    wire wire1b;
    
    nand(wire1, A,B);

    nand(wire1a, wire1, A);
    nand(wire1b, wire1, B);

    nand(F, wire1a, wire1b);

endmodule


module XOR8(output [7:0]F,
                    input [7:0] A, B);

    xory xor0(.F(F[0]), .A(A[0]), .B(B[0]));
    xory xor1(.F(F[1]), .A(A[1]), .B(B[1]));
    xory xor2(.F(F[2]), .A(A[2]), .B(B[2]));
    xory xor3(.F(F[3]), .A(A[3]), .B(B[3]));
    xory xor4(.F(F[4]), .A(A[4]), .B(B[4]));
    xory xor5(.F(F[5]), .A(A[5]), .B(B[5]));
    xory xor6(.F(F[6]), .A(A[6]), .B(B[6]));
    xory xor7(.F(F[7]), .A(A[7]), .B(B[7]));

endmodule

module ory( output F, input A, B);
    wire wire1;
    wire wire2;
    nand(wire1, A, A);
    nand(wire2, B, B);
    nand(F, wire1, wire2);
endmodule

module OR8( output [7:0]F
            , input [7:0] A, B);
    
    ory or0(.F(F[0]), .A(A[0]), .B(B[0]));
    ory or1(.F(F[1]), .A(A[1]), .B(B[1]));
    ory or2(.F(F[2]), .A(A[2]), .B(B[2]));
    ory or3(.F(F[3]), .A(A[3]), .B(B[3]));
    ory or4(.F(F[4]), .A(A[4]), .B(B[4]));
    ory or5(.F(F[5]), .A(A[5]), .B(B[5]));
    ory or6(.F(F[6]), .A(A[6]), .B(B[6]));
    ory or7(.F(F[7]), .A(A[7]), .B(B[7]));
endmodule

module noty( input  A,
                output  F);
    nand(F, A,A);

endmodule

module NOT8 (input wire [7:0] A,
                output wire [7:0] F);

    noty noty0(.A(A[0]), .F(F[0]));
    noty noty1(.A(A[1]), .F(F[1]));
    noty noty2(.A(A[2]), .F(F[2]));
    noty noty3(.A(A[3]), .F(F[3]));
    noty noty4(.A(A[4]), .F(F[4]));
    noty noty5(.A(A[5]), .F(F[5]));
    noty noty6(.A(A[6]), .F(F[6]));
    noty noty7(.A(A[7]), .F(F[7]));



endmodule

module andy( output F, input A , B);
    
    wire wire1;
    nand(wire1, A, B);
    nand(F, wire1, wire1);
    
endmodule


module AND8( output [7:0] F,
                input[7:0] A,B);
    
    andy and0(.F(F[0]), .A(A[0]), .B(B[0]));
    andy and1(.F(F[1]), .A(A[1]), .B(B[1]));
    andy and2(.F(F[2]), .A(A[2]), .B(B[2]));
    andy and3(.F(F[3]), .A(A[3]), .B(B[3]));
    andy and4(.F(F[4]), .A(A[4]), .B(B[4]));
    andy and5(.F(F[5]), .A(A[5]), .B(B[5]));
    andy and6(.F(F[6]), .A(A[6]), .B(B[6]));
    andy and7(.F(F[7]), .A(A[7]), .B(B[7]));
    
endmodule


module mux_2t1a(
	output wire F, 
	input wire A,B,
	input wire Sel);

	wire wire1;
	wire wire2;
	wire wire3;

	noty S1n(Sel, wire1);
	andy S1a1(wire2, wire1, A);
	andy S1a2(wire3, Sel, B);
	ory S1o1(F,wire3,wire2);






endmodule

module mux_4t1a(
	output wire F, 
	input wire A,B,C,D,
	input wire [1:0] Sel);

	wire wire1;
	wire wire2;
	

	mux_2t1a M1(.F(wire1), .A(A), .B(B),.Sel(Sel[0]));
	mux_2t1a M2(.F(wire2),.A(C),.B(D),.Sel(Sel[0]));
	mux_2t1a M3(.F(F),.A(wire1),.B(wire2),.Sel(Sel[1]));



endmodule


module MUX8_2T1A(
	output wire [7:0] F, 
	input wire [7:0]  A,B,
	input wire Sel);

	wire wire1;
	wire [7:0]  wire2;
	wire [7:0]  wire3;

	noty S1n(Sel, wire1);
	AND8 S1a1(.F(wire2), .A({8{wire1}}), .B(A));
	AND8 S1a2(.F(wire3), .B({8{Sel}}), .A(B));
	OR8 S1o1(.F(F),.A(wire3),.B(wire2));

endmodule


module HALFADDER(
    input wire A, B,
    output wire S, C);

    xory xor1(.F(S), .A(A), .B(B));
    andy and1(.F(C), .A(A), .B(B));

    endmodule


module FULLADDER(
    input wire A, B, Cin,
    output wire S, Cout);

    wire wirec;
    wire wires;
    wire wirec2;
    HALFADDER H1(.A(A), .B(B), .C(wirec), .S(wires));
    HALFADDER H2(.A(wires), .B(Cin), .C(wirec2), .S(S));
    ory or1(.A(wirec), .B(wirec2), .F(Cout));

    endmodule

module BIT8ADDER( input wire [7:0] A, B,
    input wire Cin,
    output wire [7:0] S, 
    output wire Cout, Overflow);

    wire wire0, wire1, wire2, wire3, wire4, wire5, wire6;

    FULLADDER F1(.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(wire0));
    FULLADDER F2(.A(A[1]), .B(B[1]), .Cin(wire0), .S(S[1]), .Cout(wire1));
    FULLADDER F3(.A(A[2]), .B(B[2]), .Cin(wire1), .S(S[2]), .Cout(wire2));
    FULLADDER F4(.A(A[3]), .B(B[3]), .Cin(wire2), .S(S[3]), .Cout(wire3));
    FULLADDER F5(.A(A[4]), .B(B[4]), .Cin(wire3), .S(S[4]), .Cout(wire4));
    FULLADDER F6(.A(A[5]), .B(B[5]), .Cin(wire4), .S(S[5]), .Cout(wire5));
    FULLADDER F7(.A(A[6]), .B(B[6]), .Cin(wire5), .S(S[6]), .Cout(wire6));
    FULLADDER F8(.A(A[7]), .B(B[7]), .Cin(wire6), .S(S[7]), .Cout(Cout));

    xory xor1( .A(wire6), .B(Cout), .F(Overflow));

endmodule

module DEMUX8_2T1A(
	output wire [7:0] F, G, 
	input wire [7:0]  A,
	input wire Sel);

	wire wire1;

	noty S1n(Sel, wire1);
	AND8 S1a1(.F(F), .B({8{wire1}}), .A(A));
	AND8 S1a2(.F(G), .A({8{Sel}}), .B(A));


endmodule

module DEMUX8_4T1A(
	output wire [7:0] W,X,Y,Z, 
	input wire [7:0] A,
	input wire [1:0] Sel);

	wire [7:0] wire1;
	wire [7:0] wire2;
	

	DEMUX8_2T1A M1(.F(wire1), .G(wire2), .A(A),.Sel(Sel[0]));
	
	DEMUX8_2T1A M2(.F(W),.G(X),.A(wire1),.Sel(Sel[1]));
	DEMUX8_2T1A M3(.F(Y),.G(Z),.A(wire2),.Sel(Sel[1]));
	



endmodule

module OR8bw( output F
            , input [7:0] A);
    

    wire w1,w2,w3,w4,w5,w6;
    ory orB0(.F(w1), .A(A[0]), .B(A[1]));
    ory orB1(.F(w2), .A(A[2]), .B(w1));
    ory orB2(.F(w3), .A(A[3]), .B(w2));
    ory orB3(.F(w4), .A(A[4]), .B(w3));
    ory orB4(.F(w5), .A(A[5]), .B(w4));
    ory orB5(.F(w6), .A(A[6]), .B(w5));
    ory orB6(.F(F), .A(A[7]), .B(w6));


endmodule

module MUX8_4T1A(
	output wire [7:0] F, 
	input wire [7:0] A,B,C,D,
	input wire [1:0] Sel);

	wire [7:0] wire1;
	wire [7:0] wire2;
	

	MUX8_2T1A M1(.F(wire1), .A(A), .B(B),.Sel(Sel[0]));
	MUX8_2T1A M2(.F(wire2),.A(C),.B(D),.Sel(Sel[0]));
	MUX8_2T1A M3(.F(F),.A(wire1),.B(wire2),.Sel(Sel[1]));



endmodule

module MUX8_8T1A(
	output wire [7:0] Y, 
	input wire [7:0] A,B,C,D,E,F,G,H,
	input wire [2:0] Sel);

	wire [7:0] wire1;
	wire [7:0] wire2;
	

	MUX8_4T1A M41(.F(wire1), .A(A), .B(B),.C(C),.D(D), .Sel(Sel[1:0]));
	MUX8_4T1A M42(.F(wire2), .A(E), .B(F),.C(G),.D(H), .Sel(Sel[1:0]));
	MUX8_2T1A M43(.F(Y), .A(wire1), .B(wire2), .Sel(Sel[2]));
	



endmodule

module mux_8t1a(
	output wire Y, 
	input wire A,B,C,D,E,F,G,H,
	input wire [2:0] Sel);

	wire  wire1;
	wire  wire2;
	

	mux_4t1a m41(.F(wire1), .A(A), .B(B),.C(C),.D(D), .Sel(Sel[1:0]));
	mux_4t1a m42(.F(wire2), .A(E), .B(F),.C(G),.D(H), .Sel(Sel[1:0]));
	mux_2t1a m43(.F(Y), .A(wire1), .B(wire2), .Sel(Sel[2]));
	



endmodule

module sub(
    output wire[7:0] S,
    input wire [7:0] A,B,
    input wire Cin,
    output wire Overflow, Cout);

    wire[7:0] wire1, wire2;
    wire carrysub;
    
    NOT8 subnot(.A(B) , .F(wire1));
    BIT8ADDER comp20(.S(wire2), .A(wire1), .B(8'b00000001), .Cin(1'b0));
    BIT8ADDER subd1(.Cout(carrysub), .Overflow(Overflow), .S(S), .A(A), .B(wire2), .Cin(1'b0));
    noty subnot2   (.A(carrysub), .F(Cout));


endmodule

module dlatch (output reg Q,Qn, 
               input wire C,D);
  
  always @ (C or D)
  	begin
  		if (C==1'b1)
  			begin
  				Q <= D;
  				Qn <= ~D;
  	    	end
  	end
  
endmodule

module dflipflop (output reg Q,Qn, 
                  input wire Clock, Reset, Preset, D);
  
  always @ (posedge Clock or negedge Reset or negedge Preset)
  	begin
	  	if (!Reset)
  			begin
  				Q <= 1'b0;
  				Qn <= 1'b1;
  			end
  		else if (!Preset)
  			begin
  				Q <= 1'b1;
  				Qn <= 1'b0;
  			end
  		else
  			begin
  				Q <= D;
  				Qn <= ~D;
  			end
	end
  
endmodule

