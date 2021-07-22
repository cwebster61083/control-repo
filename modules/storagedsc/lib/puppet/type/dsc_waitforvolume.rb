require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_waitforvolume',
  dscmeta_resource_friendly_name: 'WaitForVolume',
  dscmeta_resource_name: 'DSC_WaitForVolume',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'StorageDsc',
  dscmeta_module_version: '5.0.1',
  docs: 'The DSC WaitForVolume resource type.
         Automatically generated from version 5.0.1',
  features: ['simple_get_filter', 'canonicalize', 'custom_insync'],
  attributes: {
    name: {
      type:      'String',
      desc:      'Description of the purpose for this resource declaration.',
      behaviour: :namevar,
    },
    validation_mode: {
      type:      'Enum[property, resource]',
      desc:      'Whether to check if the resource is in the desired state by property (default) or using Invoke-DscResource in Test mode (resource).',
      behaviour: :parameter,
      default:   'property',
    },
    dsc_driveletter: {
      type: 'String',
      desc: 'Specifies the drive letter of the volume to wait for.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_retrycount: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'The number of times to loop the retry interval while waiting for the volume.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_psdscrunascredential: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: ' ',
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_retryintervalsec: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the number of seconds to wait for the volume to become available.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
  },
)
