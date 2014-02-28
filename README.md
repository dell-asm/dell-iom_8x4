# Dell IOM 8|4 network device module

**Table of Contents**

- [Dell IOM 8|4 network device module](#Dell IOM 8|4-network-device-module)
	- [Overview](#overview)
	- [Features](#features)
	- [Requirements](#requirements)
	- [Usage](#usage)
		- [Device Setup](#device-setup)
		- [Dell IOM 8|4 operations](#Dell IOM 8|4-operations)

## Overview
The Dell IOM 8|4 network device module is designed to add support for managing Dell IOM 8|4 switch configuration using Puppet and its Network Device functionality.

Following Dell IOM 8|4 models have been verified using this module:
- Dell IOM 8|4-6510

However, this module may be compatible with other versions.

## Features
This module supports the following functionalities:

 * Alias creation and deletion
 * Addition and Removal of Members from Alias
 * Zone creation and deletion
 * Addition and Removal of Members from zones
 * Config creation and deletion
 * Addition and Removal of Zones from Config
 * Activation and De-Activation of Config
 

## Requirements
Because the Puppet agent cannot be directly installed on the Dell IOM 8|4 Fabric OS, the agent can be managed either from the Puppet Master server,
or through an intermediate proxy system running a puppet agent. The proxy system requirements are not yet defined.

## Usage

### Device Setup
To configure a Dell IOM 8|4 Fabric OS device, the device *type* must be `iom_8x4`.
The device can either be configured within */etc/puppet/device.conf*, or, preferably, create an individual config file for each device within a sub-folder.
This is preferred as it allows the user to run the puppet against individual devices, rather than all devices configured.

To run the puppet against a single device, use the following command:

    puppet device --deviceconfig /etc/puppet/device/[device].conf

Sample configuration `/etc/puppet/device/iom_8x41.example.com.conf`:

    [iom_8x41.example.com]
      type iom_8x4
      url ssh://root:secret@iom_8x41.example.com:22

### Dell IOM 8|4 FOS operations
This module can be used to create or delete an alias,add/remove member to/from alias, create or delete a zone, add/remove member to/from a zone, create or delete config, activate or de-activate config.
For example: 

   iom_8x4_member_alias { 'demoAlias':
    name   => 'demoAlias:50:00:d3:10:00:5e:c4:ad;50:00:d3:10:00:5e:c4:ac'
    ensure => 'present'
  }

  iom_8x4_zone { 'demozone':
    ensure => 'present',
    member => 'demoAlias'
  }

 iom_8x4_config { 'democonfig':
   ensure => 'present',
   member_zone => 'demozone',
   configstate => 'disable',
  }


This creates an alias for the members, adds the alias to a zone, and then adds the zone to the config (in de-activation mode) as per defined input parameters.

You can also use any of the above operations individually, or create new defined types, as required. 

Sample manifests can be referred from tests folder.
dell-iom_8x4
