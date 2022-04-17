# What this script does:
# 1. make a list of paired bluetooth devices
# 2. checks if any device is already connected
# 3. if any device is already connected, disconnect it
# 4. start trying to connect to other devices in the paired devices list
# 5. if no other device is available reconnect to the previously connected device

rfkill unblock bluetooth;
bluetoothctl power on;
command_output=$(bluetoothctl paired-devices);
paired_devs=();
IFS=' ';
index=0;
n_paired=0;
for word in $command_output; do
	if [[ $word =~ ([A-Z0-9]{2}:){5}[A-Z0-9]{2} ]]; then
		paired_devs+=($word)
		n_paired+=1
	fi; done
for idx in ${!paired_devs[@]}; do
	dev=${paired_devs[$idx]}
	if [[ $(bluetoothctl info $dev) == *'Connected: yes'* ]]; then
		index=($idx+1)
		bluetoothctl disconnect $dev
		break
	fi; done
paired_devs_=();
paired_devs_=${paired_devs[@]:index:n_paired}
paired_devs_+=(${paired_devs[@]:0:index})
echo ${paired_devs_[@]}
for dev in ${paired_devs_[@]}; do
	if [[ $(bluetoothctl connect $dev) == *'Connection successful'* ]]; then
		break
	fi; done
