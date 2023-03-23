// `include "sine_gen.v"

module hosein_mokarian_bpsk_top(
		input [7 : 0] io_in,
		output [7 : 0] io_out
	);
	
	parameter SINE_SAMPLE_WIDTH = 8,
			  SINE_LUT_SIZE = 64;
	
	wire clk = io_in[0];
	wire rstn = io_in[1];
	wire en = io_in[2];
	wire d = io_in[3];
			  
	wire [(SINE_SAMPLE_WIDTH - 1) : 0] sine_wave;

	sine_gen 
		#(.WIDTH(SINE_SAMPLE_WIDTH), .SIZE(SINE_LUT_SIZE)) 
		sine_wave_gen(
			.clk(clk),
			.rstn(rstn),
			.en(en),
			.phase(d),
			.out(sine_wave)
		);
	
	assign io_out = sine_wave;

endmodule
