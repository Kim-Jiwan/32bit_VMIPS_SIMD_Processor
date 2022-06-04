module vmips_top_tb();

    reg     [31:0]      PC;
    reg                 clk;
    reg                 rst;

    wire    [31:0]      nPC

    vmips_top u0(   .PC     (PC),
                    .clk    (clk),
                    .rst    (rst),
                    .nPC    (nPC)   );


    always #1 begin
        if (current_inst !== 32'hxxxx_xxxx) begin
            
        end
        
    end


endmodule