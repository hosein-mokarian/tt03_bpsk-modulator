
module sine_gen
	#(parameter WIDTH = 8,
	  parameter SIZE = 64
	)(
		input clk,
		input rstn,
		input en,
		input phase,
		output [(WIDTH - 1) : 0] out
	);
	
	reg [7 : 0] index = 0; 
	reg [(WIDTH - 1) : 0] rom_memory [0 : (SIZE - 1)];
	
	initial begin
		$readmemh("sine.mem", rom_memory);
	end
	
	always @(posedge clk) 
	begin
		if (!rstn)
			index <= 0;
		else if (rstn & en)
			if (!phase)
				if (index == 0)
					index <= SIZE - 1;
				else
					index <= index - 1;
			else
				if (index == SIZE - 1)
					index <= 0;
				else
					index <= index + 1;		
	end
	
	assign out = (rstn & en) ? rom_memory[index] : 8'hz;

endmodule
