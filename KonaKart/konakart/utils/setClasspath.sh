#!/bin/sh

# 
# Set the classpath
# -----------------
#

# figure out where the home is - $0 may be a softlink
				
PRG="$0"

while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done
        	 
KK_WEBAPPS_HOME=`dirname "$PRG"`/../../webapps/

KKADMIN_CLASSPATH=.:${KK_WEBAPPS_HOME}/konakartadmin/WEB-INF/classes
KKADMIN_CLASSPATH=${KKADMIN_CLASSPATH}:${KK_WEBAPPS_HOME}/konakartadmin/WEB-INF/lib/*

KK_CLASSPATH=.:${KK_WEBAPPS_HOME}/konakart/WEB-INF/classes
KK_CLASSPATH=${KK_CLASSPATH}:${KK_WEBAPPS_HOME}/konakart/WEB-INF/lib/*

KKCMD_CLASSPATH=${KK_CLASSPATH}:${KKADMIN_CLASSPATH}

export KKADMIN_CLASSPATH
export KK_CLASSPATH
export KKCMD_CLASSPATH
export KK_WEBAPPS_HOME
