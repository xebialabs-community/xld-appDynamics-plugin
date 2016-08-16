#!/bin/sh

#
# THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS 
# FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.
#

if [[ -d "${container.appDynamicsHome}" ]]; then
	echo "AppDynamics homedir ${container.appDynamicsHome} already exists, skipping unzip..."
else
	echo "Installing AppDynamics agent to ${container.appDynamicsHome}"
	mkdir -p "${container.appDynamicsHome}"
	unzip AppServerAgent.zip -d "${container.appDynamicsHome}"	
fi

echo "Copying controller-info to conf dir.."
cp controller-info.xml "${container.appDynamicsHome}/AppServerAgent/conf/"

if [[ ! -f "${container.appDynamicsHome}/AppServerAgent/conf/controller-info.xml" ]]; then
	echo "Install failed.. check error messages."
	exit 1
fi

if [[ -f "${container.startupScript}.xld-bak" ]]; then
	echo "AppDynamics agent already installed before - resetting startup script to backupped version..."
	rm -f ${container.startupScript}
	cp "${container.startupScript}.xld-bak" "${container.startupScript}"
else
	echo "Backupping script to ${container.startupScript}.xld-bak before modification..."
	cp "${container.startupScript}" "${container.startupScript}.xld-bak"
fi

JAVA_OPTS="-javaagent:${container.appDynamicsHome}/AppServerAgent/javaagent.jar"

<#if container.applicationName??>
	JAVA_OPTS="$JAVA_OPTS -Dappdynamics.agent.applicationName=${container.applicationName}"
</#if>

<#if container.tierName??>
	JAVA_OPTS="$JAVA_OPTS -Dappdynamics.agent.tierName=${container.tierName}"
</#if>

<#if container.nodeName??>
	JAVA_OPTS="$JAVA_OPTS -Dappdynamics.agent.nodeName=${container.nodeName}"
</#if>

echo "Modifying startup script.."
sed -e "1 a ### START XL DEPLOY ADDITION ###" \
	-e "1 a JAVA_OPTS=\$JAVA_OPTS $JAVA_OPTS" \
	-e "1 a ### END XL DEPLOY ADDITION ###" \
	"${container.startupScript}" > out.file \
	&& mv out.file "${container.startupScript}"
EXITCODE=$?

echo "AppDynamics agent added to startup scripts. Restart JVM for it to take effect."

exit $EXITCODE