#!/usr/bin/env python

import plugins


class Crawler(object):

    def __init__(self):
        self.sources = plugins.sources

    def crawl(self):
        for source in self.sources:
            print "Crawling", source
            source.crawl()


if __name__ == '__main__':
    plugins.init()
    crawler = Crawler()
    crawler.crawl()
