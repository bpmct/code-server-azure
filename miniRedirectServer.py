#!/usr/bin/env python3

# A very bad redirect server that attempts to get the Coder Cloud URL from the logs and redirect the user.

import sys, re
from http.server import HTTPServer, BaseHTTPRequestHandler

if len(sys.argv)-1 != 1:
    print("""
Usage: {} <port_number>
    """.format(sys.argv[0]))
    sys.exit()

class Redirect(BaseHTTPRequestHandler):
   def do_GET(self):
    # get the last line from the code-server logs
    line = ""
    with open('code-server-logs.txt') as f:
        for line in f:
            pass
        last_line = line
    f.close()
    # try to find the URL
    try:
        url = re.search("(?P<url>https?://[^\s]+)", last_line).group("url")
    except:
        url = "https://github.com/bpmct/code-server-azure#troubleshooting"
    self.send_response(302)
    self.send_header('Location', url)
    self.end_headers()

print("Starting redirect server on port", sys.argv[1])
HTTPServer(("", int(sys.argv[1])), Redirect).serve_forever()