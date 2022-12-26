########################################
#
#Name: Domain Disjoin Script
#
#Version: 1.0
#
#Change(s): Creation
#
########################################

#Users enter this before the script is run, but just in case.
Set-ExecutionPolicy Unrestricted

########################################

remove-computer -UnjoinDomaincredential domain1\admin -passthru -verbose -Restart

