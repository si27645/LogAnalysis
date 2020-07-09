if [ $# -eq 0 ]
then
	clear
	gunzip *.gz
	rm -f Slow_* 
	cat *.log  | awk  ' NR==1 {print}  NR!=1 {a[substr($2,0,16)]+=$7;b[substr($2,0,16)]+=1;if(0+c[substr($2,0,16)]<$7)c[substr($2,0,16)]=$7} END{for (i in a){ printf "%-10s %-10s %-10s %-10s %-10s \n", c[i],a[i]/b[i],a[i],b[i],i}}' | awk '{if($1!="https") print $0}' | sort -n | tail -n 50  >Slow_By_Time ; cat  Slow_By_Time 
	echo "<MAX> <AVG> <SUM> <CNT> <TIME>"  
	read -p "Press any key to resume ..."
	cat *.log | awk -F'?' '{print $1}' | awk  ' NR==1 {print}  NR!=1 {a[$14]+=$7;b[$14]+=1;if(0+c[$14]<$7)c[$14]=$7} END{for (i in a){ printf "%-10s %-10s %-10s %-10s %-10s \n", c[i],a[i]/b[i],a[i],b[i],i}}' | awk '{if($1!="https") print $0}'   | sort -n  | tail -n 50 > Slow_By_URL ; cat  Slow_By_URL 
	echo "<MAX> <AVG> <SUM> <CNT>  <URL>"
	read -p "Press any key to resume ..."
	cat *.log | awk '{if($7 > 2) printf "%-10s %-10s %-10s \n", $2,$7,$14}' | awk '{if($1!="https") print $0}'   > Slow_requests
	cat *.log | awk '{if($7 > 2) printf "%-10s %-10s %-10s \n", $2,$7,$14}' | awk '{if($1!="https") print $0}'  | wc -l  >> Slow_requests 
	echo "Number of slow requests" >> Slow_requests  
	cat *.log   |  wc -l >> Slow_requests 
	echo "Number of requests" >> Slow_requests  ;cat Slow_requests
	read -p "Press any key to resume ..."
	cat *.log  | awk  ' NR==1 {print}  NR!=1 {a[substr($4,0,index($4,":")-1)]+=$7;b[substr($4,0,index($4,":")-1)]+=1;if(0+c[substr($4,0,index($4,":")-1)]<$7)c[substr($4,0,index($4,":")-1)]=$7} END{for (i in a){printf "%-10s %-10s %-10s %-10s %-10s \n", c[i],a[i]/b[i],a[i],b[i],i}}'  | awk '{if($1!="https") print $0}'  | sort -n  | tail -n 50 > Slow_By_IP ; cat Slow_By_IP
	  echo "<MAX> <AVG> <SUM> <CNT>  <IP>"
	  read -p "Press any key to resume ..."
	   
		if [ $(cat Slow_By_Time  | awk '{if($2>2) print $5}'  | awk '{if(index($1,"-")>0) print $1}'  | awk 'END { print r } { r = r ? r OFS $0 : $0 }  ' OFS=' ' | wc -c) -ge 3 ]; 
		then 
		cat Slow_By_Time  | awk '{if($2>2) print $5}'  | awk '{if(index($1,"-")>0) print $1}'  | awk 'END { print r } { r = r ? r OFS $0 : $0 }  ' OFS=' '  | xargs  sh $0
		fi
	  
	  #echo $y
	  #| xargs  sh $0
#while read in; do chmod 755 "$in"; done < file.txt
else
for Filter in "$@"
do
	cat *.log | grep $Filter  >Slow_By_Time_Pre_$Filter

	cat *.log | grep $Filter  | awk  ' NR==1 {print}  NR!=1 {a[substr($2,0,16)]+=$7;b[substr($2,0,16)]+=1;if(0+c[substr($2,0,16)]<$7)c[substr($2,0,16)]=$7} END{for (i in a){printf "%-10s %-10s %-10s %-10s %-10s \n", c[i],a[i]/b[i],a[i],b[i],i}}'  | awk '{if($1!="https") print $0}' | sort -n | tail -n 50  >Slow_By_Time_$Filter  ; cat  Slow_By_Time_$Filter
	echo "<MAX> <AVG> <SUM> <CNT> <TIME> "$Filter  
	#read -p "Press any key to resume ..."
	cat *.log | grep $Filter  |  awk -F'?' '{print $1}' | awk  ' NR==1 {print}  NR!=1 {a[$14]+=$7;b[$14]+=1;if(0+c[$14]<$7)c[$14]=$7} END{for (i in a){printf "%-10s %-10s %-10s %-10s %-10s \n", c[i],a[i]/b[i],a[i],b[i],i}}' | awk '{if($1!="https") print $0}'   | sort -n  | tail -n 50 > Slow_By_URL_$Filter ; cat  Slow_By_URL_$Filter 
	echo "<MAX> <AVG> <SUM> <CNT>  <URL>"$Filter  
	#read -p "Press any key to resume ..."
	cat *.log | grep $Filter  | awk '{if($7 > 2) printf "%-10s %-10s %-10s \n", $2,$7,$14}' | awk '{if($1!="https") print $0}'   > Slow_requests_$Filter
	cat *.log | grep $Filter  | awk '{if($7 > 2) printf "%-10s %-10s %-10s \n", $2,$7,$14}' | awk '{if($1!="https") print $0}' | wc -l  >> Slow_requests_$Filter 
	echo "Number_of_slow_requests"$Filter   >> Slow_requests_$Filter  
	cat *.log  | grep $Filter   |  wc -l >> Slow_requests_$Filter 
	echo "Number_of_requests"$Filter   >> Slow_requests_$Filter  ;cat Slow_requests_$Filter
	#read -p "Press any key to resume ..."
	cat *.log  | grep $Filter  | awk  ' NR==1 {print}  NR!=1 {a[substr($4,0,index($4,":")-1)]+=$7;b[substr($4,0,index($4,":")-1)]+=1;if(0+c[substr($4,0,index($4,":")-1)]<$7)c[substr($4,0,index($4,":")-1)]=$7} END{for (i in a){print c[i],a[i]/b[i],a[i],b[i],i}}'  | awk '{if($1!="https") print $0}'  | sort -n  | tail -n 50 > Slow_By_IP_$Filter ; cat Slow_By_IP_$Filter
	  echo "<MAX> <AVG> <SUM> <CNT>  <IP>"$Filter  
	  
	cat Slow_By_Time_$Filter  | awk '  BEGIN{print "<table><tr><th>MAX</th><th>AVG</th><th>SUM</th><th>CNT</th><th>TIME</th></tr>"}   {printf("<tr><td>%d</td><td>%d</td><td>%d</td><td>%d</td><td>%s</td></tr>\n",$1,$2,$3,$4,$5)}  END{print "</table>"} ' > Slow_By_Time_$Filter".html"
	cat Slow_By_URL_$Filter  | awk '  BEGIN{print "<table><tr><th>MAX</th><th>AVG</th><th>SUM</th><th>CNT</th><th>URL</th></tr>"}    {printf("<tr><<td>%d</td><td>%d</td><td>%d</td><td>%d</td><td>%s</td></tr>\n",$1,$2,$3,$4,$5)}  END{print "</table>"} ' > Slow_By_URL_$Filter".html"
	cat Slow_requests_$Filter  | awk ' BEGIN{print "<table><tr><th>TIME</th><th>duration</th><th>URL</th></tr>"}    {printf("<tr><td>%s</td><td>%d</td><td>%s</td></tr>\n",$1,$2,$3)}  END{print "</table>"}' > Slow_requests_$Filter".html" 
	cat Slow_By_IP_$Filter  | awk ' BEGIN{print "<table><tr><th>MAX</th><th>AVG</th><th>SUM</th><th>CNT</th><th>IP</th></tr>"}     {printf("<tr><td>%d</td><td>%d</td><td>%d</td><td>%d</td><td>%s</td></tr>\n",$1,$2,$3,$4,$5)} END{print "</table>"} '  > Slow_By_IP_$Filter".html"
	
	echo '<style>h1,h2,h3,h4,h5,h6 {	margin:0;}table {width:100%;border:1px solid black;}th {text-transform:uppercase;background:#000;color: white;}td{background-color:#1770FA;color:white;flex: 1 1 20%;text-align:center;}</style>' >>Slow_By_Time_$Filter".html"
	echo '<style>h1,h2,h3,h4,h5,h6 {	margin:0;}table {width:100%;border:1px solid black;}th {text-transform:uppercase;background:#000;color: white;}td{background-color:#1770FA;color:white;flex: 1 1 20%;text-align:center;}</style>' >>Slow_By_URL_$Filter".html"
	echo '<style>h1,h2,h3,h4,h5,h6 {	margin:0;}table {width:100%;border:1px solid black;}th {text-transform:uppercase;background:#000;color: white;}td{background-color:#1770FA;color:white;flex: 1 1 20%;text-align:center;}</style>' >>Slow_requests_$Filter".html"
	echo '<style>h1,h2,h3,h4,h5,h6 {	margin:0;}table {width:100%;border:1px solid black;}th {text-transform:uppercase;background:#000;color: white;}td{background-color:#1770FA;color:white;flex: 1 1 20%;text-align:center;}</style>' >>Slow_By_IP_$Filter".html"
	
done
fi
