#%Module1.0#####################################################################
#
# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| 
# || (C) 2006 by Bull S.A.S.                                                               || 
# ||      Copyright (C) 2006 Bull S.A.S. All rights reserved                               || 
# ||      Bull, Rue Jean Jaures, B.P.68, 78340, Les Clayes-sous-Bois                       || 
# ||      This is not Free or Open Source software. Please contact                         || 
# ||      Bull S.A.S. for details about its license.                                       || 
# ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||| 
##
## mpibull2 modulesfile
##   100307: multi-shells
##   230707: params supported with modules, using trick (YK)
##
proc getenv {key {defaultvalue {}}} {
  global env; expr {[info exist env($key)]?$env($key):$defaultvalue}
}

set     USER_HOME          [getenv HOME]
set     USER_SHELL         [getenv SHELL]
set     MPI_HOME           /opt/mpi/mpibull2-1.3.9-10.s
set 	MPIANALYSER_LIBS   $MPI_HOME/lib/mpianalyser/modules
set 	MPILAUNCH_PATH     $MPI_HOME/bin/mpimetalauncherlib
set	MPIBULL2_COMM_DRIVER osock
## structure is : include/ lib/ lib/drivers bin/ man/

module-verbosity {on}

prepend-path    PATH            $MPI_HOME/bin
prepend-path    MANPATH         $MPI_HOME/man
prepend-path   	LD_LIBRARY_PATH $MPI_HOME/lib
prepend-path    LD_LIBRARY_PATH $MPI_HOME/lib/drivers/$MPIBULL2_COMM_DRIVER
prepend-path    LD_LIBRARY_PATH $MPIANALYSER_LIBS
append-path	LD_LIBRARY_PATH /usr/lib/:/usr/lib64/:$MPI_HOME/lib/pmi
prepend-path    PYTHONPATH	$MPI_HOME/lib/pypar
prepend-path    PYTHONPATH	$MPILAUNCH_PATH
setenv          MPI_HOME        $MPI_HOME
setenv		MPIBULL2_COMM_DRIVER $MPIBULL2_COMM_DRIVER

# bug 307665 : Ugly ! Fixed multiple $var in set-alias of modules by using external
# 		variable grepped through the environment
# 		(YK, 230707, mpibull2-modules.template)
# Params 
set     	PUSER  		[getenv USER]
set     	PHOST  		[getenv HOSTNAME]
setenv		PARAMID		$PUSER-$PHOST
# bug 307665 : 	Fixed __mpibull-params.sh in new  __mpibull-params
#		Also, variable trick because multiple variables in set_alias not allowed
#		(YK, 230707, mpibull2-modules.template:39+)
# bug 307902: Shell aliases do not tolerate dashes. Replaced with _ (sorry for backward compt.)
# bug 308603: Absolute path slipped in here
switch $USER_SHELL {
	/bin/sh {  
		set-alias       mpibull2_params  { mpibull2_params_func() { $MPI_HOME/bin/__mpibull2-params \$*; \
							   . /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export ; 	\
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export; \
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv;}; mpibull2_params_func }
		set-alias       mpibull2_devices { mpibull2_devices_func() {  eval `__mpibull2-devices.sh \$*`; } ; mpibull2_devices_func \$@ }  
		set-alias       mpibull2-params  { mpibull2_params_func() { $MPI_HOME/bin/__mpibull2-params \$*; \
							   . /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export ; 	\
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export; \
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv;}; mpibull2_params_func \$@ }
		set-alias       mpibull2-devices { mpibull2_devices_func() {  eval `__mpibull2-devices.sh \$*`; } ; mpibull2_devices_func  }
	}
	/bin/bash {
		set-alias       mpibull2_params  { mpibull2_params_func() { $MPI_HOME/bin/__mpibull2-params \$*; \
							   . /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export ; 	\
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export; \
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv; } ; mpibull2_params_func \$@ }
		set-alias       mpibull2_devices { mpibull2_devices_func() {  eval `__mpibull2-devices.sh \$*`; } ; mpibull2_devices_func  }
		set-alias       mpibull2-params  { mpibull2_params_func() { $MPI_HOME/bin/__mpibull2-params \$*; \
							   . /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export ; 	\
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export; \
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv; } ; mpibull2_params_func \$@ }
		set-alias       mpibull2-devices { mpibull2_devices_func() {  eval `__mpibull2-devices.sh \$*`; } ; mpibull2_devices_func  }
	}
	/bin/ksh { 
		set-alias       mpibull2_params  { mpibull2_params_func() { $MPI_HOME/bin/__mpibull2-params \$*;\
							   . /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export ;\
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export;\
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv; }; mpibull2_params_func \$@ }
		set-alias       mpibull2_devices { mpibull2_devices_func() {  eval `__mpibull2-devices.sh \$*`; } ; mpibull2_devices_func  }
		set-alias       mpibull2-params  { mpibull2_params_func() { $MPI_HOME/bin/__mpibull2-params \$*;\
							   . /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export ;\
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export;\
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv; }; mpibull2_params_func \$@ }
		set-alias       mpibull2-devices { mpibull2_devices_func() {  eval `__mpibull2-devices.sh \$*`; } ; mpibull2_devices_func  }
	}
	/bin/zsh { 
		set-alias       mpibull2_params  { $MPI_HOME/bin/__mpibull2-params $*; \
							   . /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export ; 	\
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export; \
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv; }
		set-alias       mpibull2_devices { eval `__mpibull2-devices.sh $*` }
		set-alias       mpibull2-params  { $MPI_HOME/bin/__mpibull2-params $*; \
							   . /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export ; 	\
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export; \
							   /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv; }
		set-alias       mpibull2-devices { eval `__mpibull2-devices.sh $*` }
	}
	/bin/csh { 
		set-alias       mpibull2_params  { $MPI_HOME/bin/__mpibull2-params \\!*;\
							 source /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv ; \
							 /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export; \
							 /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv; }
		set-alias       mpibull2_devices { eval `__mpibull2-devices.sh \\!*` }
		set-alias       mpibull2-params  { $MPI_HOME/bin/__mpibull2-params \\!*;\
							 source /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv ; \
							 /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export; \
							 /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv; }
		set-alias       mpibull2-devices { eval `__mpibull2-devices.sh \\!*` }
	}
	/bin/tcsh {
		set-alias       mpibull2_params  { $MPI_HOME/bin/__mpibull2-params \\!*;\
							 source /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv ; \
							 /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export; \
							 /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv; }
		set-alias       mpibull2_devices { eval `__mpibull2-devices.sh \\!*` }
		set-alias       mpibull2-params  { $MPI_HOME/bin/__mpibull2-params \\!*;\
							 source /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv ; \
							 /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_export; \
							 /bin/rm -f /tmp/`env | grep PARAMID|cut -d= -f2`_mpi_parameters_to_setenv; }
		set-alias       mpibull2-devices { eval `__mpibull2-devices.sh \\!*` }
	}
}
