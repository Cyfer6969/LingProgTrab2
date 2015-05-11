# Universidade Federal do Rio de Janeiro
# Engenharia Eletronica e de Computacao
# Linguagens de Programacao
# Professor: Miguel Couto
#
# Email.pl
# Spam Detector
# Authors: 
#		Luiz Renno Costa (luizrennocosta@poli.ufrj.br)
#		Renan Emanuelli Rotunno (renanrotunno@poli.ufrj.br)


use strict;
use warnings;
#Lib created by us, it holds the tests function.
use spamLib; 

sub Main{

my ($email) = @_;
#@EElements is a vector just to organise the code. The first element is a pointer and it will point to @VALUES, the second one is a pointer 
#and will point to %PARTS,the third one will receive $counterline,the fourth one will receive the variable that indicates 
#if is necessary print on screen and the fifth one will receive blackfile name.	
my @EElements = (0, 0, 0,0,0); 
#it's an array with the values of configuration txt. Each elements correponds to one value											
my @VALUES = (0,0,0,0,0,0,0);
# it's a hash with parts of the e-mail 										
my %PARTS = ('SENTDATE'=>'','RECEIVEDATE'=>'','FROM'=>'','SUBJECT'=>'','BODY'=>''); 			
# @line is just a supporting variable to put the split result into.
my @line;	
#Just a counter to hold the if's together.								 				
my $counter = 0;				
#just a support variable to put the name of configuration file 
my $configFile;						
#just a support variable to put the email file name into.						
my $emailFile;															
#This variable sets the limit for the classification of the email as a spam or not.
my $SUPERIOR_LIMIT = 20;								
#this variable will tell us if there are too many lines in the file										
my $linescounter=0;												

#first pointer receives @VALUES adress
$EElements[0]=\@VALUES;		

#second pointer receives %PARTS adress									
$EElements[1]=\%PARTS;											

($email) = @_;

#This portion of the code just gives the user an option to load a custom .TXT file
#****** THE FORMAT MUST BE [ KEY     VALUE ] ******

# print "Do you wish to use a custom config.txt ? (Y/N) ";									
# my $answer = <STDIN>;														
# chop ($answer);															
															
# if($answer =~ /N|n/)													
# { 													
# 	print "file name: ";														
# 	$configFile = <STDIN>;											
# 	chop ($configFile);																																		
# }																
# else 															
# {									
					
	$configFile = 'config.txt';																		
# }																		


#This portion of code read the configuration file.
#|	******IT ONLY WORKS ON THE FORMAT  [ KEY     VALUE ]*******
open (CONFIGFILE, "<$configFile") or die "O Arquivo de configuracao foi aberto com sucesso $!" ;
while(<CONFIGFILE>)
{
	if (!(/^#/ or /^$/))#|"^" indicates first character and "$" indicates the last one of a line. It's a test to know if the line is a commentary 
	{
		@line = split (/\s+/m);			#|split the words separated by spaces 
		foreach($line[1])			#| it gets the second value of @line and puts on each value of @VALUE 	
		{								
			if ($counter == 0)
			{	
				$EElements[0]->[0] = $line[1];						
			}													
			if ($counter == 1)
			{
				$EElements[0]->[1] = $line[1];
			}													
			if ($counter == 2)
			{
				$EElements[0]->[2] = $line[1];
			}													
			if ($counter == 3)
			{
				$EElements[0]->[3] = $line[1];
			}										
			if ($counter == 4)
			{
				$EElements[0]->[4] = $line[1];
			}	
			if ($counter==5)
			{
				$EElements[0]->[5] = $line[1];
			}	
			if ($counter==6)
			{
				$EElements[0]->[6] = $line[1];
			}								
			$counter++;										
		}													
	}
}

$counter = 0;#	This counter is reseted so that we can read the next file without creating another variable.


#This portion of the code just gives the user an option to load a custom .TXT file
#The rules about the e-mail format are in the documentation

# print "Do you wish to use a custom email.txt ? (Y/N) ";										
# $answer = <STDIN>;														
# chop ($answer);															
															
# if($answer =~ /N|n/)													
# { 													
# 	print "file name: ";														
# 	$emailFile = <STDIN>;										
# 	chop ($emailFile);																																		
# }																
# else 															
# {													
	# $emailFile = 'email.txt';																		
# }	 
 
open(EMAILFILE, $email) or die "O Arquivo do e-mail nao foi aberto com sucesso $!" ;

#This part refers to treating the file and  segregating the e-mail part onto the corresponding
while (<EMAILFILE>) 											
{													
    if (!(/^#/ or /^$/)) 	#This if() statement only makes it so that the split doesn't consider commentary lines within the .txt.									 
    {																						
	@line = split (/\s+/m);	
	$linescounter= $linescounter+1;	 													
	foreach ($line[0])										
	{		
		#|This section gets the SENT date and then the RECEIVED date.										
		if ($line[0] eq "Date:")
		{ 
			#while(<@line> && $counter==0)
				
			#{										
			#	$PARTS{'SENTDATE'} .= <@line>;								
			#}											
			#while (<@line> && $counter == 1)						
			#{				
																
			#	$PARTS{'RECEIVEDATE'} .= <@line>;										
			#}													
			$counter++;												
		} 														
		
		#This section gets the sender e-mail address.													
		elsif ($line[0] eq "From:")																
		{											
			#while (<@line>)										
			#{											
				$PARTS{'FROM'} .= @line;						
			#}											
		} 															
		
		#This section gets the e-mail Subject.														
		elsif ($line[0] eq "Subject:")																					
		{										
		#	while (<@line>)												
		#	{														
				$PARTS{'SUBJECT'} .= @line;							
		#	}												
		} 														
		#This section gets the e-mail Body.													
		else											
		{												
			#while (<@line>)										
			#{														
				$PARTS{'BODY'} .= $line[0];
			#}																									
		}														
	}																						
   }														
}  													



#| It concatenates an empty space to the BODY string to solve the EMPTY_BODY issue, that is, if 
#|there is no content in the e-mail, BODY is empty, which causes problems once I try to use it. By concatenating an empty space we solved that issue.
$PARTS{'BODY'} .= ' ';		
	
	
#number of lines goes to vector and it will be tested in spam.lib
$EElements[2]=$linescounter;										
		
	
	
	

#This portion of the code just gives the user an option to print on screen the tests that e-mail were classified as spam
# print "Do you wish to use print the tests on screen? (Y/N) ";
# $answer = <STDIN>;
# chop ($answer);
# if ($answer=~ /Y|y/ )
# {
# 	#it makes the results be printed on screen. This variable will be utilized on spamLib.pm
# 	$EElements[3]=1;	
# }	
# else
# {
	
	$EElements[3]=0;
# } 


#This part asks for blacklist file 
# print "Do you wish to use a custom blacklist.txt ? (Y/N) ";									
# $answer = <STDIN>;														
# chop ($answer);															
															
# if($answer =~ /N|n/)													
# { 			
											
# 	print "file name: ";															
# 	$EElements[4] = <STDIN>;										
# 	chop ($EElements[4]);																																		
# }																
# else 															
# {													
	$EElements[4] = 'blacklistFile.txt';																	
# }	 
	
	 #counter always receives a value. We can use this variable without creating another for count
	 #It returns 0 if there isn't name in the blacklist; returns -1 if we cannot open the file gave by the user;or returns other positive
	 #value 
	 	$counter=&Teste1(@EElements);
	if( $counter==0 )
	{	
		#in this part we call each test
		$counter=$counter+&Teste2(@EElements);
		$counter=$counter+&Teste3(@EElements);
		$counter=$counter+&Teste4(@EElements);
		$counter=$counter+&Teste5(@EElements);
		$counter=$counter+&Teste6(@EElements);
			if($counter>=$SUPERIOR_LIMIT)
			{
				# print "\nTHIS EMAIL IS A SPAM AND HAS WEIGHT $counter\n";
			}	
			else
			{
				# print "THIS EMAIL IS NOT A SPAM AND HAS WEIGHT $counter\n";
			}
	}
	else
	{
		if ($counter==-1)
		{
			# print "BLACKLIST FILE WAS NOT OPEN\n";
		}
		else
		{	
			if($EElements[3])
			{
				# print "\nO THE SENDER IS IN THE BLACKLIST\n";
				# print "THIS E-MAIL IS A SPAM\n";	
			}
		
			if($EElements[3]==0)
			{
				# print "\nTHIS E-MAIL IS A SPAM\n\n";
			}
		}
	}
	


 
close EMAILFILE;
close CONFIGFILE;
return $counter;	

}			
										