# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include test::whoami
class test::whoami (
  Sensitive $message = 'Default Message'
) {
  notify { $message: }
  notify { 'I am here as well do not forget about me!': }
}


