from datetime import datetime, timedelta
from elasticsearch import Elasticsearch
from optparse import OptionParser
import re


def getIndices(es):
    indices = es.indices.get(index='*', request_timeout=60)
    return indices

def getIndicesOlderThan(indices, days):
    timedif = datetime.now() + timedelta(-days)
    indicesToDelete=[]
    for index in indices:
        m = re.match(r"^.*?-(\d{4})\.(\d{2})\.(\d{2})$", index)
        if(m):
            year = int(m.group(1))
            month = int(m.group(2))
            day = int(m.group(3))
            indexDate = datetime(year, month, day)
            if indexDate < timedif:
                indicesToDelete.append(index)
                print index
        else:
            print "Not the index we were looking for skipping"

    return indicesToDelete

def deleteIndices(es, indices):
    for index in indices:
        es.indices.delete(index=index)

def main():
    usage = "usage: %prog [options] arg"
    parser = OptionParser(usage)
    parser.add_option("--delete", dest="delete", action="store_true", help="Delete Indices")
    parser.add_option("-d", "--days", dest="days", type="int", help="Number of days to keep indices", default=60)

    (options, args) = parser.parse_args()

    es = Elasticsearch()
    indices = getIndices(es)
    indicesToDelete = getIndicesOlderThan(indices, options.days)

    if(options.delete):
        print "Indices being deleted"
        deleteIndices(es, indicesToDelete)
    else:
        print"Indices NOT being deleted:"
        for index in indicesToDelete:
            print index

if __name__ == "__main__":
    main()
