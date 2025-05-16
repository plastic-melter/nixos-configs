#!/bin/sh
Capacity=$(fdisk -l | grep '3.64 TiB' | awk '{print $5}' | cut -b 1-10);
Used1=$(df | grep Backups | awk '{print $3}');
Used2=$(df | grep dm-0 | awk '{print $3}');
Used1R=$(echo "$Used1 * 0.9094947" | bc | cut -d '.' -f 1);
Used2R=$(echo "$Used2 * 0.9094947" | bc | cut -d '.' -f 1);
CapR=$(echo "$Capacity * 0.9094947" | bc | cut -d '.' -f 1);
TotUsed=$(expr $Used1R + $Used2R);
printf -v Used "%.2f" "${TotUsed::-9}.${TotUsed: -9:8}"
printf -v Cap "%.2f" "${CapR::-9}.${CapR: -9:8}"
echo -n "${Used}TiB / ${Cap}TiB";
