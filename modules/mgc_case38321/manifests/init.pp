class mgc_case38321 {
  exec { 'case38321 exec test':
        command => "echo 'function output: ${helloworld()}'",
        path    => '/usr/bin:/usr/sbin:/bin',
        unless  => 'true'
  }
}
