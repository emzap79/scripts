import fileinput
import re
import subprocess
import sys

url_regex = re.compile("(((https?|ftp|gopher)://|(mailto|file|news):)[^' <>\"]+|(www|web|w3).[-a-z0-9.]+)[^' .,;<>\":]")

def remove_dups(seq):
    rslt = []
    for x in seq:
        if x not in rslt:
            rslt.append(x)
    return rslt

def run(filenames):
    lines = fileinput.input(filenames)
    results = remove_dups(
        [l[m.start():m.end()] for l in lines for m in re.finditer(url_regex, l)])

    sys.stdin = open('/dev/tty', 'r')

    print('== URLS ==')
    for i, s in enumerate(results):
        print('{}\t{}'.format(i, s))

    rslt = raw_input('Selection? ')
    idx = int(rslt)
    subprocess.Popen(['chromium-browser', results[idx]])

if __name__ == '__main__':
    run(sys.argv[1:])
