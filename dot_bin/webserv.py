#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
Launch small http server

Works on both Python 2 and 3
"""

import sys
import signal

def default_port():
    return 4000

def main():
    try:
        from SimpleHTTPServer import SimpleHTTPRequestHandler
    except ImportError:
        from http.server import SimpleHTTPRequestHandler

    try:
        from SocketServer import TCPServer as HTTPServer
#         from BaseHTTPServer import HTTPServer
    except ImportError:
        from http.server import HTTPServer

    # simple web server
    # serves files relative to the current directory.

    try:
        server_port = int(sys.argv[1])
    except:
        server_port = default_port()

    httpd = HTTPServer(("", server_port), SimpleHTTPRequestHandler)
    #httpd.header.send_header("Access-Control-Allow-Origin", "*")
    print("serving at port {0}".format(server_port))

    # Let's cleanup after ourselves
    def signal_handler(signal,frame):
        print("\nCleaning up\n")
        httpd.shutdown
        sys.exit(0)

    signal.signal(signal.SIGINT, signal_handler)
    httpd.serve_forever()

if __name__ == '__main__':
    main()

