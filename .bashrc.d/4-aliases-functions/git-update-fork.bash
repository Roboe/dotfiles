## Update git fork from upstream
function guf {
  git checkout master
  git pull upstream master
  git push origin master
}
