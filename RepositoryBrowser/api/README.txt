The GitHub API is rate-limited. In order to test and develop
against it the files in this directory can be published to a web server
and used as a testing proxy.

Run this in a web server (for example, python -m SimpleHTTPServer 1234)
and the API can be used against http://localhost:1234/index.json.
