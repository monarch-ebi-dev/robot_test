fail_extract:
	robot -vv extract -i logical_dependencies_merged.owl --term-file src_seed.txt --method BOT --force true -o $@.mod.owl
	
fail_extract_empty:
	robot -vv extract -i logical_dependencies_merged.owl --term-file empty_seed.txt --force true --method BOT -o $@.mod.owl

fail_remove_termfile:
	robot remove --input o_remove.owl --term-file non_native_classes.txt -o $@.owl

fail_remove:
	robot -vv remove -I http://purl.obolibrary.org/obo/cl.owl --term rdfs:label --select complement --select annotation-properties -o cl_test.owl