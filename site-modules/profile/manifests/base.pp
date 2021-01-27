#Defualt profile
class profile::base (
  $message = ''
) {

  notify { 'Default Base Profile Message':
    message => "This is the base profile! I have a message for you: ${message}",
  }

}
