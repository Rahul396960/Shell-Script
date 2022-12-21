
a=0
#b="exit"
while [ $a -lt 10 ]
do

echo "enter number:" 
read num

if [ $num == "exit" ]
then
break
else

res=$(($num*$num))
echo $res
a=$(($a+1))
fi

done
