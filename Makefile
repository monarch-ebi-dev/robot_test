fail_extract:
	robot -vv extract -i logical_dependencies_merged.owl --term-file src_seed.txt --method BOT --force true -o $@.mod.owl
	
fail_extract_empty:
	robot -vv extract -i logical_dependencies_merged.owl --term-file empty_seed.txt --force true --method BOT -o $@.mod.owl

fail_remove_termfile.txt:
	robot remove --input o_remove.owl --term-file non_native_classes.txt -o $@.tmp &&\
	cat $@.tmp $(ONTOLOGYTERMS) | sort | uniq >  $@ && rm -f $@.tmp

fail_seed_by_entity_type.txt:
	robot query --use-graphs false -f csv -i missing-declaration-sparql-test.owl --query object-properties.sparql $@.tmp &&\
	cat $@.tmp $(ONTOLOGYTERMS) | sort | uniq >  $@ && rm -f $@.tmp 

fail_seed_by_entity_type_cl.txt:
	robot query --use-graphs false -f csv -i cl-edit.owl --query object-properties.sparql $@.tmp &&\
	cat $@.tmp $(ONTOLOGYTERMS) | sort | uniq >  $@ && rm -f $@.tmp 

works_seed_by_entity_type_cl.txt:
	robot query --use-graphs false -f csv -i cl-edit.owl --query object-properties-alt.sparql $@.tmp &&\
	cat $@.tmp $(ONTOLOGYTERMS) | sort | uniq >  $@ && rm -f $@.tmp 

works_seed_by_entity_type:
	robot query --use-graphs false -f csv -i missing-declaration-sparql-test.owl --query object-properties-alt.sparql $@.txt 

cl_seed_test: fail_seed_by_entity_type_cl.txt works_seed_by_entity_type_cl.txt

fail_remove:
	robot -vv remove -I http://purl.obolibrary.org/obo/cl.owl --term rdfs:label --select complement --select annotation-properties -o cl_test.owl