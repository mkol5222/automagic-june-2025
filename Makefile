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

reader-check: check-reader
reader-test: check-reader
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
linux208-ssh:
	./scripts/linux208-ssh.sh

vwan: vwan-up
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



waf-ssh:
	./scripts/waf-ssh.sh

vwan-down:
	./scripts/vwan-down.sh

vwan-spokes-up: vwan-spokes
vwan-spokes:
	./scripts/vwan-spokes-up.sh

vwan-spokes-down:
	./scripts/vwan-spokes-down.sh

vwan-cme-up:
	./scripts/vwan-cme-api-env.sh
	./scripts/vwan-cme-calls.sh
vwan-fwon:
	./scripts/vwan-fwon.sh
vwan-fwoff:
	./scripts/vwan-fwoff.sh
vwan-lbrules:
	./scripts/vwan-lbrules.sh
vwan-lbrules-set:
	./scripts/vwan-set-lbrules.sh

vwan-lbips:
	./scripts/vwan-lbips.sh
vwan-fwstate:
	./scripts/vwan-fwstate.sh


vwan-pip: vwan-pip-up
vwan-pip-up:
	./scripts/vwan-pip-up.sh
vwan-pip-down:
	./scripts/vwan-pip-down.sh

cpman-install-policy:
	./scripts/cpman-ssh.sh mgmt_cli -r true install-policy policy-package vmss

vnet68-policy:
	./scripts/vnet68-policy.sh
vnet68-update: vnet68-policy cpman-install-policy