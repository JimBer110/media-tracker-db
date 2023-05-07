
.PHONY: all install

all:

install:
	python3 -m venv venv
	. venv/bin/activate && pip3 install -r requirements.txt
	echo -e "host=\nuser=\npass=\ndatabase=" > config.conf
