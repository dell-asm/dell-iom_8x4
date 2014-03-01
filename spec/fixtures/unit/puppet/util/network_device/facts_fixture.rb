class Facts_fixture

 def version_resp
    return "B1_FC_IOM:root> version
Kernel:     2.6.14.2   
Fabric OS:  v7.0.2
Made on:    Thu Aug 16 21:09:15 2012
Flash:	    Wed Apr 24 21:01:23 2013
BootProm:   1.0.9
B1_FC_IOM:root>"
  end

def memshow_resp
	return "
             total       used       free     shared    buffers     cached
Mem:     516452352  238665728  277786624          0   21057536   72482816
Swap:            0          0          0
"
end

def switchstatusshow_resp
	return "
Switch Health Report                        Report time: 02/27/2014 09:16:10 PM
Switch Name: 	B1_FC_IOM
IP address:	172.17.10.172 
SwitchState:	HEALTHY
Duration:	1590:35

Temperatures monitor  	HEALTHY
Flash monitor         	HEALTHY
Marginal ports monitor	HEALTHY
Faulty ports monitor  	HEALTHY
Missing SFPs monitor  	HEALTHY
Error ports monitor  	HEALTHY
Fabric Watch is not licensed
Detailed port information is not included

	"
end

def ipaddrshow_resp
	return "
SWITCH
Ethernet IP Address: 172.17.10.172
Ethernet Subnetmask: 255.255.0.0
Gateway IP Address: 172.17.0.1
DHCP: On
B1_FC_IOM:root
"
end

 def chassisshow_resp
return	 "
B1_FC_IOM:root> chassisshow

CHASSIS/WWN  Unit: 1
Header Version:       	2
Factory Part Num:      	40-1000251-05
Factory Serial Num:    	AQQ0414J00E
Manufacture:           	Day:  2  Month:  4  Year: 2013
Update:                	Day: 27  Month:  2  Year: 2014
Time Alive:            	304 days
Time Awake:            	65 days
ID:           		BRD0000CA
Part Num:     		SLKWRM0000PLX
Serial Num:   		CCXYJN1
"
end


 def switchshow_resp
	 return "
switchName:	B1_FC_IOM
switchType:	75.0
switchState:	Online   
switchMode:	Access Gateway Mode
switchWwn:	10:00:00:27:f8:81:30:f4
switchBeacon:	OFF

Index Port Address Media Speed State     Proto
==============================================
  0   0   010000   --     N8   No_Module   FC  
  1   1   010100   cu     AN   No_Sync     FC  Disabled (Persistent) 
  2   2   010200   cu     N8   Online      FC  F-Port  20:01:00:0e:1e:30:18:6a 0x010013 
  3   3   010300   cu     AN   No_Sync     FC  Disabled (Persistent) 
  4   4   010400   cu     AN   No_Sync     FC  Disabled (Persistent) 
  5   5   010500   cu     AN   No_Sync     FC  Disabled (Persistent) 
  6   6   010600   cu     AN   No_Sync     FC  Disabled (Persistent) 
  7   7   010700   cu     AN   No_Sync     FC  Disabled (Persistent) 
  8   8   010800   cu     N8   Online      FC  F-Port  21:00:00:24:ff:4a:bb:3e 0x010312 
  9   9   010900   cu     N8   Online      FC  F-Port  21:00:00:24:ff:4a:bb:5a 0x010022 
 10  10   010a00   cu     N8   Online      FC  F-Port  21:00:00:24:ff:4a:be:2e 0x010101 
 11  11   010b00   cu     AN   No_Sync     FC  Disabled (Persistent) 
 12  12   010c00   cu     AN   No_Sync     FC  
 13  13   010d00   cu     AN   No_Sync     FC  Disabled (Persistent) 
 14  14   010e00   cu     AN   No_Sync     FC  Disabled (Persistent) 
 15  15   010f00   cu     AN   No_Sync     FC  Disabled (Persistent) 
 16  16   011000   cu     AN   No_Sync     FC  Disabled (Persistent) 
 17  17   011100   id     N8   Online      FC  N-Port  10:00:00:27:f8:61:7d:ba 0x010000 
 18  18   011200   id     N8   Online      FC  N-Port  10:00:00:27:f8:61:7d:ba 0x010100 
 19  19   011300   id     N8   Online      FC  N-Port  10:00:00:27:f8:61:7d:ba 0x010200 
 20  20   011400   id     N8   Online      FC  N-Port  10:00:00:27:f8:61:7d:ba 0x010300 
 21  21   011500   --     N8   No_Module   FC  
 22  22   011600   --     N8   No_Module   FC  
 23  23   011700   --     N8   No_Module   FC
"	
 end
end