#!/usr/bin/env python3

#need to extract node numbers from the parsed blast txt files to give as an argument to the extract_nodes.py file

#start with loading in the environment variable

import sys

with open(sys.argv[1],'r') as parsed_blast:
    #load in content of the file?
    content=parsed_blast.read()
    #use splitlines() function to convert the file content into a list of lines
    lines=content.splitlines()
    #create an empty list to only store the query lines in
    queries=[]
    nodes=[]
    #parse through the list of lines:
    for i in lines:
        #search for the node numbers between two identifying strings
        if i.startswith("Query="):
            queries.append(i)
    for j in queries:
        start=j.find("Query= NODE_") + len("Query= NODE_")
        end=j.find("_length")
        substring=j[start:end]
        nodes.append(substring)
    print(','.join(nodes))