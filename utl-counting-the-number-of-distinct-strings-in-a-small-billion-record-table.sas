Counting the number of distinct strings in a small billion record table in less than 4 minutes.                             
                                                                                                                            
If 1Tb is big data then this 15Gb table is only 1.5% of big data.                                                           
                                                                                                                            
github                                                                                                                      
http://tinyurl.com/y6fuh553                                                                                                 
https://github.com/rogerjdeangelis/utl-counting-the-number-of-distinct-strings-in-a-small-billion-record-table              
                                                                                                                            
SAS Forum                                                                                                                   
https://communities.sas.com/t5/SAS-Programming/distinct-count/m-p/545276                                                    
                                                                                                                            
*_                   _                                                                                                      
(_)_ __  _ __  _   _| |_                                                                                                    
| | '_ \| '_ \| | | | __|                                                                                                   
| | | | | |_) | |_| | |_                                                                                                    
|_|_| |_| .__/ \__,_|\__|                                                                                                   
        |_|                                                                                                                 
;                                                                                                                           
                                                                                                                            
data have;                                                                                                                  
  length str $15;                                                                                                           
  do c1=1000 to 2000;                                                                                                       
    do c2=2000 to 3000;                                                                                                     
      do c3=3000 to 4000;                                                                                                   
         str=substr(cats('7988887',mod(c1,50),mod(c2,25),mod(c3,13),'129875'),1,15);                                        
         output;                                                                                                            
      end;                                                                                                                  
    end;                                                                                                                    
  end;                                                                                                                      
  drop c1 c2 c3;                                                                                                            
run;quit;                                                                                                                   
                                                                                                                            
WORK.HAVE total obs=1,003,003,001                                                                                           
                                                                                                                            
   Obs          STR                                                                                                         
                                                                                                                            
     1    798888700101298                                                                                                   
     2    798888700111298                                                                                                   
     3    798888700121298                                                                                                   
     4    798888700012987                                                                                                   
     5    798888700112987                                                                                                   
     6    798888700212987                                                                                                   
    ...                                                                                                                     
                                                                                                                            
*            _               _                                                                                              
  ___  _   _| |_ _ __  _   _| |_                                                                                            
 / _ \| | | | __| '_ \| | | | __|                                                                                           
| (_) | |_| | |_| |_) | |_| | |_                                                                                            
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                           
                |_|                                                                                                         
;                                                                                                                           
                                                                                                                            
WORK.WANT total obs=1                                                                                                       
                                                                                                                            
   Obs     UNQ                                                                                                              
                                                                                                                            
     1    15,024                                                                                                            
                                                                                                                            
*          _       _   _                                                                                                    
 ___  ___ | |_   _| |_(_) ___  _ __                                                                                         
/ __|/ _ \| | | | | __| |/ _ \| '_ \                                                                                        
\__ \ (_) | | |_| | |_| | (_) | | | |                                                                                       
|___/\___/|_|\__,_|\__|_|\___/|_| |_|                                                                                       
                                                                                                                            
;                                                                                                                           
                                                                                                                            
data want;                                                                                                                  
  if _n_=0 then set have;                                                                                                   
  if _n_ = 1 then do;                                                                                                       
    dcl hash h(dataset:"have", duplicate: "r");                                                                             
    h.defineKey("STR");                                                                                                     
    h.defineDone();                                                                                                         
    call missing(STR);                                                                                                      
  end;                                                                                                                      
  unq = h.num_items;                                                                                                        
  output;                                                                                                                   
  drop str;                                                                                                                 
  stop;                                                                                                                     
run;                                                                                                                        
                                                                                                                            
                                                                                                                            
NOTE: There were 1003003001 observations read from the data set WORK.HAVE.                                                  
NOTE: The data set WORK.WANT has 1 observations and 2 variables.                                                            
NOTE: DATA statement used (Total process time):                                                                             
      real time           3:31.66                                                                                           
      user cpu time       3:31.53                                                                                           
      system cpu time     0.09 seconds                                                                                      
      memory              1642.59k                                                                                          
      OS Memory           29704020.00k                                                                                      
      Timestamp           03/24/2019 04:52:24 PM                                                                            
      Step Count         735  Switch Count  7                                                                               
                                                                                                                            
                                                                                                                            
                                                                                                                            
                                                                                                                            
