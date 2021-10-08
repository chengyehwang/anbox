linux_source:
	wget https://github.com/microsoft/WSL2-Linux-Kernel/archive/refs/tags/linux-msft-wsl-5.10.60.1.tar.gz
	tar zxvf linux-msft-wsl-5.10.60.1.tar.gz

LINUX=WSL2-Linux-Kernel-linux-msft-wsl-5.10.60.1
config:
	cd ${LINUX} ; cp /proc/config.gz ./
	cd ${LINUX} ; gzip -d config.gz
	cd ${LINUX} ; mv config .config
	sudo apt install build-essential checkinstall zlib1g-dev -y
	make prepare
	make modules_prepare
	sudo ln ${PWD}/${LINUX} -s /lib/modules/${LINUX}/build
anbox:
	git clone https://github.com/anbox/anbox-modules.git
	sudo cp -rT ashmem /usr/src/anbox-ashmem-1
	sudo cp -rT binder /usr/src/anbox-binder-1
	sudo dkms install anbox-ashmem/1
	sudo dkms install anbox-binder/1
insert:
	sudo modprobe ashmem_linux
	sudo modprobe binder_linux


