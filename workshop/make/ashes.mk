funk-%-funky: ashes-%-ashes
	@echo from $< to $@, the stem is $*
	cp $< $@

#{ #
#{ 
#{ hello:
#{ 	echo hello
#{ 
# zsh := $(shell which ksh)
# SHELL = $(ksh)
# .PHONY: hello
# 
# hello:
# 	@- false
# 	@ echo hello from $(SHELL),
# 	@ echo according to ps i am $(shell ps hopid,command $$$$)
# 	@ echo according to ps i am $(shell ps hopid,command $$$$)
# 
# 	#@- false
# 	#@- for e (world $$USER) { \
# 	#    print $$e  \
# 	#}
