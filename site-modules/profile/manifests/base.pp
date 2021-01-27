#Defualt profile
class profile::base (
  $message = ''
) {

  notify {"This is the base profile! I am ${facts['networking']['hostname']}":}

}
