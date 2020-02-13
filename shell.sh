cd $JENKINS_HOME/workspace/$JOB_NAME
echo "$1"
names=""
for(i=1;i<="$#";i++)
do
  names=$names"$i"" "
done
mkdir static_code1
IFS=' ' read -r -a array <<< "$names"
for i in "${array[@]}"
do
  	IFS='/' read -r -a array1 <<< "$i"
	path=""
	p="/"
	temp=${#array1[@]}
	temp=$temp-1
	for index in "${!array1[@]}"
	do
   		if [ $index == $temp ]
    	then 
   			cp  $path${array1[index]} ./static_code1/$path${array1[index]}
            
   		else
        	mkdir $JENKINS_HOME/workspace/$JOB_NAME/static_code1/$path${array1[index]}
        	path=$path${array1[index]}$p
   		fi
   
	done 
done
export PATH=/usr/local/bin
cd /Users/srikar.nallapu/.jenkins/workspace/$JOB_NAME/static_code1
eslint  -f json -c $JENKINS_HOME/workspace/static_config.json  "./**" -o $JENKINS_HOME/workspace/$JOB_NAME/result.json || echo "lint failed but continiung the process"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
npm install request
