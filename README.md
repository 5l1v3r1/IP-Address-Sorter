# IP Address Sorter

These one liners and short scripts demonstrate quick and easy ways to sort IP addresses without have to write large or complex scripts.

## Sort IP addresses
```
sort -V ips.txt
```

## Sort IP addresses, remove duplicates, and remove blank lines
```
sort -Vu ips.txt | sed "/^$/d"
```

## Convert IP addresses to CIDRs

Sort CIDRs, remove duplicates, and remove blank lines. Display the CIDRs and the number of CIDRs created
```
cidrTempFile="cidrs.txt"
echo "" > $cidrTempFile
sort -Vu ips.txt | sed "/^$/d" | while read line; do
    octect1=`echo "$line" | cut -d "." -f 1`
    octect2=`echo "$line" | cut -d "." -f 2`
    octect3=`echo "$line" | cut -d "." -f 3`
    cidr="$octect1.$octect2.$octect3.0/24"
    echo $cidr >> $cidrTempFile
done
sort -Vu $cidrTempFile | sed "/^$/d"
echo "$(sort -Vu $cidrTempFile | sed "/^$/d" | wc -l | cut -d " " -f 1) CIDRs created."
```