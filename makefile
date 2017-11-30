POLICY_ROOT=/var/cfengine/masterfiles
DEPLOY_DIR=$(POLICY_ROOT)/services/CIS
AUTORUN=true
AUTORUN_POLICY=cis_includefiles.cf

install:
	# Deploy policy to the correct location
	mkdir -p $(DEPLOY_DIR)
	cp -R policy/* $(DEPLOY_DIR)
  # TODO Clean this up I don't think we want people to have to modify the policy
  # in order to do get the desired behavior. Or better understand the reasoning
  # for this.
	sed -i "s/use_this_do_set_custom_tags/$(CUSTOM_TAG)/" $(DEPLOY_DIR)/cis_wrapper.cf
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
