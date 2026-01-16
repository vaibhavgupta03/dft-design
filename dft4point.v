// Designing a dft filter for N=4 by taking the first four points of the DFT matrix

module dft4point ( input wire clk, input wire reset, input wire start, input wire signed [15:0] x0, x1, x2, x3,
                  output reg signed [15:0] Xr [0:3],output reg signed [15:0] Xi [0:3] , output reg done);

input k,n;

reg signed [15:0] x[0:3];
reg signed [15:0] cosVal[0:3];
reg signed [15:0] sinVal[0:3];
reg signed [31:0] tempR, tempI;

always @(*) begin
  cosVal[0] = 16'sd32767; sinVal[0] = 16'sd0;
  cosVal[1] = 16'sd0; sinVal[1] = 16'sd32767;
  cosVal[2] = -16'sd32767; sinVal[2] = 16'sd0;
  cosVal[3] = 16'sd0; sinVal[3] = -16'sd32767;
end



endmodule