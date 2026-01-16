module dft4point (
    input  wire        clk,
    input  wire        reset,
    input  wire        start,
    input  wire signed [15:0] x0, x1, x2, x3,

    output reg signed [15:0] Xr0, Xr1, Xr2, Xr3,
    output reg signed [15:0] Xi0, Xi1, Xi2, Xi3,
    output reg        done
);

integer k, n;

reg signed [15:0] x [0:3];
reg signed [15:0] cosVal [0:3];
reg signed [15:0] sinVal [0:3];
reg signed [31:0] tempR, tempI;

initial begin
  cosVal[0] = 16'sd32767;  sinVal[0] = 16'sd0;
  cosVal[1] = 16'sd0;      sinVal[1] = 16'sd32767;
  cosVal[2] = -16'sd32767; sinVal[2] = 16'sd0;
  cosVal[3] = 16'sd0;      sinVal[3] = -16'sd32767;
end

always @(posedge clk or posedge reset) begin
  if (reset) begin
    done  <= 1'b0;
    Xr0 <= 0; Xr1 <= 0; Xr2 <= 0; Xr3 <= 0;
    Xi0 <= 0; Xi1 <= 0; Xi2 <= 0; Xi3 <= 0;
  end
  else if (start) begin

    x[0] <= x0;
    x[1] <= x1;
    x[2] <= x2;
    x[3] <= x3;

    for (k = 0; k < 4; k = k + 1) begin
      tempR = 32'sd0;
      tempI = 32'sd0;

      for (n = 0; n < 4; n = n + 1) begin
        tempR = tempR + (x[n] * cosVal[(k*n) % 4]);
        tempI = tempI - (x[n] * sinVal[(k*n) % 4]);
      end

      case (k)
        0: begin Xr0 <= tempR >>> 15; Xi0 <= tempI >>> 15; end
        1: begin Xr1 <= tempR >>> 15; Xi1 <= tempI >>> 15; end
        2: begin Xr2 <= tempR >>> 15; Xi2 <= tempI >>> 15; end
        3: begin Xr3 <= tempR >>> 15; Xi3 <= tempI >>> 15; end
      endcase
    end

    done <= 1'b1;
  end
end

endmodule
