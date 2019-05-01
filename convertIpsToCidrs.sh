# Set the temporary CIDR file name
cidrTempFile="cidrs.txt"

# Create a new file
echo "" > $cidrTempFile

# Convert to CIDR
sort -Vu ips.txt | sed "/^$/d" | while read line; do

    # Get the first three octects
    octect1=`echo "$line" | cut -d "." -f 1`
    octect2=`echo "$line" | cut -d "." -f 2`
    octect3=`echo "$line" | cut -d "." -f 3`

    # Create the CIDR
    cidr="$octect1.$octect2.$octect3.0/24"

    # Add the CIDR to the file
    echo $cidr >> $cidrTempFile
done

# Sort CIDRs, remove duplicates, remove blank lines
sort -Vu $cidrTempFile | sed "/^$/d"

# Echo the number of CIDRs
echo "$(sort -Vu $cidrTempFile | sed "/^$/d" | wc -l | cut -d " " -f 1) CIDRs created."