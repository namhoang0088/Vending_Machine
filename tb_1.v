`timescale 1ns / 1ps
module tb_1;

reg cen5;
reg cen10;
reg cen20;
reg clk;
reg reset;
reg item1;
reg item2;
reg item3;
reg item4;
reg [1:0] SL;
reg [1:0] lowpriece;
reg [1:0] uppriece1;
reg [1:0] uppriece2;
reg [5:0] slit1;
reg [5:0] slit2;
reg [5:0] slit3;
reg [5:0] slit4;
wire drop5;
wire drop10;
wire drop20;
wire [1:0] dropitem1;
wire [1:0] dropitem2;
wire [1:0] dropitem3;
wire [1:0] dropitem4;
wire [5:0] SLit1;
wire [5:0] SLit2;
wire [5:0] SLit3;
wire [5:0] SLit4;
maybanhang uut(drop5, drop10, drop20, dropitem1, dropitem2, dropitem3,dropitem4,SLit1 ,SLit2 ,SLit3 ,SLit4 , clk, reset, cen5 , cen10 , cen20 , item1 , item2 , item3 , item4, SL , lowpriece, uppriece1 , uppriece2 , slit1 , slit2 , slit3 , slit4);
initial  clk = 0;
	always #5 clk=~clk;


initial begin
clk=0;
cen5=0;
cen10=0;
cen20=0;
item1=0;
item2=0;
item3=0;
item4=0;
SL=0;
lowpriece=0;
uppriece1=1;
uppriece2=0;
slit1=10;
slit2=10;
slit3=10;
slit4=10;
reset=1;
#5 reset=0;
cen20=1;#10;
item1=1;#10;
SL=1;#10;
#50 $stop;
end

endmodule