testein-default:
	./testein.py --clean-elc --load-ert

testein-24:
	./testein.py --clean-elc -e emacs-snapshot

testein-unit-all:
	./testein.py --no-func-test --clean-elc --load-ert
	./testein.py --no-func-test --clean-elc -e emacs-snapshot

interactive-testein-default:
	./testein.py --clean-elc --load-ert --no-batch

interactive-testein-24:
	./testein.py --clean-elc -e emacs-snapshot --no-batch

ert-compile: ert-clean
	cd lib/ert/lisp/emacs-lisp/ && \
		emacs -Q -L . -batch -f batch-byte-compile *.el

ert-clean:
	rm -f lib/ert/lisp/emacs-lisp/*.elc

travis-ci: ert-compile
	./testein.py --no-func-test --clean-elc -e emacs-snapshot
	cat test-load_log_batch_emacs-snapshot.log
	cat test-load_messages_batch_emacs-snapshot.log
	./testein.py --no-func-test --clean-elc --load-ert
	cat test-load_log_batch_emacs.log
	cat test-load_messages_batch_emacs.log