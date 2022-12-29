<<comment
free -g
top -n 1 | grep %Cpu 
exit

 +------------------+--------------+
 | testserver       |
 |                  |
 |                  | 
 |
 |
comment

tops=("CPU" "12 us" "10 us" "21 us")
server=(Servers testserver testserver2 testserver3)
mem=(RAM 20% 10% 30%)
#arrays=(tops[@] server[@] mem[@])

declare -a sel #for + index value
select=0
tab="+"
num=0
space=""
comp=0
for ((i=0;i<${#tops[@]};i++))
do
    #echo ${tops[i]}
    len=`expr length "${tops[i]}"` #length of data in column    
   
    #echo $len 
    if [ $comp -lt $len ]
    then
    comp=$len
    fi
done

#echo $comp

    #num=$(($num+`expr length $
    sel[$select]=$(($comp+2)) #here '+' symbol will be printed last index will be +2 then lengthiest string in array
    echo ${sel[@]}
    num=$(($num+$comp+3))  #number of '- including +' be printed 
    echo $num
    select=$(($select+1)) #icrementing the index value by 1



#space=$space"-"
#echo $space
