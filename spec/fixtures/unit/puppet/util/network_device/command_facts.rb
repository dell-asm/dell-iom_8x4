module CommandFacts

SWITCHSHOW_HASH = {
    'Switch Name' => 'B1_FC_IOM',
    'Switch State' => 'Online',
    'Switch Wwn' => '10:00:00:27:f8:81:30:f4',
    'Switch Beacon' => 'OFF',
    'Switch Mode' => 'Access Gateway Mode'
  }

  CHASSISSHOW_HASH = {
    'Serial Number' => 'CCXYJN1',
    'Factory Serial Number' => 'AQQ0414J00E'
  }

  IPADDRESSSHOW_HASH = {
    'Ethernet IP Address' => '172.17.10.172',
    'Ethernet Subnetmask' => '255.255.0.0',
    'Gateway IP Address' => '172.17.0.1'
  }

 DEFAULTVALUE_HASH = {
    'Manufacturer' => 'Dell',
    'Protocols Enabled' => 'FC',
    'Boot Image' => 'Not Available',
    'Processor' => 'Not Available',
    'Port Channels' => 'Not Available',
    'Port Channel Status' => 'Not Available'
  }
  
SWITCHSTATUSSHOW_HASH = {
'Switch Health Status' => 'HEALTHY'
}


MEMSHOW_HASH = {
'Memory(bytes)' => '516452352'
}

VERSIONSHOW_HASH = {
"Fabric Os" => "v7.0.2"
}


MODEL_HASH = {
  '75.x' => 'Dell IOM 8|4'
}

def validate_facts(hash_name,factObj)
	hash_name.keys.each do |key|
        factObj.retrieve[key].should include(hash_name[key])
        end
end

def facts_exists_validate(hash_name,fact_hash)
        hash_name.keys.each do |key|
        fact_hash[key].should_not be_empty
	end
end

end

    