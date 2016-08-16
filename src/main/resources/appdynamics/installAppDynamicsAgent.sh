#!/bin/sh
set -e

if [[ -d "${container.appDynamicsHome}" ]]; then
	echo "AppDynamics homedir ${container.appDynamicsHome} already exists, skipping unzip..."
else
	echo "Installing AppDynamics agent to ${container.appDynamicsHome}"
	mkdir -p "${container.appDynamicsHome}"
	unzip AppServerAgent.zip -d "${container.appDynamicsHome}"	
fi

if [[ ! -d "${container.appDynamicsHome}" ]]; then
	exit 1
fi

echo "Copying controller-info to conf dir.."
cp controller-info.xml "${container.appDynamicsHome}/conf"

echo "Modifying and backupping startup script.."
sed -e '1 a ### START XL DEPLOY ADDITION ###' \
	-e '1 a JAVA_OPTS=$JAVA_OPTS:-javaagent:${container.appDynamicsHome}/javaagent.jar' \
    -e '1 a ### END XL DEPLOY ADDITION ###' \
    ${container.startupScript} > out.file

mv ${container.startupScript} ${container.startupScript}.xld-bak
mv out.file ${container.startupScript}

# ALWAYS fail for now.. work in progress
exit 1