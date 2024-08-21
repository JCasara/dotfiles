source ~/colors.sh

function log () {
    echo "$(date --rfc-3339=seconds) [$0] : $@" |& \
    tee -a ${LOGFILE:-utils.log}
}
function warn () { 
    printf "$BIYellow""%s""$OFF""\n" "$(log $@)"
}
function error () { 
    printf "$BIRed""%s""$OFF""\n" "$(log $@)"
}
function notify () { 
    printf "$BIGreen""%s""$OFF""\n" "$(log $@)"
}
function test_file () { 
    test ! -f $1 && warn "No such file: $1" 
}
function test_dir () { 
    test ! -d $1 && warn "No such directory: $1"
}

# usage - Function to help handle usage and usage errors. Returns 0 on sucess,
#         1 if the usage is incorrect, and  2 on failure (ie wrong usage of usage).
function usage () {  
    if [[ $1 -ne $2 ]]; then 
	echo "$3"; 
	return 1;  
    elif [[ $# -ne 3 ]]; then  
	echo "Usage: usage [NUM ARGS] [EXPECTED NUM ARGS] [USAGE STRING]"
	return 2;
    else
	return 0;
    fi
}

#############################################################################
# path tools
#############################################################################
function path () 
{
    echo $PATH
}
function path_prepend () 
{
    usage $# 1 "Usage:path_prepend  [PATH]" || return 1
    export PATH=$1:$PATH
    path
}
function path_append () 
{
    usage $# 1 "Usage:path_append [PATH]" || return 1
    export PATH=$PATH:$1
    path
}
function path_set () 
{
    usage $# 1 "Usage:path_set [PATH]" || return 1
    export PATH=$1
}

function ld_library_path () 
{ 
    echo $LD_LIBRARY_PATH
}
function ld_library_path_append () 
{ 
    usage $# 1 "Usage:ld_library_path_append [LD_LIBRARY_PATH]" || return 1;
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$1;
    ld_library_path
}
function ld_library_path_prepend () 
{ 
    usage $# 1 "Usage:ld_library_path_prepend  [LD_LIBRARY_PATH]" || return 1;
    export LD_LIBRARY_PATH=$1:$LD_LIBRARY_PATH;
    ld_library_path
}

function ld_library_path_set () 
{ 
    usage $# 1 "Usage:ld_library_path_set [LD_LIBRARY_PATH]" || return 1;
    export LD_LIBRARY_PATH=$1
}
function pythonpath () 
{ 
    echo $PYTHONPATH
}
function pythonpath_append () 
{ 
    usage $# 1 "Usage:pythonpath_append [PYTHONPATH]" || return 1;
    export PYTHONPATH=$PYTHONPATH:$1;
    pythonpath
}
function pythonpath_prepend () 
{ 
    usage $# 1 "Usage:pythonpath_prepend  [PYTHONPATH]" || return 1;
    export PYTHONPATH=$1:$PYTHONPATH;
    pythonpath
}
function pythonpath_set () 
{ 
    usage $# 1 "Usage:pythonpath_set [PYTHONPATH]" || return 1;
    export PYTHONPATH=$1
}
