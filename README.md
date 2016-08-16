# Preface #

This document describes the functionality provided by the XLD AppDynamics plugin.

See the **XL Deploy Reference Manual** for background information on XL Deploy and deployment concepts.

# CI status #

[![Build Status](https://travis-ci.org/xebialabs-community/xld-appDynamics-plugin.svg?branch=master)](https://travis-ci.org/xebialabs-community/xld-appDynamics-plugin)

# Overview #

This XLD AppDynamics plugin is capable of installing and uninstalling AppDynamics agents to JVM startup scripts by injecting JAVA_OPTS with the correct agent settings.

# Requirements #

* **Requirements**
	* **XL Deploy** 5.1.3+

# Installation #

Place the plugin jar file into your `SERVER_HOME/plugins` directory.

# Usage #

## Properties defined on each containers for AppDynamics
![Preview](/docs/images/appdynamics-properties.png)

## Menu to find install / uninstall options
![Preview](/docs/images/container-menu.png)

## Example of output when installing an agent
![Preview](/docs/images/install-agent.png)
 
## Example of output when uninstalling an agent
![Preview](/docs/images/uninstall-agent.png)
