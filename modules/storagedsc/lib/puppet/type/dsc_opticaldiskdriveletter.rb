require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_opticaldiskdriveletter',
  dscmeta_resource_friendly_name: 'OpticalDiskDriveLetter',
  dscmeta_resource_name: 'DSC_OpticalDiskDriveLetter',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'StorageDsc',
  dscmeta_module_version: '5.0.1',
  docs: 'The DSC OpticalDiskDriveLetter resource type.
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
      desc: 'Specifies the drive letter to assign to the optical disk. Can be a single letter, optionally followed by a colon. This value is ignored if Ensure is set to Absent.',

      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_diskid: {
      type: 'String',
      desc: 'Specifies the optical disk number for the disk to assign the drive letter to.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
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
    dsc_ensure: {
      type: "Optional[Enum['Present', 'Absent']]",
      desc: "Determines whether a drive letter should be assigned to the optical disk. Defaults to 'Present'.",

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
