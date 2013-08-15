compile:
	ocamlc -pp "camlp4o pa_extend.cmo q_MLast.cmo" -I +camlp4 -c where.ml

test: compile
	ocamlc -pp "camlp4o ./where.cmo" test.ml

run_test: compile test
	@echo "\033[1;31m\nShould desugar where into a let:\033[0m"
	@echo "\033[92mCatting test.ml\033[0m"
	@cat test.ml
	@echo "\033[92mDesugared version\033[0m"
	@camlp4o where.cmo test.ml

clean:
	@rm *.cmi *.cma *.out
	@rm -rf _build/
