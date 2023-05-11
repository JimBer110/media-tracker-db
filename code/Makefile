
.PHONY: all install

all:

install:
	python3 -m venv venv
	. venv/bin/activate && pip3 install -r requirements.txt
ifeq (,$(wildcard ./config.conf))
	echo -e "host=localhost\nuser=user\npass=password\ndatabase=database_name" > config.conf
endif
