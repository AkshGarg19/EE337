#include <at89c5131.h>
#include "endsem.h"


char S_str[6]= {0,0,0,0,0,0};   //String for Balance Sita
char G_str[6] = {0,0,0,0,0,0};  //String for Balance Gita
char n500_s[3]= {0,0,0};    // STRING FOR 500RS NOTE
char n100_s[3]= {0,0,0};    // STRING FOR 100RS NOTE

char password[5] = {0,0,0,0,0} ;   //PASSWORD ARRAY
//Main function

//-------------------------------------------------
void main(void)
{
	unsigned char ch=0;
	unsigned char ch2=0;
	unsigned char ch3=0;
	unsigned char ch4=0;
	char name1[5]={'S','i','t','a','\0'};
	char name2[5]={'G','i','t','a','\0'};
	char balance1[6]={0,0,0,0,0,'\0'};
	char balance2[6]={0,0,0,0,0,'\0'};
	unsigned int bal_1 = 10000;
	unsigned int bal_2 = 10000;
	unsigned int val_1=0;
	unsigned int val_2=0;
	unsigned int five_notes=0;
	unsigned int one_notes=0;
	char five[6] = {0,0,0,0,0,'\0'};
	char one[6] = {0,0,0,0,0,'\0'};
	P1 = 0x0F;
	uart_init();            // Please finish this function in endsem.h 
    while (1)
    {
      transmit_string("Press A for Account display and W for withdrawing cash\r\n");
			ch = receive_char();
			switch(ch)
			{
				
				
				case 'a':
								 transmit_string("Hello, Please enter Account Number\r\n");
				         ch2 = receive_char();
				         switch(ch2)
								 {
									 case '1':
									  int_to_string(bal_1,balance1);
					          transmit_string("Account Holder: ");
				          	transmit_string(name1);
			           		transmit_string("\r\n");
				           	transmit_string("Account Balance: ");
			           		transmit_string(balance1);
			          		transmit_string("\r\n");
			          		transmit_string("\r\n");
			        		  break;
									 
									 case '2':
									  int_to_string(bal_2,balance2);
					          transmit_string("Account Holder: ");
				          	transmit_string(name2);
			           		transmit_string("\r\n");
				           	transmit_string("Account Balance: ");
			           		transmit_string(balance2);
			          		transmit_string("\r\n");
			          		transmit_string("\r\n");
			        		  break;
									 
					         default:transmit_string("No such account, please enter valid details\r\n");
								           break; 
								 }
								 break;
				case 'w':
								 transmit_string("Withdraw state, enter account number\r\n");
				         ch2 = receive_char();
				         switch(ch2)
								 {
									 case '1':
									  int_to_string(bal_1,balance1);
					          transmit_string("Account Holder: ");
				          	transmit_string(name1);
			           		transmit_string("\r\n");
				           	transmit_string("Account Balance: ");
			           		transmit_string(balance1);
			          		transmit_string("\r\n");
			          		transmit_string("\r\n");
									  transmit_string("Enter Amount, in hundreds\r\n");
									  ch3 = receive_char();
									  ch4 = receive_char();
									  if((ch3=='0' || ch3=='1' || ch3=='2' || ch3=='3' || ch3=='4' || ch3=='5' || ch3=='6' || ch3=='7' || ch3=='8' || ch3=='9') && (ch4=='0' || ch4=='1' || ch4=='2' || ch4=='3' || ch4=='4' || ch4=='5' || ch4=='6' || ch4=='7' || ch4=='8' || ch4=='9')){
											  val_1 = (int)ch4 - 48;
	     								  val_2 = val_1 * 100;
										    val_1 = (int)ch3 - 48;
										    val_2 = val_2 + val_1*1000;
			    						  five_notes = val_2 / 500;
				    					  one_notes = val_2 % 500;
										    one_notes = one_notes / 100;
										    if(val_2 > bal_1){
													transmit_string("Insufficient Balance\r\n");
													continue;
												}
										    bal_1 = bal_1 - val_2;
										    int_to_string(bal_1,balance1);
						     			  int_to_string(five_notes,five);
					     				  int_to_string(one_notes,one);
						    			  transmit_string("Remaining Balance: ");
			              		transmit_string(balance1);
			              		transmit_string("\r\n");
						    			  transmit_string("500 Notes: ");
							    		  transmit_string(five);
							    			transmit_string(", 100 Notes: ");
							    			transmit_string(one);
							    			transmit_string("\r\n");
							    			transmit_string("\r\n");
										}
										else{transmit_string("Invalid Input\r\n");}
			        		  break;
									 
									 case '2':
									  int_to_string(bal_2,balance2);
					          transmit_string("Account Holder: ");
				          	transmit_string(name2);
			           		transmit_string("\r\n");
				           	transmit_string("Account Balance: ");
			           		transmit_string(balance2);
			          		transmit_string("\r\n");
			          		transmit_string("\r\n");
									  transmit_string("Enter Amount, in hundreds\r\n");
									  ch3 = receive_char();
									  ch4 = receive_char();
									  if((ch3=='0' || ch3=='1' || ch3=='2' || ch3=='3' || ch3=='4' || ch3=='5' || ch3=='6' || ch3=='7' || ch3=='8' || ch3=='9') && (ch4=='0' || ch4=='1' || ch4=='2' || ch4=='3' || ch4=='4' || ch4=='5' || ch4=='6' || ch4=='7' || ch4=='8' || ch4=='9')){
											  val_1 = (int)ch4 - 48;
	     								  val_2 = val_1 * 100;
										    val_1 = (int)ch3 - 48;
										    val_2 = val_2 + val_1*1000;
			    						  five_notes = val_2 / 500;
				    					  one_notes = val_2 % 500;
										    one_notes = one_notes / 100;
										    if(val_2 > bal_2){
													transmit_string("Insufficient Balance\r\n");
													continue;
												}
			    						  
										    bal_2 = bal_2 - val_2;
										    int_to_string(bal_2,balance2);
						     			  int_to_string(five_notes,five);
					     				  int_to_string(one_notes,one);
						    			  transmit_string("Remaining Balance: ");
			              		transmit_string(balance2);
			              		transmit_string("\r\n");
						    			  transmit_string("500 Notes: ");
							    		  transmit_string(five);
							    			transmit_string(", 100 Notes: ");
							    			transmit_string(one);
							    			transmit_string("\r\n");
							    			transmit_string("\r\n");
										}
										else{transmit_string("Invalid Input\r\n");}
			        		  break;
									 
					         default:transmit_string("No such account, please enter valid details\r\n");
								           break; 
								 }
								 break;
							
				default:transmit_string("Please enter correct input\r\n");
								 break;
				
			}
			}
}


