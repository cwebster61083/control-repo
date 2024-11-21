#Defualt profile
class profile::base (
  $simple = lookup('simple', Hash, 'deep'),
  $complex = lookup('role::name::complex', Hash, 'deep'),
) {
  # notify { "${simple}":}
  # notify { "${complex}":}
}
