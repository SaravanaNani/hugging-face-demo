install:
	pip install --upgrade pip
	pip install -r requirements.txt

test:
	python -m pytest -vvv --cov=hello --cov=greeting \
		--cov=smath --cov=web tests
	# test jupyter notebook
	python -m pytest -nbval notebook.ipynb
	# python -m pytest -v tests/test_web.py # if you just want to test web

debug:
	python -m pytest --v -pdb
	# Debugger is invoked

one-test:
	python -m pytest -vv tests/tests_greeting.py::test_my_name4

clean:
	rm -rf .venv