# the idea of this theme is to contain a lot of info in a small string, by
# compressing some parts and colorcoding, which bring useful visual cues,
# while limiting the amount of colors and such to keep it easy on the eyes.
# When a command exited >0, the timestamp will be in red and the exit code
# will be on the right edge.
# The exit code visual cues will only display once.
# (i.e. they will be reset, even if you hit enter a few times on empty command prompts)

typeset -A host_repr

# translate hostnames into shortened, colorcoded strings
host_repr=('dieter-ws-a7n8x-arch' "%{$fg_bold[green]%}ws" 'dieter-p4sci-arch' "%{$fg_bold[blue]%}p4")

# local time, color coded by last return code
time_enabled="%(?.%{$fg[blue]%}.%{$fg[red]%})%*%{$reset_color%}"
time_disabled="%{$fg[blue]%}%*%{$reset_color%}"
time=$time_enabled

# user part, color coded by privileges
local user="%(!.%{$fg[yellow]%}.%{$fg[yellow]%})%n%{$reset_color%}"

# Hostname part.  compressed and colorcoded per host_repr array
# if not found, regular hostname in default color
local host="@%{$fg[green]%}${host_repr[$HOST]:-$HOST}%{$reset_color%}"

# Compacted $PWD
#local pwd="%{$fg[cyan]%}%c%{$reset_color%}"
local pwd="%{$fg[cyan]%}%~%{$reset_color%}"

PROMPT='┌[ ${time} ] ${user}${host} [ ${pwd} ]
└> % '

# elaborate exitcode on the right when >0
return_code_enabled="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
return_code_disabled=
return_code=$return_code_enabled

RPS1='${return_code}'
