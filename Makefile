compile:
	@cd distel;make
	@cd flymake/bin;sh ./build_flymake.sh
clean:
	@cd distel;make clean
	@cd flymake/bin;rm eflymake *.beam
