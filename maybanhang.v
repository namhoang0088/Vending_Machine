module maybanhang(output reg drop5 , drop10 , drop20 ,output reg [1:0] dropitem1 , dropitem2 , dropitem3 , dropitem4 , output reg [5:0] SLit1 , SLit2 , SLit3 , SLit4 ,
input clk, reset , cen5 , cen10 , cen20 , item1 , item2 , item3 , item4 , input [1:0] SL , lowpriece ,  uppriece1 , uppriece2 , input [5:0] slit1 , slit2 , slit3 , slit4 );  

reg[6: 0] state, next_state; 

 
parameter S0 = 1, S5 = 2, S10 = 3, S20 = 4, IT1 = 5, IT2 = 6, IT3 = 7 , IT4 = 8 , SL1 = 9 , SL2 = 10;

reg Drop5 , Drop10 , Drop20 , Dropitem1 , Dropitem2 , Dropitem3 , Dropitem4;
always @ (negedge clk ) 
if (reset == 1) state <= S0; 
else state <= next_state; 
always @ (cen5 , cen10 , cen20 , item1 , item2 , item3 , item4 , SL , lowpriece, uppriece1, uppriece2, slit1 , slit2 , slit3 , slit4 ) begin 
case (state ) 
S0: if(cen5) next_state=S5;
    else if(cen10) next_state=S10;
	 else if(cen20) next_state=S20;
	 else next_state=S0;
S5: if(item1) next_state=IT1;
    else if(item2) next_state=IT2;
	 else if(item3) next_state=IT3;
	 else if(item4) next_state=IT4;
	 else next_state=S5;
S10: if(item1) next_state=IT1;
    else if(item2) next_state=IT2;
	 else if(item3) next_state=IT3;
	 else if(item4) next_state=IT4;
	 else next_state=S10;
S20: if(item1) next_state=IT1;
    else if(item2) next_state=IT2;
	 else if(item3) next_state=IT3;
	 else if(item4) next_state=IT4;
	 else next_state=S20;
IT1: if(SL==1) next_state=SL1;
     else if(SL==2) next_state=SL2;
	  else next_state=IT1;
IT2: if(SL==1) next_state=SL1;
     else if(SL==2) next_state=SL2;
	  else next_state=IT2;
IT3: if(SL==1) next_state=SL1;
     else if(SL==2) next_state=SL2;
	  else next_state=IT3;
IT4: if(SL==1) next_state=SL1;
     else if(SL==2) next_state=SL2;
	  else next_state=IT4;	  
SL1: if(reset==1) next_state=S0;
     else next_state=SL1;
SL2: if(reset==1) next_state=S0;
     else next_state=SL2;

endcase
end
always @ (negedge clk) begin 
	 drop5 <= 0 ; 
    drop10 <= 0; 
	 drop20 <= 0; 
	 dropitem1 <= 0 ; 
	 dropitem2 <= 0 ; 
	 dropitem3 <= 0 ; 
	 dropitem4 <= 0;
	 SLit1<=slit1;
	 SLit2<=slit2;
	 SLit3<=slit3;
	 SLit4<=slit4;
    case(state) 
S0: begin 
    drop5 <= 0 ; 
    drop10 <= 0; 
	 drop20 <= 0; 
	 dropitem1 <= 0 ; 
	 dropitem2 <= 0 ; 
	 dropitem3 <= 0 ; 
	 dropitem4 <= 0;
	 Drop5 <= 0 ; 
    Drop10 <= 0; 
	 Drop20 <= 0; 
	 Dropitem1 <= 0 ; 
	 Dropitem2 <= 0 ; 
	 Dropitem3 <= 0 ; 
	 Dropitem4 <= 0;
    end
S5:begin 
    Drop5 <= 1 ; 
    end 
S10:begin 
    Drop10 <= 1; 
    end	
S20:begin 
	 Drop20 <= 1; 
    end 
IT1: begin
    Dropitem1 <= 1 ;  
	 end
IT2:	begin
    Dropitem2 <= 1 ;  
	 end 
IT3: begin
    Dropitem3 <= 1 ;  
	 end	 
IT4: begin
    Dropitem4 <= 1 ;  
	 end	 
