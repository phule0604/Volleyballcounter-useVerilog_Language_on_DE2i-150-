module tinhdiem(score_A,score_B,unit_A,unit_B,win,clk,
						reset,sel,outAhangchuc,outAhangdonvi,outBhangchuc,outBhangdonvi,
						outunitA,outunitB,
						LCD_RW,LCD_EN,LCD_RS,LCD_DATA,iCLK,iRST_N);

output [0:6] outAhangchuc,outAhangdonvi,outBhangchuc,outBhangdonvi,outunitA,outunitB;

input [1:0] sel;

input clk,reset,iCLK,iRST_N;

output reg [6:0] score_A,score_B;

output reg [1:0] unit_A,unit_B;

output reg [1:0] win;

output	[7:0]	LCD_DATA;

output			LCD_RW,LCD_EN,LCD_RS;

wire [3:0] score_A_hangchuc,score_A_hangdonvi,score_B_hangchuc,score_B_hangdonvi,ra_unitA,ra_unitB;

wire ra_win;

always @(posedge clk)
	
	begin
	
	if (reset==1) begin score_A<=0;score_B<=0;unit_A<=0;unit_B<=0;win<=2; end
	
	else
		
		begin
		
		if (sel==0) score_A<=score_A+1;
			
			else if (sel==1) score_B<=score_B+1;
				
				else if (sel==2) score_A<=score_A-1;
				
					else if (sel==3) score_B<=score_B-1;
		
		if ((score_A==25)&&(score_A - 2 >= score_B )) begin unit_A<=unit_A+1 ;score_A<=0;score_B<=0; end 
			
			else if ((score_A>25)&&(score_A-score_B==2)) begin unit_A<=unit_A+1 ;score_A<=0;score_B<=0; end 
				
				else if ((score_B==25)&&(score_B- 2 >=score_A)) begin unit_B<=unit_B+1 ;score_A<=0;score_B<=0; end
					
					else if ((score_B>25)&&(score_B-score_A == 2)) begin unit_B<=unit_B+1 ;score_A<=0;score_B<=0; end
		
		
		if (unit_A == 3 ) begin  win <= 0; end
		
			else if (unit_B == 3 ) begin  win <= 1; end
				
				//else begin win <= 0 ; end 
		
		end
	
	end
	
assign score_A_hangchuc 	= 	score_A/10;
assign score_A_hangdonvi 	= 	score_A%10;  
assign score_B_hangchuc 	=	score_B/10;
assign score_B_hangdonvi	=	score_B%10;
assign ra_unitA				=	unit_A;
assign ra_unitB				=	unit_B;
assign ra_win 					= 	win;
ra7 k1(.in(score_A_hangchuc),.out(outAhangchuc));
ra7 k2(.in(score_A_hangdonvi),.out(outAhangdonvi));
ra7 k3(.in(score_B_hangchuc),.out(outBhangchuc));
ra7 k4(.in(score_B_hangdonvi),.out(outBhangdonvi));
ra7 k5(.in(ra_unitA),.out(outunitA));
ra7 k6(.in(ra_unitB),.out(outunitB));
LCD_TEST k7(	//	Host Side
					.iCLK(iCLK),.iRST_N(iRST_N),.Team_Win(ra_win),
					//	LCD Side
					.LCD_DATA(LCD_DATA),.LCD_RW(LCD_RW),.LCD_EN(LCD_EN),.LCD_RS(LCD_RS)	);
endmodule
