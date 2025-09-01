start:
	echo "just testing: cpman and policy one shot"
	./scripts/cpman-up.sh
	 ./scripts/cpman-wait-for-api.sh ; ./scripts/policy-up.sh
	 ./scripts/cpman-pass.sh

down:
	./scripts/cpman-wait-for-api.sh ; ./scripts/policy-down.sh
	./scripts/cpman-down.sh


.PHONY: slides login-sp check-reader

slides:
	./scripts/slides.sh

sp-login: login-sp
login-sp:
	./scripts/login-sp.sh

check-reader:
	./scripts/check-reader.sh

cpman: cpman-up cpman-wait policy-up cpman-pass

cpman-up:
	./scripts/cpman-up.sh

cpman-down:
	./scripts/cpman-down.sh

cpman-serial:
	./scripts/cpman-serial.sh

cpman-ssh:
	./scripts/cpman-ssh.sh

cpman-wait:
	./scripts/cpman-wait-for-api.sh

cpman-pass:
	./scripts/cpman-pass.sh


policy: policy-up

policy-up:
	./scripts/policy-up.sh

policy-down:
	./scripts/policy-down.sh

vmss: vmss-up

vmss-up:
	./scripts/vmss-up.sh

vmss-down:
	./scripts/vmss-down.sh

cme:
	./scripts/cme.sh

linux:linux-up
	
linux-up:
	./scripts/linux-up.sh
linux-down:
	./scripts/linux-down.sh
linux-ssh:
	./scripts/linux-ssh.sh
fwoff:
	./scripts/linux-fwoff.sh
fwon:
	./scripts/linux-fwon.sh

vw-ssh-1:
	./scripts/vwan-ssh.sh 1
vw-ssh-2:
	./scripts/vwan-ssh.sh 2
vw-ssh:
	./scripts/vwan-ssh.sh 


linux77-ssh:
	./scripts/linux77-ssh.sh
linux68-ssh:
	./scripts/linux68-ssh.sh

vwan-up:
	./scripts/vwan-up.sh
vwan-ssh:
	./scripts/vwan-ssh.sh
vwan-ssh-1:
	./scripts/vwan-ssh.sh 1
vwan-ssh-2:
	./scripts/vwan-ssh.sh 2
vwan-ssh-a:
	./scripts/vwan-ssh.sh 1
vwan-ssh-b:
	./scripts/vwan-ssh.sh 2

vwan-spoke77:
	./scripts/vwan-spoke77-up.sh
vwan-spoke77-up: vwan-spoke77

vwan-spoke68-up:
	./scripts/vwan-spoke68-up.sh
vwan-spoke68: vwan-spoke68-up


waf-ssh:
	./scripts/waf-ssh.sh