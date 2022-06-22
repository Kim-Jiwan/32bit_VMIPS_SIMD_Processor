module aluCtrl (input [2:0] alu_op,
				output reg [2:0] aluCtrl);
	always @(*) begin
		case(alu_op)
			//3'b000: aluCtrl = (inst!=6'b100000) ? ((inst!=6'b001000) ? ((inst!=6'b100010) ? ((inst!=6'b100100) ? ((inst!=6'b100101) ? ((inst!=6'b101010) ? inst[2:0] : 3'b100) : 3'b011) : 3'b010) : 3'b001) : 3'b110) : 3'b000;
			3'b000: aluCtrl = (inst==6'b011110) ? 3'b000 : 3'b100; //"MSA" integer_data_format check
			//3'b11: aluCtrl = 3'b000; //add
			3'b001: aluCtrl = 3'b001; //sub
			//3'b10: aluCtrl = 3'b100; //
		endcase
	end

endmodule
