info:
	@echo "build		build the otpserver image"
	@echo "push		push the image to the docker hub"

build:
	docker.io build -rm -t privacyidea/otpserver .

push:
	docker.io push privacyidea/otpserver

