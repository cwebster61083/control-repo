# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include test::whoami
class test::whoami {
  $parameter = 'Default Parameter'

  notify { $parameter: }
  notify { 'I am here as well do not forget about me!': }
}


