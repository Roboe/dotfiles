## Configure the default Java version
function choosejava {
  sudo update-alternatives --config java
  sudo update-alternatives --config javac
  echolorize --title "$(emoji "cup") Java interpreter version"
  java -version
  echolorize --title "$(emoji "traffic light") Java compiler version"
  javac -version
}
