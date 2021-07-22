require 'puppet/resource_api'

Puppet::ResourceApi.register_type(
  name: 'dsc_disk',
  dscmeta_resource_friendly_name: 'Disk',
  dscmeta_resource_name: 'DSC_Disk',
  dscmeta_resource_implementation: 'MOF',
  dscmeta_module_name: 'StorageDsc',
  dscmeta_module_version: '5.0.1',
  docs: 'The DSC Disk resource type.
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
    dsc_diskidtype: {
      type: "Optional[Enum['Number', 'UniqueId', 'Guid', 'Location']]",
      desc: 'Specifies the identifier type the DiskId contains. Defaults to Number.',

      mandatory_for_get: false,
      mandatory_for_set: false,
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
    dsc_size: {
      type: 'Optional[Integer[0, 18446744073709551615]]',
      desc: 'Specifies the size of new volume. Leave empty to use the remaining free space.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt64',
      mof_is_embedded: false,
    },
    dsc_fsformat: {
      type: "Optional[Enum['NTFS', 'ReFS']]",
      desc: 'Specifies the file system format of the new volume.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_allocationunitsize: {
      type: 'Optional[Integer[0, 4294967295]]',
      desc: 'Specifies the allocation unit size to use when formatting the volume.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'UInt32',
      mof_is_embedded: false,
    },
    dsc_allowdestructive: {
      type: 'Optional[Boolean]',
      desc: 'Specifies if potentially destructive operations may occur.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_partitionstyle: {
      type: "Optional[Enum['MBR', 'GPT']]",
      desc: 'Specifies the partition style of the disk. Defaults to GPT.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_driveletter: {
      type: 'String',
      desc: 'Specifies the identifier for which disk to modify.',
      behaviour: :namevar,
      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_fslabel: {
      type: 'Optional[String]',
      desc: 'Define volume label if required.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'String',
      mof_is_embedded: false,
    },
    dsc_cleardisk: {
      type: 'Optional[Boolean]',
      desc: 'Specifies if the disks partition schema should be removed entirely, even if data and OEM partitions are present. Only possible with AllowDestructive enabled.',

      mandatory_for_get: false,
      mandatory_for_set: false,
      mof_type: 'Boolean',
      mof_is_embedded: false,
    },
    dsc_diskid: {
      type: 'String',
      desc: 'Specifies the disk identifier for the disk to modify.',

      mandatory_for_get: true,
      mandatory_for_set: true,
      mof_type: 'String',
      mof_is_embedded: false,
    },
  },
)
