POLICY_ROOT=/var/cfengine/masterfiles
DEPLOY_DIR=$(POLICY_ROOT)/services/CIS
AUTORUN=true
AUTORUN_POLICY=cis_includefiles.cf

install:
	# Deploy policy to the correct location
	mkdir -p $(DEPLOY_DIR)
	cp -R policy/* $(DEPLOY_DIR)
	cp -R data $(DEPLOY_DIR)
	# If autorun is enabled deploy the autorun policy
ifeq ($(AUTORUN),true)
	cp extras/autorun/$(AUTORUN_POLICY) $(POLICY_ROOT)/services/autorun/
endif
	find $(DEPLOY_DIR) -type f | xargs chmod 600

uninstall:
	# Remove deployed policy
	rm -rf $(DEPLOY_DIR)
	# If autorun is enabled then remove the autorun policy
ifeq ($(AUTORUN),true)
	rm -rf extras/autorun/$(AUTORUN_POLICY) $(POLICY_ROOT)/services/autorun/
endif
