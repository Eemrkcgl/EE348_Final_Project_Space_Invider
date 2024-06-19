module enemy_spawn(
	input clk,
	input collision,	
	input [3:0] enemy_count,
	output reg spawn
);
	reg flag = 0;

	always @(posedge clk) begin
		if(enemy_count < 2 && ~flag && ~collision) begin
			spawn <= 1;
			flag <= 1;
		end
		else begin 
			spawn <= 0;
			flag <= 0;
		end
	end
endmodule
