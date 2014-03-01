# Dell IOM 8|4 network device module

**Table of Contents**

- [Dell IOM 8|4 network device module](#Dell IOM 8|4-network-device-module)
	- [Overview](#overview)
	- [Requirements](#requirements)
	- [Usage](#usage)
		- [Device Setup](#device-setup)

## Overview
The Dell IOM 8|4 network device module is designed to add support for managing Dell IOM 8|4 switch configuration using Puppet and its Network Device functionality.

Following Dell IOM 8|4 models have been verified using this module:
- Dell IOM 8|4

However, this module may be compatible with other versions.

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
      url ssh://root:secret@iom_8x41.example.com
