#!/usr/bin/perl

# Universidade Federal do Rio de Janeiro
# Engenharia Eletronica e de Computacao
# Linguagens de Programacao
# Professor: Miguel Couto
#
# spamLib.pm
# Spam Detector
# Authors: 
#		Luiz Renno Costa (luizrennocosta@poli.ufrj.br)
#		Rennan Emanuelli Rotunno (renanrotunno@poli.ufrj.br)



package spamLib;
 
use strict;
use warnings;
use Exporter qw(import);

our %EXPORT_TAGS = ( 'all' => [ qw( )]); 
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} });
our @EXPORT = qw(Teste1 Teste2 Teste3 Teste4 Teste5 Teste6);



sub Teste1
{
		
	my @TestElements = @_;#it receives the parameters passed to this function
	my $blacklistcounter=0;#just a support counter
	my @line;#just a support variable to put the split result into
	
	if( open(BLACKLISTFILE, "<$TestElements[4]") ) #this part verifies if the file is correctly open	
	{
		while (<BLACKLISTFILE>)
		{
			if (!(/^#/ or /^$/))											
			{																			
				@line = split (/\s+/m);			
					foreach ($line[0])
					{
			
						#this part just verify if the sender is in the Blacklist
						if( index($TestElements[1]->{'FROM'}, $line[0])!=-1)
						{
							$blacklistcounter++;												
						}			
					}							
			}
		}
	close BLACKLISTFILE;
	return $blacklistcounter;
	
	}
	 else
	{
		#this part occurs when the file is not properly open
		close BLACKLISTFILE;
		return -1;
	}	
}	
	



sub Teste2
{
	#Teste2 verify if there are too many lines in the e-mail
	my @TestElements = @_;#it receives the parameter passed to this function
	
	if ($TestElements[2]>80)
	{
			if($TestElements[3])
			{
				print "NUMBER OF LINES IS GREATER THAN 75\n";
			}
		return $TestElements[0]->[0]; #it's the value for this test received when we read the config.tx file
	}	
	return 0;
}	


sub Teste3
{
	
	#Teste3 verify if the content of e-mail's Subject or Body is blank
	my @TestElements = @_;	#The variable(array) that receives the parameter.		
	my $subjectString = 'Subject:';	#Just a supporting variable so that we can check if the e-mail subject is empty.	
	my $bodyString = ' ';#	Just a supporting variable so that we can check if the e-mail contents are empty.			
	my $counter = 0;#	Another simple counter.

	if(length($subjectString) >= length($TestElements[1]->{'SUBJECT'})) #|checking if the content of the e-mail's Subject is blank.		                       
	  {											
		 $counter +=$TestElements[0]->[1] ;  #it's the value for this test received when we read the config.tx file 					
		if ($TestElements[3]){ print "EMPTY SUBJECT \n";}		 
	  } 											
	  
	 
	if (length ($bodyString) >= length($TestElements[1]->{'BODY'})) #|checking if the content of the e-mail's Body is blank					
	 {											
	 	$counter +=$TestElements[0]->[2]; #it's the value for this test received when we read the config.tx file					
	 	if ($TestElements[3]){print "EMPTY BODY \n";}								
	 }												
	

	return $counter;
	
}	


sub Teste4
{
	
	#Teste4 verify if the sender is a recognizable entity and the presence of links within the email body.
	
	my @TestElements = @_;#The variable(array) that receives the parameter.
	my $counter=0;
	if (index($TestElements[1]{'FROM'}, "\@poli") == -1)					 #|
	{											 #|
		if (index($TestElements[1]{'FROM'}, "\@gmail") == -1)				 #|
		{										 #|					
			if (index($TestElements[1]->{'FROM'}, "\@hotmail") == -1)		 #|			
			{									 #|			
				if (index($TestElements[1]->{'FROM'}, "\@outlook") == -1)	 #|Checking if the sender is of a recognizable entity			
				{								 			
				   $counter +=$TestElements[0]->[3];#it's the value for this test received when we read the config.tx file
				   if($TestElements[3])
					{
						print "THE SENDER IS NOT A RECOGNIZABLE ENTITY\n";
					}				
				}								 			
			}									 	
		}										 	
	}
	 if (index($TestElements[1]->{'BODY'}, "http") != -1)					#|
	 {											#|
		 $counter +=$TestElements[0]->[4];#it's the value for this test received when we read the config.tx file	
		 if ($TestElements[3]){print "CONTAINS HTTP\n";}				#|
	 } 											#|
	elsif (index($TestElements[1]->{'BODY'}, "www.") != -1)                                 #| 
	 {											#|	
		 $counter +=$TestElements[0]->[4];						#|	
		 if ($TestElements[3]){print "CONTAINS WWW.\n";}				#|Checking the presence of links within the email body 
	 } 											#|                                                                                       
	elsif (index($TestElements[1]->{'BODY'}, ".net") != -1)					#|	 	
	 {											#|
		 $counter +=$TestElements[0]->[4];						#|
		 if ($TestElements[3]){print "CONTAINS .NET\n";}				#|
	 } 											#|											
	elsif (index($TestElements[1]->{'BODY'}, ".com") != -1)					#|
	 {											#|
		 $counter +=$TestElements[0]->[4];						#|	
		 if ($TestElements[3]){print "CONTAINS .COM\n";}				#|	
	 } 											#|	
	 
		
	return $counter;
	
}	


sub Teste5
{
		#Test 5 checks if the forbidden words are present in the e-mail.
		#The ones chosen here were "viagra" and "pornogragia", common words in malicious e-mails
	my @TestElements = @_;#The variable(array) that receives the parameter.		
												
	my $counter = 0;#Another simple counter.		
																			
	
	if ($TestElements[1]{'BODY'} =~ /(v(?:i|1|!|l)(?:a|@)gr(?:a|@))/m) 			#|checks various forms of viagra to be written
	{					
		
		$counter +=$TestElements[0]->[5];#it's the value for this test received when we read the config.tx file					
		if($TestElements[3]){print "CONTAINS VIAGRA\n";}						
	}																	
	if ($TestElements[1]{'BODY'} =~ /(p(?:o|0|@)rn(?:o|0|@)gr(?:a|@)f(?:i|1|!)(?:a|@))/m)	#|checks various forms of pornografia to be written								
	{		
		$counter +=$TestElements[0]->[5];						 			
		if($TestElements[3]){print "CONTAINS PORNOGRAFIA\n";}													
	}											

	return $counter;
}		
	
sub Teste6
{	
	#Teste6 checks if the sent date is higher than the received date. 
	my $counter=0;
	my @TestElements = @_;#The variable(array) that receives the parameter.	
	  
	
	if(($TestElements[1]{'SENTDATE'}) gt ($TestElements[1]{'RECEIVEDATE'}))			
	{														
		if ($TestElements[3]){print "SENT DATE IS GREATER THAN RECEIVED DATE \n";}	
		$counter += $TestElements[0]->[6];#it's the value for this test received when we read the config.tx file	
			
	}											



	return $counter;

	
}
 "TRUE";

