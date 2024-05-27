`timescale 1ns/1ns

module fir_shiftreg_tb();
  reg clk;
  reg rst;
  reg signed [7:0] xn;
  wire signed [10:0] filter_out;
  reg [7:0] in_mem [0:100] ;
  reg [7:0] count;
  // Instantiate the DA8 module
//  da8 uut (
//    .clk(clk),
//    .rst(rst),
//    .x0(x0),
//    .x1(x1),
//    .x2(x2),
//    .x3(x3),
//    .w0(8'b10101010), 
//    .w1(8'b11001100),
//    .w2(8'b11110000),
//    .w3(8'b11111111),
//    .filter_out(filter_out)
//  );

fir_shiftreg fir_dut(.clk(clk),.rst(rst),.xn(xn),.w0(8'b00000001),.w1(8'b00000001),.w2(8'b00000001),.w3(8'b00000001),.filter_out(filter_out));

  // Clock generation
  always begin
    #5 clk = ~clk;
  end
initial begin
$readmemb("input_values.mem", in_mem);
end
  // Reset generation
  initial begin
    clk = 0;
    rst = 1;
    
//    x0 = 8'b00000000;
//    x1 = 8'b00000001;
//    x2 = 8'b00000010;
//    x3 = 8'b00000011;

    // Apply reset
  
    #10 rst = 0;

    // Apply test inputs
//    x0 = 8'b00000000;
//    x1 = 8'b00000001;
//    x2 = 8'b00000010;
//    x3 = 8'b00000011;

    
    #100;

    // Display the filter output
    $display("filter_out = %d", filter_out);

    // Finish the simulation
    //$finish;
  end
  always @(posedge clk or posedge rst) begin
  if(rst) begin
  xn<=0;
  count = 0;
  end
  else begin
  count <= count+1;
    xn <= in_mem[count];
    //xn <= $urandom_range(5,0);
    end
  end
endmodule
