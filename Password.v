module Password(
	input [9:0] sw,
	input clk,
	input rst,
	output reg [9:0]led,
	output reg [0:6] HEX0, HEX1, HEX2, HEX3, HEX4
);

parameter 	IDLE = 0,
				ERROR = 1,
				PR_DIG = 2,
				SEG_DIG = 3,
				TER_DIG = 4,
				COMPLETE = 5;
				
reg [3:0] current_state;
reg [3:0] next_state;
wire clklento;
wire [9:0] button_oneshot;
wire rst_oneshot;

clock_divider #(.FREQ(2)) clkdiv_inst (
    .clk(clk),
    .rst(1'b0),       
    .clk_div(clklento)
);

genvar i;
generate
	for(i=0;i<10;i=i+1) 
	begin: one_shot_instanciado
		oneshot U(
			.clk(clklento),
			.button(sw[i]),
			
			.oneShot(button_oneshot[i])
		);
	end
endgenerate

oneshot rstone(
	.clk(clklento),
	.button(rst),
			
	.oneShot(rst_oneshot)
);
		


always @(posedge clklento or posedge rst_oneshot)
begin
	if(rst_oneshot)
		current_state <= IDLE;
	else
		current_state <= next_state;
end

			
always @(current_state, button_oneshot)
begin
	case(current_state)
		IDLE:
		begin
			if (button_oneshot == 0)
				next_state = IDLE;
			else 
			begin
				if (button_oneshot[2])
					next_state = PR_DIG;
				else
					next_state = ERROR;
			end
				
		end
		
		ERROR: 
		begin
			if (rst_oneshot)
				next_state = IDLE;
			else if (!button_oneshot)
				next_state = ERROR;
				
		end
		
		PR_DIG: 
		begin
			if (!button_oneshot)
				next_state = PR_DIG;
			else
			begin
				if (button_oneshot[0])
					next_state = SEG_DIG;
				else
					next_state = ERROR;
			end
		end
		
		SEG_DIG: 
		begin
			if (!button_oneshot)
				next_state = SEG_DIG;
			else
			begin
				if (button_oneshot[1])
					next_state = TER_DIG;
				else
					next_state = ERROR;
			end
		end
		
		TER_DIG: 
		begin
			if (!button_oneshot)
				next_state = TER_DIG;
			else
			begin
				if (button_oneshot[9])
					next_state = COMPLETE;
				else
					next_state = ERROR;
			end
		end

		COMPLETE:
		begin
			if (!button_oneshot)
				next_state = COMPLETE;
			else
				next_state = IDLE;
		end
		
	endcase
end

always @(current_state, button_oneshot)
begin
	case(current_state)
		IDLE: 
			begin
				led = 10'b00000_00000;
				
				HEX4 = 7'b1111_111;
            HEX3 = 7'b1111_111;
            HEX2 = 7'b1111_111;
            HEX1 = 7'b1111_111;
            HEX0 = 7'b1111_111;
			end
			
		
		ERROR:	
			begin
				led = 10'b10101_01010;
      
            HEX4 = 7'b0110_000;
            HEX3 = 7'b1111_010;
            HEX2 = 7'b1111_010;
            HEX1 = 7'b1100_010;
            HEX0 = 7'b1111_010;
			end
       
		PR_DIG:	led = 10'b11000_00011;
		SEG_DIG:	led = 10'b11100_00111;
		TER_DIG:	led = 10'b11110_01111;
		COMPLETE:
			begin
				led = 10'b11111_11111;
				
            HEX4 = 7'b1111_111;
            HEX3 = 7'b1000_010;
            HEX2 = 7'b1100_010;
            HEX1 = 7'b1101_010;
            HEX0 = 7'b0110_000;
			end
			
	endcase
end

endmodule