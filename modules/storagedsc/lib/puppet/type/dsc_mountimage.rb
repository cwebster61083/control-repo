require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_mountimage',
  dscmeta_resource_friendly_name: 'MountImage',
  dscmeta_resource_name: 'DSC_MountImage',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'StorageDsc',
  dscmeta_module_version: '5.0.1',
  docs: 'The DSC MountImage resource type.
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
    dsc_psdscrunascredential: {
      type: 'Optional[Struct[{ user => String[1], password => Sensitive[String[1]] }]]',
      desc: ' ',
      behaviour: :parameter,
      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'PSCredential',
      mof_is_embedded: true,
    },
    dsc_storagetype: {
      type: "Optional[Enum['ISO', 'VHD', 'VHDx', 'VHDSet']]",
      desc: 'Specifies the storage type of a file. If the StorageType parameter is not specified, then the storage type is determined by file extension.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_ensure: {
      type: "Optional[Enum['Present', 'Absent']]",
      desc: 'Determines whether the VHD or ISO should be mounted or not.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_driveletter: {
      type: 'Optional[String]',
      desc: 'Specifies the drive letter to mount this VHD or ISO to.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_imagepath: {
      type: 'String',
      desc: 'Specifies the path of the VHD or ISO file.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_access: {
      type: "Optional[Enum['ReadOnly', 'ReadWrite']]",
      desc: 'Allows a VHD file to be mounted in read-only or read-write mode. ISO files are mounted in read-only mode regardless of what parameter value you provide.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
