# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include writefile::testfile
class writefile::testfile {
  file { 'this_is_a_file':
    ensure  => 'present',
    path    => '/tmp/thisisanewfile.txt',
    content => 'This was writing by writefile::testfile',
  }
}
