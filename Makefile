.PHONY: test serve crawl run

test: env data
	PATH=env/bin:$(PATH) nosetests -v

serve: env data
	PATH=env/bin:$(PATH) python src/server.py

data: 
	mkdir data

run: serve

crawl: env
	PATH=env/bin:$(PATH) python src/crawler.py

env:
	pip install --upgrade -s -E env -r dependencies.txt

clean:
	find . -name "*.pyc" | xargs rm -f
	rm -f data/nuxeoorg.db
	#rm -f test.db test/test.db

superclean: clean
	rm -rf data/* env

push:
	rsync -avz -e ssh src Makefile dependencies.txt \
		nuxeo@styx.nuxeo.com:/var/www/home.nuxeo.org/