SL1: begin
	 
	 if(Drop5 == 1 && Dropitem1 == 1) 
	 begin
	 if(uppriece1==0 || uppriece1==2) begin
	 drop5<=0;
	 dropitem1<=1;
	 SLit1<=slit1-1;
	 end
	 else if(uppriece1==1 || uppriece1==3) begin
	 drop5<=1;
	 dropitem1<=0;
	 end
	 end
	 
	 else if(Drop10==1 && Dropitem1 == 1) 
	 begin
	 if(uppriece1==0 || uppriece1==2) begin
	 drop10<=0;
	 drop5<=1;
	 dropitem1<=1;
	 SLit1<=slit1-1;
	 end
	 else if(uppriece1==1 || uppriece1==3) begin
	 drop10<=0;
	 drop5<=0;
	 dropitem1<=1;
	 SLit1<=slit1-1;
	 end
	 end
	 
	 else if(Drop20==1 && Dropitem1 ==1)
	 begin
	 if(uppriece1==0 || uppriece1==2) begin
	 drop5<=1;
	 drop10<=1;
	 dropitem1<=1;
	 SLit1<=slit1-1;
	 end
	 else if(uppriece1==1 || uppriece1==3) begin
	 drop5<=0;
	 drop10<=1;
	 dropitem1<=1;
	 SLit1<=slit1-1;
	 end
	 end
	 
	 else if(Drop5 == 1 && Dropitem2 == 1) 
	 begin
	 if(uppriece1==0 || uppriece1==1) begin
	 drop5<=0;
	 dropitem2<=1;
	 SLit2<=slit2-1;
	 end
	 else if(uppriece1==2 || uppriece1==3) begin
	 drop5<=1;
	 dropitem2<=0;
	 end
	 end
	 
	 else if(Drop10==1 && Dropitem2 == 1) 
	 begin
	 if(uppriece1==0 || uppriece1==1) begin
	 drop10<=0;
	 drop5<=1;
	 dropitem2<=1;
	 SLit2<=slit2-1;
	 end
	 else if(uppriece1==2 || uppriece1==3) begin
	 drop10<=0;
	 drop5<=0;
	 dropitem2<=1;
	 SLit2<=slit2-1;
	 end
	 end
	 
	 else if(Drop20==1 && Dropitem2 ==1)
	 begin
	 if(uppriece1==0 || uppriece1==1) begin
	 drop5<=1;
	 drop10<=1;
	 dropitem2<=1;
	 SLit2<=slit2-1;
	 end
	 else if(uppriece1==2 || uppriece1==3) begin
	 drop5<=0;
	 drop10<=1;
	 dropitem2<=1;
	 SLit2<=slit2-1;
	 end
	 end	 
	 
	 else if(Drop5 == 1 && Dropitem3 == 1) 
	 begin
	 if((uppriece2==0 || uppriece2==2) && (lowpriece==0 ||lowpriece==2)) begin
	 drop5<=1;
	 dropitem3<=0;
	 end
	 else if((uppriece2==1 || uppriece2==3) && (lowpriece==0 ||lowpriece==2)) begin
	 drop5<=1;
	 dropitem3<=0;
	 end
	 else if((uppriece2==0 || uppriece2==2) && (lowpriece==1 ||lowpriece==3)) begin
	 drop5<=0;
	 dropitem3<=1;
	 SLit3<=slit3-1;
	 end
	 end

	 else if(Drop10==1 && Dropitem3 == 1) 
	 begin
	 if((uppriece2==0 || uppriece2==2) && (lowpriece==0 ||lowpriece==2)) begin
	 drop10<=0;
	 dropitem3<=1;
	 SLit3<=slit3-1;
	 end
	 else if((uppriece2==1 || uppriece2==3) && (lowpriece==0 ||lowpriece==2)) begin
	 drop10<=1;
	 dropitem3<=0;
	 end
	 else if((uppriece2==0 || uppriece2==2) && (lowpriece==1 ||lowpriece==3)) begin
	 drop5<=1;
	 dropitem3<=1;
	 SLit3<=slit3-1;
	 end
	 end
	 
	 else if(Drop20==1 && Dropitem3 ==1)
	 begin
	 if((uppriece2==0 || uppriece2==2) && (lowpriece==0 ||lowpriece==2)) begin
	 drop10<=1;
	 dropitem3<=1;
	 SLit3<=slit3-1;
	 end
	 else if((uppriece2==1 || uppriece2==3) && (lowpriece==0 ||lowpriece==2)) begin
	 drop5<=1;
	 dropitem3<=1;
	 SLit3<=slit3-1;
	 end
	 else if((uppriece2==0 || uppriece2==2) && (lowpriece==1 ||lowpriece==3)) begin
	 drop5<=1;
	 drop10<=1;
	 dropitem3<=1;
	 SLit3<=slit3-1;
	 end
	 end	 
	 
	 else if(Drop5 == 1 && Dropitem4 == 1) 
	 begin
	 if((uppriece2==0 || uppriece2==1) && (lowpriece==0 ||lowpriece==1)) begin
	 drop5<=1;
	 dropitem4<=0;
	 end
	 else if((uppriece2==2 || uppriece2==3) && (lowpriece==0 ||lowpriece==1)) begin
	 drop5<=1;
	 dropitem4<=0;
	 end
	 else if((uppriece2==0 || uppriece2==1) && (lowpriece==2 ||lowpriece==3)) begin
	 drop5<=0;
	 dropitem4<=1;
	 SLit4<=slit4-1;
	 end
	 end
	 
	 else if(Drop10==1 && Dropitem4 == 1) 
	 begin
	 if((uppriece2==0 || uppriece2==1) && (lowpriece==0 ||lowpriece==1)) begin
	 drop10<=0;
	 dropitem4<=1;
	 SLit4<=slit4-1;
	 end
	 else if((uppriece2==2 || uppriece2==3) && (lowpriece==0 ||lowpriece==1)) begin
	 drop10<=1;
	 dropitem4<=0;
	 end
	 else if((uppriece2==0 || uppriece2==1) && (lowpriece==2 ||lowpriece==3)) begin
	 drop5<=1;
	 dropitem4<=1;
	 SLit4<=slit4-1;
	 end
	 end
	 
	 else if(Drop20==1 && Dropitem4 ==1)
	 begin
	 if((uppriece2==0 || uppriece2==1) && (lowpriece==0 ||lowpriece==1)) begin
	 drop10<=1;
	 dropitem4<=1;
	 SLit4<=slit4-1;
	 end
	 else if((uppriece2==2 || uppriece2==3) && (lowpriece==0 ||lowpriece==1)) begin
	 drop5<=1;
	 dropitem4<=1;
	 SLit4<=slit4-1;
	 end
	 else if((uppriece2==0 || uppriece2==1) && (lowpriece==2 ||lowpriece==3)) begin
	 drop5<=1;
	 drop10<=1;
	 dropitem4<=1;
	 SLit4<=slit4-1;
	 end
	 end	
	
	
	end
