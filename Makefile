info:
	@echo "build		build the otpserver image"

build:
	docker.io build -rm -t privacyidea/otpserver .
