## HTTP server. From this superuseful Gist: https://gist.github.com/willurd/5720255
[[ $(check_command python2) ]] && alias serve2='echo "Serving on http://localhost:8000/" && python2 -m SimpleHTTPServer 8000'
[[ $(check_command python3) ]] && alias serve3='echo "Serving on http://localhost:8000/" && python3 -m http.server 8000'


## FTP server. Prerequisite: 'python-pyftpdlib' or 'python3-pyftpdlib' package
[[ $(check_command python2) ]] && alias ftpserve2='echo "Serving on http://localhost:2121/" && python2 -m pyftpdlib'
[[ $(check_command python3) ]] && alias ftpserve3='echo "Serving on http://localhost:2121/" && python3 -m pyftpdlib'


if [[ $(check_command python2) ]]
then # Prefer python2 server
  alias serve='serve2'
  alias ftpserve='ftpserve2'
elif [[ $(check_command python3) ]]
then # Fallback to python3 server
  alias serve='serve3'
  alias ftpserve='ftpserve3'
fi