SL2: 	begin
  	 if(Drop5 == 1 && Dropitem1 == 1) 
	 begin
	 if(uppriece1==0 || uppriece1==2) begin
	 drop5<=1;
	 dropitem1<=0;
	 end
	 else if(uppriece1==1 || uppriece1==3) begin
	 drop5<=1;
	 dropitem1<=0;
	 end
	 end
	 
	 else if(Drop10==1 && Dropitem1 == 1) 
	 begin
	 if(uppriece1==0 || uppriece1==2) begin
	 drop10<=0;
	 drop5<=0;
	 dropitem1<=2;
	 SLit1<=slit1-2;
	 end
	 else if(uppriece1==1 || uppriece1==3) begin
	 drop10<=1;
	 drop5<=0;
	 dropitem1<=0;
	 end
	 end
	 
	 else if(Drop20==1 && Dropitem1 ==1)
	 begin
	 if(uppriece1==0 || uppriece1==2) begin
	 drop5<=0;
	 drop10<=1;
	 dropitem1<=2;
	 SLit1<=slit1-2;
	 end
	 else if(uppriece1==0 || uppriece1==2) begin
	 drop5<=0;
	 drop10<=0;
	 dropitem1<=2;
	 SLit1<=slit1-2;
	 end
	 end
	 
	 else if(Drop5 == 1 && Dropitem2 == 1) 
	 begin
	 if(uppriece1==0 || uppriece1==1) begin
	 drop5<=1;
	 dropitem2<=0;
	 end
	 else if(uppriece1==2 || uppriece1==3) begin
	 drop5<=1;
	 dropitem2<=0;
	 end
	 end
	 
	 else if(Drop10==1 && Dropitem2 == 1) 
	 begin
	 if(uppriece1==0 || uppriece1==1) begin
	 drop10<=0;
	 drop5<=0;
	 dropitem2<=2;
	 SLit2<=slit2-2;
	 end
	 else if(uppriece1==2 || uppriece1==3) begin
	 drop10<=1;
	 drop5<=0;
	 dropitem2<=0;
	 end
	 end
	 
	 else if(Drop20==1 && Dropitem2 ==1)
	 begin
	 if(uppriece1==0 || uppriece1==1) begin
	 drop5<=0;
	 drop10<=1;
	 dropitem2<=2;
	 SLit2<=slit2-2;
	 end
	 else if(uppriece1==2 || uppriece1==3) begin
	 drop5<=0;
	 drop10<=0;
	 dropitem2<=2;
	 SLit2<=slit2-2;
	 end
	 end	 
	 
	 else if(Drop5 == 1 && Dropitem3 == 1) 
	 begin
	 if((uppriece2==0 || uppriece2==2) && (lowpriece==0 ||lowpriece==2)) begin
	 drop5<=1;
	 dropitem3<=0;
	 end
	 else if((uppriece2==1 || uppriece2==3) && (lowpriece==0 ||lowpriece==2)) begin
	 drop5<=1;
	 dropitem3<=0;
	 end
	 else if((uppriece2==0 || uppriece2==2) && (lowpriece==1 ||lowpriece==3)) begin
	 drop5<=1;
	 dropitem3<=0;
	 end
	 end

	 else if(Drop10==1 && Dropitem3 == 1) 
	 begin
	 if((uppriece2==0 || uppriece2==2) && (lowpriece==0 ||lowpriece==2)) begin
	 drop10<=1;
	 dropitem3<=0;
	 end
	 else if((uppriece2==1 || uppriece2==3) && (lowpriece==0 ||lowpriece==2)) begin
	 drop10<=1;
	 dropitem3<=0;
	 end
	 else if((uppriece2==0 || uppriece2==2) && (lowpriece==1 ||lowpriece==3)) begin
	 drop10<=0;
	 dropitem3<=2;
	 SLit2<=slit2-2;
	 end
	 end
	 
	 else if(Drop20==1 && Dropitem3 ==1)
	 begin
	 if((uppriece2==0 || uppriece2==2) && (lowpriece==0 ||lowpriece==2)) begin
	 dropitem3<=2;
	 SLit3<=slit3-2;
	 end
	 else if((uppriece2==1 || uppriece2==3) && (lowpriece==0 ||lowpriece==2)) begin
	 drop20<=1;
	 dropitem3<=0;
	 end
	 else if((uppriece2==0 || uppriece2==2) && (lowpriece==1 ||lowpriece==3)) begin
	 drop10<=1;
	 dropitem3<=2;
	 SLit3<=slit3-2;
	 end
	 end	 
	 
	 else if(Drop5 == 1 && Dropitem4 == 1) 
	 begin
	 if((uppriece2==0 || uppriece2==1) && (lowpriece==0 ||lowpriece==1)) begin
	 drop5<=1;
	 dropitem4<=0;
	 end
	 else if((uppriece2==2 || uppriece2==3) && (lowpriece==0 ||lowpriece==1)) begin
	 drop5<=1;
	 dropitem4<=0;
	 end
	 else if((uppriece2==0 || uppriece2==1) && (lowpriece==2 ||lowpriece==3)) begin
	 drop5<=1;
	 dropitem4<=0;
	 end
	 end
	 
	 else if(Drop10==1 && Dropitem4 == 1) 
	 begin
	 if((uppriece2==0 || uppriece2==1) && (lowpriece==0 ||lowpriece==1)) begin
	 drop10<=1;
	 dropitem4<=0;
	 end
	 else if((uppriece2==2 || uppriece2==3) && (lowpriece==0 ||lowpriece==1)) begin
	 drop10<=1;
	 dropitem4<=0;
	 end
	 else if((uppriece2==0 || uppriece2==1) && (lowpriece==2 ||lowpriece==3)) begin
	 drop10<=0;
	 dropitem4<=2;
	 SLit4<=slit4-2;
	 end
	 end
	 
	 else if(Drop20==1 && Dropitem4 ==1)
	 begin
	 if((uppriece2==0 || uppriece2==1) && (lowpriece==0 ||lowpriece==1)) begin
	 dropitem4<=2;
	 SLit4<=slit4-2;
	 end
	 else if((uppriece2==2 || uppriece2==3) && (lowpriece==0 ||lowpriece==1)) begin
	 drop20<=1;
	 dropitem4<=0;
	 end
	 else if((uppriece2==0 || uppriece2==1) && (lowpriece==2 ||lowpriece==3)) begin
	 drop10<=1;
	 dropitem4<=2;
	 SLit4<=slit4-2;
	 end
	 end	
	 
	 end
	
	 endcase
end

 endmodule
 