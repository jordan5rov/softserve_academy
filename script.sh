#!/bin/bash

read -p 'Enter
        1. For Number of CPU Cores
        2. For Disk space
        3. For Size of RAM
        4. To provide information about the last users which were login on the host
        5. To calculate the number of active python/perl process
        6. To create a cron job which will send a report information on email address.
:' choice

if [ $choice -eq 1 ]
then
    echo "The number of CPU cores is $(nproc)"
fi


if [ $choice -eq 2 ]
then
    echo -e "The size of the disk space is\n$(df -h --output=source,used,avail /dev/sda1)"
fi

if [ $choice -eq 3 ]
then
    echo -e "The size of the RAM memmory is\n$(free -m)"
fi


if [ $choice -eq 4 ]
then
    echo -e "The last user logged on useron the host is\n$(last | head -n 1)\n"
fi


if [ $choice -eq 5 ]
then
    echo "The number of active python/perl proccess is $(pgrep -i 'python|perl' |wc -l)"
fi


if [ $choice -eq 6 ]
then
    output="The number of CPU cores is $(nproc)\n\n" 
    output="$output""The size of the disk space is\n$(df -h --output=source,used,avail /dev/sda1)\n\n" 
    output="$output""The size of the RAM memmory is\n$(free -m)\n\n" 
    output="$output""The last user logged on useron the host is\n $(last | head -n 1)\n\n"
    output="$output""The number of active python/perl proccess is $(pgrep -i 'python|perl' |wc -l)"
    echo -e $output

 
    crontab -l | { cat; echo "0 1 * * * mail -s \"Data\" jordan5rov@gmail.com <<< "$output" "; } | crontab -

fi