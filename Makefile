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

fail_remove2:
	robot remove --term-file non_native_classes.txt -i test-basic.owl -o test-o-basic.owl

fail_remove:
	robot -vv remove -I http://purl.obolibrary.org/obo/cl.owl --term rdfs:label --select complement --select annotation-properties -o cl_test.owl

fail_trim_anonymous:
	echo "Test shows that I cant get axioms with anonymous expressions even if all entities are in my filter."
	robot filter -i trim-true-anonymous.owl --term-file terms-trim-select.txt --trim true --select "self annotations anonymous" --preserve-structure false --output $@.owl

fail_trim_anonymous_owl:
	echo "Test shows that even after adding all owl classes, I still dont get the anonymous restriction."
	robot filter -i trim-true-anonymous.owl --term-file terms-trim-select-owl.txt --trim true --select "self annotations anonymous" --compare named --preserve-structure false --output $@.owl
	
fail_extract_import.owl:
	robot extract -i asubbimp.owl --term "http://www.purl.obolibrary.org/test/C" --method BOT --output $@

fail_extract_import_exclude.owl:
	robot extract -i asubbimp.owl --term "http://www.purl.obolibrary.org/test/C" --imports exclude --method BOT --output $@

test_extract_import_exclude: fail_extract_import.owl fail_extract_import_exclude.owl
	
fail-remove-filter.owl:
	robot remove --input input-fail-remove-filter.owl --axioms equivalent \
		filter --term-file simple_seed.txt --trim true --signature true --output $@

fail_trim_anonymous_parents:
	echo "Test shows that by adding parents, you get A, which I dont want."
	robot filter -i trim-true-anonymous.owl --term-file terms-trim-select.txt --trim true --select "self annotations anonymous parents" --preserve-structure false --output $@.owl
	
fail_remove_definitions:
	robot remove --input o.owl --term-file simple-rm.txt --axioms annotation --trim false -o $@.owl