echo enter phase break point

#read break_point

#re='^[0-9]+$'
#if ! [[ $break_point =~ $re ]]; then
#   echo "error: Not a number" >&2; exit 1
#fi

#if [ $break_point < 0 || $break_point > 6]; then
#   echo "error: Number is too large or too small" >&2; exit 1
#fi

break_point=2

echo break point is phase_$break_point

gdb bomb
b phase_$break_point


