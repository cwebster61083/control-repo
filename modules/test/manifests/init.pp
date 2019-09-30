# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include test
class test ($message){
  notify { 'Notify Agent':
    message => $message
  }
}
