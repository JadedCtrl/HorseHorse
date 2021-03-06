mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

love:
	zip -9r bin/horseseahorse.love ./*

win32: love
ifeq (,$(wildcard bin/love-win32.zip))
	wget -O bin/love-win32.zip \
		https://github.com/love2d/love/releases/download/11.3/love-11.3-win32.zip
endif
	unzip -d bin/ bin/love-win32.zip
	mv bin/love-*-win32 bin/horseseahorse-win32
	rm bin/horseseahorse-win32/changes.txt
	rm bin/horseseahorse-win32/readme.txt
	rm bin/horseseahorse-win32/lovec.exe
	cat bin/horseseahorse.love >> bin/horseseahorse-win32/love.exe
	mv bin/horseseahorse-win32/love.exe bin/horseseahorse-win32/HorseHorse.exe
	cp lib/bin-license.txt bin/horseseahorse-win32/license.txt
	zip -9jr bin/horseseahorse-win32.zip bin/horseseahorse-win32
	rm -rf bin/horseseahorse-win32

test: love
	love bin/horseseahorse.love

clean: 
	rm -rf ./bin/*

all: love win32
