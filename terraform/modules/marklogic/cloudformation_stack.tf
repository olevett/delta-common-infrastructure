# Taken from MarkLogic documentation: 
# https://docs.marklogic.com/guide/ec2/CloudFormation

resource "aws_cloudformation_stack" "network" {
  name = "networking-stack"

  parameters = {
    VPCCidr = "10.0.0.0/16"
  }

  template_body = <<STACK
AWSTemplateFormatVersion: 2010-09-09
Description: Deploy a MarkLogic Cluster on AWS in existing VPC (Virtual Private Cloud).
Metadata:
  version: 10.0-9.2
  binary: MarkLogic-10.0-9.2.x86_64.rpm
  AWS::CloudFormation::Interface:
    ParameterGroups:
      - Label:
          default: "Resource Configuration"
        Parameters:
          - IAMRole
          - VolumeSize
          - VolumeType
          - VolumeEncryption
          - VolumeEncryptionKey
          - InstanceType
          - SpotPrice
          - KeyName
          - NumberOfZones
          - NodesPerZone
          - AZ
          - LogSNS
      - Label:
          default: "Network Configuration"
        Parameters:
          - VPC
          - PublicSubnet1
          - PublicSubnet2
          - PublicSubnet3
          - PrivateSubnet1
          - PrivateSubnet2
          - PrivateSubnet3
      - Label:
          default: "MarkLogic Configuration"
        Parameters:
          - AdminUser
          - AdminPass
          - Licensee
          - LicenseKey
    ParameterLabels:
      AdminUser:
        default: Admin User
      AdminPass:
        default: Admin password
      Licensee:
        default: Licensee
      LicenseKey:
        default: License Key
      IAMRole:
        default: IAM Role
      LogSNS:
        default: Logging SNS ARN
      VolumeSize:
        default: Volume Size
      VolumeType:
        default: Volume Type
      VolumeEncryption:
        default: Volume Encryption
      VolumeEncryptionKey:
        default: Volume Encryption Key ARN
      InstanceType:
        default: Instance Type
      SpotPrice:
        default: Spot Price
      KeyName:
        default: SSH Key Name
      NumberOfZones:
        default: Number of Zones
      NodesPerZone:
        default: Nodes per Zone
      AZ:
        default: Availability Zone
      VPC:
        default: VPC
      PublicSubnet1:
        default: Public Subnet 1
      PublicSubnet2:
        default: Public Subnet 2
      PublicSubnet3:
        default: Public Subnet 3
      PrivateSubnet1:
        default: Private Subnet 1
      PrivateSubnet2:
        default: Private Subnet 2
      PrivateSubnet3:
        default: Private Subnet 3
Parameters:
  # resource configuration
  IAMRole:
    Description: IAM Role
    Type: String
  VolumeSize:
    Description: The EBS Data volume size (GB) for all nodes
    Type: Number
    MinValue: '10'
    MaxValue: '1000'
    Default: '10'
  VolumeType:
    Description: The EBS Data volume Type
    Type: String
    AllowedValues:
      - standard
      - gp2
    Default: gp2
  VolumeEncryption:
    Description: Whether to enable volume encryption
    Type: String
    AllowedValues:
      - enable
      - disable
    Default: enable
  VolumeEncryptionKey:
    Description: The key ID of AWS KMS key to encrypt volumes - Optional
    Type: String
    Default: ""
  InstanceType:
    Description: Type of EC2 instance to launch
    Type: String
    Default: r5.4xlarge
    AllowedValues:
      - ---- Essential Enterprise and Bring-Your-Own-License ----
      - m4.xlarge
      - m4.2xlarge
      - m4.4xlarge
      - m4.10xlarge
      - m4.16xlarge
      - m5.xlarge
      - m5.2xlarge
      - m5.4xlarge
      - m5.8xlarge
      - m5.12xlarge
      - m5.16xlarge
      - m5.24xlarge
      - m5a.xlarge
      - m5a.2xlarge
      - m5a.4xlarge
      - m5a.8xlarge
      - m5a.12xlarge
      - m5a.16xlarge
      - m5a.24xlarge
      - c3.xlarge
      - c4.xlarge
      - c4.2xlarge
      - c4.4xlarge
      - c4.8xlarge
      - c5.xlarge
      - c5.2xlarge
      - c5.4xlarge
      - c5.9xlarge
      - c5.18xlarge
      - x1.16xlarge
      - x1e.xlarge
      - x1e.2xlarge
      - x1e.4xlarge
      - x1e.8xlarge
      - x1e.16xlarge
      - r3.xlarge
      - r3.2xlarge
      - r3.4xlarge
      - r3.8xlarge
      - r4.xlarge
      - r4.2xlarge
      - r4.4xlarge
      - r4.8xlarge
      - r4.16xlarge
      - r5.xlarge
      - r5.2xlarge
      - r5.4xlarge
      - r5.8xlarge
      - r5.12xlarge
      - r5.16xlarge
      - r5.24xlarge
      - r5a.xlarge
      - r5a.2xlarge
      - r5a.4xlarge
      - r5a.8xlarge
      - r5a.12xlarge
      - r5a.16xlarge
      - r5a.24xlarge
      - p3.2xlarge
      - p3.8xlarge
      - p3.16xlarge
      - i3.xlarge
      - i3.2xlarge
      - i3.4xlarge
      - i3.8xlarge
      - i3.16xlarge
      - -------------- Bring-Your-Own-License Only --------------
      - t2.small
      - t2.medium
      - t2.large
      - t2.xlarge
      - t2.2xlarge
      - m3.medium
      - m3.large
      - m3.xlarge
      - m3.2xlarge
      - m4.large
      - m5.large
      - c3.large
      - c3.2xlarge
      - c3.4xlarge
      - c3.8xlarge
      - c4.large
      - c5.large
      - x1.32xlarge
      - r3.large
      - r4.large
      - p2.xlarge
      - p2.8xlarge
      - p2.16xlarge
      - g2.2xlarge
      - g2.8xlarge
      - g3s.xlarge
      - g3.4xlarge
      - g3.8xlarge
      - g3.16xlarge
      - f1.2xlarge
      - f1.16xlarge
      - h1.2xlarge
      - h1.4xlarge
      - h1.8xlarge
      - h1.16xlarge
      - hs1.8xlarge
      - i2.xlarge
      - i2.2xlarge
      - i2.4xlarge
      - i2.8xlarge
      - i3.large
      - d2.xlarge
      - d2.2xlarge
      - d2.4xlarge
      - d2.8xlarge
      - t3.nano
      - t3.large
      - t3.xlarge
      - t3.small
      - t3.micro
      - t3.2xlarge
      - t3.medium
  SpotPrice:
    Description: Spot price for instances in USD/Hour - Optional/advanced
    Type: Number
    MinValue: '0'
    MaxValue: '2'
    Default: '0'
  KeyName:
    Description: Name of and existing EC2 KeyPair to enable SSH access to the instance
    Type: String
  NumberOfZones:
    Description: Total number of Availability Zones, which can be 1 or 3. Load balancer type depends on the number of zones selected. Select 3 zones for Application Load Balancer (OR) Select 1 zone for Classic Load Balancer.
    Type: Number
    AllowedValues:
      - 1
      - 3
    Default: 3
  NodesPerZone:
    Description: Total number of nodes per Zone. Set to 0 to shutdown/hibernate
    Type: Number
    MinValue: '0'
    MaxValue: '20'
    Default: '1'
  AZ:
    Description: The Availability Zones for VPC subnets. Accept either 1 zone or 3 zones. In the order of Subnet 1, Subnet 2 and Subnet 3 (if applicable).
    Type: 'List<AWS::EC2::AvailabilityZone::Name>'
  LogSNS:
    Description: SNS Topic for logging - optional/advanced.
    Type: String
    Default: none
  # network configuration
  VPC:
    Description: ID of an existing Virtual Private Cloud (VPC)
    Type: 'AWS::EC2::VPC::Id'
  PublicSubnet1:
    Description: The public subnet 1 in the VPC. This subnet must reside within the first selected Availability Zone (AZ). You must provide values for all three public subnets. If you only select one AZ, the second and third subnets will be ignored.
    Type: 'AWS::EC2::Subnet::Id'
  PublicSubnet2:
    Description: The public subnet 2 in the VPC. This subnet must reside within the second selected Availability Zone (AZ). You must provide values for all three public subnets. If you only select one AZ, the second and third subnets will be ignored.
    Type: 'AWS::EC2::Subnet::Id'
  PublicSubnet3:
    Description: The public subnet 3 in the VPC. This subnet must reside within the third selected Availability Zone (AZ). You must provide values for all three public subnets. If you only select one AZ, the second and third subnets will be ignored.
    Type: 'AWS::EC2::Subnet::Id'
  PrivateSubnet1:
    Description: The private subnet 1 in the VPC. This subnet must reside within the first selected Availability Zone (AZ). You must provide values for all three private subnets. If you only select one AZ, the second and third subnets will be ignored.
    Type: 'AWS::EC2::Subnet::Id'
  PrivateSubnet2:
    Description: The private subnet 2 in the VPC. This subnet must reside within the second selected Availability Zone (AZ). You must provide values for all three private subnets. If you only select one AZ, the second and third subnets will be ignored.
    Type: 'AWS::EC2::Subnet::Id'
  PrivateSubnet3:
    Description: The private subnet 3 in the VPC. This subnet must reside within the third selected Availability Zone (AZ). You must provide values for all three private subnets. If you only select one AZ, the second and third subnets will be ignored.
    Type: 'AWS::EC2::Subnet::Id'
  # marklogic configuration
  AdminUser:
    Description: The MarkLogic administrator username
    Type: String
  AdminPass:
    Description: The MarkLogic administrator password
    Type: String
    NoEcho: 'true'
  Licensee:
    Description: The MarkLogic Licensee or 'none'. Provide none/none to choose "Pay as you Go"/Enterprise version. Provide valid Licensee/Licensekey to choose BYOL/developer version.
    Type: String
    Default: none
  LicenseKey:
    Description: The MarkLogic License Key or 'none'. Provide none/none to choose "Pay as you Go"/Enterprise version. Provide valid Licensee/Licensekey to choose BYOL/developer version.
    Type: String
    Default: none
Conditions:
  UseLogSNS: !Not [!Equals [!Ref LogSNS, "none"]]
  UseSpot: !Not
    - !Equals
      - !Ref SpotPrice
      - 0
  #MultiZone (3 zones) and SingleZone conditions used for the conditional resource creation based on number of zones selected.
  MultiZone:
    !Not [!Equals [!Ref NumberOfZones, 1]]
  SingleZone: !Equals [!Ref NumberOfZones, 1]
  EssentialEnterprise:
    !Or [ !And [!Equals [!Ref LicenseKey, ''], !Equals [!Ref Licensee, '']], !And [!Equals [!Ref LicenseKey, 'none'], !Equals [!Ref Licensee, 'none']] ]
  UseVolumeEncryption: !Equals [!Ref VolumeEncryption, 'enable']
  HasCustomEBSKey: !Not [!Equals [!Ref VolumeEncryptionKey, '']]
Mappings:
  Variable:
    LambdaPackageBucket:
      base: 'ml-db-lambda-'
    TemplateUrl:
      base: 'https://s3.amazonaws.com/marklogic-db-template-releases'
    S3Directory:
      base: '10.0-9.2'
  LicenseRegion2AMI:
    us-east-1:
      Enterprise: ami-08b10a32d1221def3
      BYOL: ami-0eca24b53a4d5dc3a
    us-east-2:
      Enterprise: ami-0d2e398e8105cf1e3
      BYOL: ami-04db070506a1f22db
    us-west-1:
      Enterprise: ami-00e7b6915c31013ef
      BYOL: ami-084f3874fd2de12ee
    us-west-2:
      Enterprise: ami-0f81d85adc910a25f
      BYOL: ami-0aa5133a67b834646
    eu-central-1:
      Enterprise: ami-055cc5795296b8b85
      BYOL: ami-0ec19ba5f6b69c54a
    eu-west-1:
      Enterprise: ami-0b276b3bb2c006e52
      BYOL: ami-09a93a64cd7176e6e
    ap-south-1:
      Enterprise: ami-0164d2e0228ab575f
      BYOL: ami-0d3a93d00a648c329
    ap-southeast-1:
      Enterprise: ami-02310db866f17a69f
      BYOL: ami-02158425b13d36d9f
    ap-southeast-2:
      Enterprise: ami-07351a8464d4fa8d1
      BYOL: ami-0010a6bf6ade789f2
    ap-northeast-1:
      Enterprise: ami-05d40f36c7a1b4c8a
      BYOL: ami-05eefa37fb22f5c53
    ap-northeast-2:
      Enterprise: ami-0a41f478340b2931f
      BYOL: ami-03937c7cc81a80369
    sa-east-1:
      Enterprise: ami-02d664a013a49c9cb
      BYOL: ami-085296813223b1d0b
    eu-west-2:
      Enterprise: ami-0381ba0ad09712c77
      BYOL: ami-0425b52ac2cbbd2ca
    ca-central-1:
      Enterprise: ami-00646b7b719cb6dd7
      BYOL: ami-0891669fc4e3dad91
    eu-west-3:
      Enterprise: ami-0d6734e7d4405ec67
      BYOL: ami-058a47544eb859250
Resources:
  ManagedEniStack:
    Type: AWS::CloudFormation::Stack
    DependsOn:
      - InstanceSecurityGroup
    Properties:
      NotificationARNs:
        - !If
          - UseLogSNS
          - !Ref LogSNS
          - !Ref 'AWS::NoValue'
      Parameters:
        S3Bucket: !Join [ "", [!FindInMap [Variable,"LambdaPackageBucket","base"], !Ref 'AWS::Region']]
        S3Directory: !FindInMap [Variable,"S3Directory","base"]
        NodesPerZone: !Ref NodesPerZone
        NumberOfZones: !Ref NumberOfZones
        Subnets: !If [MultiZone, !Join [',', [!Ref PrivateSubnet1, !Ref PrivateSubnet2, !Ref PrivateSubnet3]], !Ref PrivateSubnet1]
        ParentStackName: !Ref 'AWS::StackName'
        ParentStackId: !Ref 'AWS::StackId'
        SecurityGroup: !Ref InstanceSecurityGroup
      TemplateURL: !Join ['/', [!FindInMap [Variable,"TemplateUrl","base"],!FindInMap [Variable,"S3Directory","base"],'ml-managedeni.template']]
      TimeoutInMinutes: 5
  NodeMgrLambdaStack:
    Type: AWS::CloudFormation::Stack
    DependsOn: ManagedEniStack
    Properties:
      NotificationARNs:
        - !If
          - UseLogSNS
          - !Ref LogSNS
          - !Ref 'AWS::NoValue'
      Parameters:
        S3Bucket: !Join [ "", [!FindInMap [Variable,"LambdaPackageBucket","base"], !Ref 'AWS::Region']]
        S3Directory: !FindInMap [Variable,"S3Directory","base"]
      TemplateURL: !Join ['/', [!FindInMap [Variable,"TemplateUrl","base"],!FindInMap [Variable,"S3Directory","base"],'ml-nodemanager.template']]
      TimeoutInMinutes: 5
  MarklogicVolume1:
    Type: 'AWS::EC2::Volume'
    Properties:
      AvailabilityZone: !Select [0, !Ref AZ]
      Size: !Ref VolumeSize
      Tags:
        - Key: Name
          Value: MarkLogic-GroupA-Host1-Volume0
      VolumeType: !Ref VolumeType
      Encrypted: !If [UseVolumeEncryption, 'true', 'false']
      KmsKeyId: !If [HasCustomEBSKey, !Ref VolumeEncryptionKey, !Ref 'AWS::NoValue']
    Metadata:
      'AWS::CloudFormation::Designer':
        id: c81032f7-b0ec-47ca-a236-e24d57b49ae3
  MarklogicVolume2:
    Condition: MultiZone
    Type: 'AWS::EC2::Volume'
    Properties:
      AvailabilityZone: !Select [1, !Ref AZ]
      Size: !Ref VolumeSize
      Tags:
        - Key: Name
          Value: MarkLogic-GroupB-Host1-Volume0
      VolumeType: !Ref VolumeType
      Encrypted: !If [UseVolumeEncryption, 'true', 'false']
      KmsKeyId: !If [HasCustomEBSKey, !Ref VolumeEncryptionKey, !Ref 'AWS::NoValue']
    Metadata:
      'AWS::CloudFormation::Designer':
        id: ddb55ae1-a00b-42ed-addd-5e03e4a2764b
  MarklogicVolume3:
    Condition: MultiZone
    Type: 'AWS::EC2::Volume'
    Properties:
      AvailabilityZone: !Select [2, !Ref AZ]
      Size: !Ref VolumeSize
      Tags:
        - Key: Name
          Value: MarkLogic-GroupC-Host1-Volume0
      VolumeType: !Ref VolumeType
      Encrypted: !If [UseVolumeEncryption, 'true', 'false']
      KmsKeyId: !If [HasCustomEBSKey, !Ref VolumeEncryptionKey, !Ref 'AWS::NoValue']
    Metadata:
      'AWS::CloudFormation::Designer':
        id: 9094a65e-9d01-4c4c-9586-c33720e2cc9c
  MarkLogicDDBTable:
    Type: 'AWS::DynamoDB::Table'
    Properties:
      AttributeDefinitions:
        - AttributeName: node
          AttributeType: S
      KeySchema:
        - KeyType: HASH
          AttributeName: node
      ProvisionedThroughput:
        WriteCapacityUnits: '10'
        ReadCapacityUnits: '10'
    Metadata:
      'AWS::CloudFormation::Designer':
        id: e7190602-c2de-47ab-81e7-1315f8c01e2d
  #AutoScalingGroup used for SingleZone deployments that is connected to Classic Load Balancer.
  MarkLogicServerGroup:
    Condition: SingleZone
    Type: 'AWS::AutoScaling::AutoScalingGroup'
    DependsOn:
      - ManagedEniStack
      - NodeMgrLambdaStack
    Properties:
      VPCZoneIdentifier:
        - !Ref PrivateSubnet1
      LaunchConfigurationName: !Ref LaunchConfig1
      MinSize: '0'
      MaxSize: !Ref NodesPerZone
      DesiredCapacity: !Ref NodesPerZone
      Cooldown: '300'
      HealthCheckType: EC2
      HealthCheckGracePeriod: '300'
      NotificationConfiguration: !If
        - UseLogSNS
        - TopicARN: !Ref LogSNS
          NotificationTypes:
            - 'autoscaling:EC2_INSTANCE_LAUNCH'
            - 'autoscaling:EC2_INSTANCE_LAUNCH_ERROR'
            - 'autoscaling:EC2_INSTANCE_TERMINATE'
            - 'autoscaling:EC2_INSTANCE_TERMINATE_ERROR'
        - !Ref 'AWS::NoValue'
      Tags:
        - Key: marklogic:stack:name
          Value: !Ref 'AWS::StackName'
          PropagateAtLaunch: 'true'
        - Key: marklogic:stack:id
          Value: !Ref 'AWS::StackId'
          PropagateAtLaunch: 'true'
      LifecycleHookSpecificationList:
        - LifecycleTransition: 'autoscaling:EC2_INSTANCE_LAUNCHING'
          LifecycleHookName: NodeManager
          HeartbeatTimeout: 4800
          NotificationTargetARN: !GetAtt [NodeMgrLambdaStack, Outputs.NodeMgrSnsArn]
          RoleARN: !GetAtt [NodeMgrLambdaStack, Outputs.NodeMgrIamArn]
    Metadata:
      'AWS::CloudFormation::Designer':
        id: 31621dd0-4b18-4dcd-b443-db9cef64ebb1
  #AutoScalingGroup used for MultiZone deployments (3 zones) that is connected to Application Load Balancer via 9 TargetGroups.
  #All of the instances in this AutoScalingGroup will be registered to all 9 TargetGroups.
  MarkLogicServerGroup1:
    Condition: MultiZone
    Type: 'AWS::AutoScaling::AutoScalingGroup'
    DependsOn:
      - ManagedEniStack
      - NodeMgrLambdaStack
      - AlbTargetGroup1
      - AlbTargetGroup2
      - AlbTargetGroup3
      - AlbTargetGroup4
      - AlbTargetGroup5
      - AlbTargetGroup6
      - AlbTargetGroup7      
      - AlbTargetGroup8
      - AlbTargetGroup9
    Properties:
      VPCZoneIdentifier:
        - !Ref PrivateSubnet1
      LaunchConfigurationName: !Ref LaunchConfig1
      MinSize: '0'
      MaxSize: !Ref NodesPerZone
      DesiredCapacity: !Ref NodesPerZone
      Cooldown: '300'
      HealthCheckType: EC2
      HealthCheckGracePeriod: '300'
      NotificationConfiguration: !If
        - UseLogSNS
        - TopicARN: !Ref LogSNS
          NotificationTypes:
            - 'autoscaling:EC2_INSTANCE_LAUNCH'
            - 'autoscaling:EC2_INSTANCE_LAUNCH_ERROR'
            - 'autoscaling:EC2_INSTANCE_TERMINATE'
            - 'autoscaling:EC2_INSTANCE_TERMINATE_ERROR'
        - !Ref 'AWS::NoValue'
      Tags:
        - Key: marklogic:stack:name
          Value: !Ref 'AWS::StackName'
          PropagateAtLaunch: 'true'
        - Key: marklogic:stack:id
          Value: !Ref 'AWS::StackId'
          PropagateAtLaunch: 'true'
      LifecycleHookSpecificationList:
        - LifecycleTransition: 'autoscaling:EC2_INSTANCE_LAUNCHING'
          LifecycleHookName: NodeManager
          HeartbeatTimeout: 4800
          NotificationTargetARN: !GetAtt [NodeMgrLambdaStack, Outputs.NodeMgrSnsArn]
          RoleARN: !GetAtt [NodeMgrLambdaStack, Outputs.NodeMgrIamArn]
      TargetGroupARNs:
        - !Ref AlbTargetGroup1
        - !Ref AlbTargetGroup2
        - !Ref AlbTargetGroup3
        - !Ref AlbTargetGroup4
        - !Ref AlbTargetGroup5
        - !Ref AlbTargetGroup6
        - !Ref AlbTargetGroup7
        - !Ref AlbTargetGroup8
        - !Ref AlbTargetGroup9
    Metadata:
      'AWS::CloudFormation::Designer':
        id: 31621dd0-4b18-4dcd-b443-db9cef64ebb1
  #AutoScalingGroup used for MultiZone deployments (3 zones) that is connected to Application Load Balancer via 9 TargetGroups.
  #All of the instances in this AutoScalingGroup will be registered to all 9 TargetGroups.
  MarkLogicServerGroup2:
    Condition: MultiZone
    Type: 'AWS::AutoScaling::AutoScalingGroup'
    DependsOn:
      - ManagedEniStack
      - NodeMgrLambdaStack
      - AlbTargetGroup1
      - AlbTargetGroup2
      - AlbTargetGroup3
      - AlbTargetGroup4
      - AlbTargetGroup5
      - AlbTargetGroup6
      - AlbTargetGroup7      
      - AlbTargetGroup8
      - AlbTargetGroup9
    Properties:
      VPCZoneIdentifier:
        - !Ref PrivateSubnet2
      LaunchConfigurationName: !Ref LaunchConfig2
      MinSize: '0'
      MaxSize: !Ref NodesPerZone
      DesiredCapacity: !Ref NodesPerZone
      Cooldown: '300'
      HealthCheckType: EC2
      HealthCheckGracePeriod: '300'
      NotificationConfiguration: !If
        - UseLogSNS
        - TopicARN: !Ref LogSNS
          NotificationTypes:
            - 'autoscaling:EC2_INSTANCE_LAUNCH'
            - 'autoscaling:EC2_INSTANCE_LAUNCH_ERROR'
            - 'autoscaling:EC2_INSTANCE_TERMINATE'
            - 'autoscaling:EC2_INSTANCE_TERMINATE_ERROR'
        - !Ref 'AWS::NoValue'
      Tags:
        - Key: marklogic:stack:name
          Value: !Ref 'AWS::StackName'
          PropagateAtLaunch: 'true'
        - Key: marklogic:stack:id
          Value: !Ref 'AWS::StackId'
          PropagateAtLaunch: 'true'
      LifecycleHookSpecificationList:
        - LifecycleTransition: 'autoscaling:EC2_INSTANCE_LAUNCHING'
          LifecycleHookName: NodeManager
          HeartbeatTimeout: 4800
          NotificationTargetARN: !GetAtt [NodeMgrLambdaStack, Outputs.NodeMgrSnsArn]
          RoleARN: !GetAtt [NodeMgrLambdaStack, Outputs.NodeMgrIamArn]
      TargetGroupARNs:
        - !Ref AlbTargetGroup1
        - !Ref AlbTargetGroup2
        - !Ref AlbTargetGroup3
        - !Ref AlbTargetGroup4
        - !Ref AlbTargetGroup5
        - !Ref AlbTargetGroup6
        - !Ref AlbTargetGroup7
        - !Ref AlbTargetGroup8
        - !Ref AlbTargetGroup9
    Metadata:
      'AWS::CloudFormation::Designer':
        id: 87d75478-787a-41d5-bb21-9de6fe4b662e
  #AutoScalingGroup used for MultiZone deployments (3 zones) that is connected to Application Load Balancer via 9 TargetGroups.
  #All of the instances in this AutoScalingGroup will be registered to all 9 TargetGroups.
  MarkLogicServerGroup3:
    Condition: MultiZone
    Type: 'AWS::AutoScaling::AutoScalingGroup'
    DependsOn:
      - ManagedEniStack
      - NodeMgrLambdaStack
      - AlbTargetGroup1
      - AlbTargetGroup2
      - AlbTargetGroup3
      - AlbTargetGroup4
      - AlbTargetGroup5
      - AlbTargetGroup6
      - AlbTargetGroup7      
      - AlbTargetGroup8
      - AlbTargetGroup9
    Properties:
      VPCZoneIdentifier:
        - !Ref PrivateSubnet3
      LaunchConfigurationName: !Ref LaunchConfig3
      MinSize: '0'
      MaxSize: !Ref NodesPerZone
      DesiredCapacity: !Ref NodesPerZone
      Cooldown: '300'
      HealthCheckType: EC2
      HealthCheckGracePeriod: '300'
      NotificationConfiguration: !If
        - UseLogSNS
        - TopicARN: !Ref LogSNS
          NotificationTypes:
            - 'autoscaling:EC2_INSTANCE_LAUNCH'
            - 'autoscaling:EC2_INSTANCE_LAUNCH_ERROR'
            - 'autoscaling:EC2_INSTANCE_TERMINATE'
            - 'autoscaling:EC2_INSTANCE_TERMINATE_ERROR'
        - !Ref 'AWS::NoValue'
      Tags:
        - Key: marklogic:stack:name
          Value: !Ref 'AWS::StackName'
          PropagateAtLaunch: 'true'
        - Key: marklogic:stack:id
          Value: !Ref 'AWS::StackId'
          PropagateAtLaunch: 'true'
      LifecycleHookSpecificationList:
        - LifecycleTransition: 'autoscaling:EC2_INSTANCE_LAUNCHING'
          LifecycleHookName: NodeManager
          HeartbeatTimeout: 4800
          NotificationTargetARN: !GetAtt [NodeMgrLambdaStack, Outputs.NodeMgrSnsArn]
          RoleARN: !GetAtt [NodeMgrLambdaStack, Outputs.NodeMgrIamArn]
      TargetGroupARNs:
        - !Ref AlbTargetGroup1
        - !Ref AlbTargetGroup2
        - !Ref AlbTargetGroup3
        - !Ref AlbTargetGroup4
        - !Ref AlbTargetGroup5
        - !Ref AlbTargetGroup6
        - !Ref AlbTargetGroup7
        - !Ref AlbTargetGroup8
        - !Ref AlbTargetGroup9
    Metadata:
      'AWS::CloudFormation::Designer':
        id: bbd8314a-6e59-4102-9ed5-232739dd0dfa
  InstanceSecurityGroup:
    Type: 'AWS::EC2::SecurityGroup'
    Properties:
      GroupDescription: Enable SSH access and HTTP access on the inbound port
      VpcId: !Ref VPC
      SecurityGroupIngress:
        - IpProtocol: tcp
          FromPort: '22'
          ToPort: '22'
          CidrIp: 0.0.0.0/0
        - IpProtocol: tcp
          FromPort: '7998'
          ToPort: '7998'
          CidrIp: 0.0.0.0/0
        - IpProtocol: tcp
          FromPort: '8000'
          ToPort: '8010'
          CidrIp: 0.0.0.0/0
        - IpProtocol: tcp
          FromPort: '7997'
          ToPort: '7997'
          CidrIp: 0.0.0.0/0
        - IpProtocol: tcp
          FromPort: '7999'
          ToPort: '7999'
          CidrIp: 0.0.0.0/0
  InstanceSecurityGroupIngress:
    Type: 'AWS::EC2::SecurityGroupIngress'
    DependsOn:
      - InstanceSecurityGroup
    Properties:
      IpProtocol: tcp
      FromPort: '0'
      ToPort: '65355'
      GroupId: !Ref InstanceSecurityGroup
      SourceSecurityGroupId: !Ref InstanceSecurityGroup
  ElbSecurityGroup:
    Type: 'AWS::EC2::SecurityGroup'
    Properties:
      GroupDescription: Enable SSH access and HTTP access on the inbound port
      VpcId: !Ref VPC
      SecurityGroupIngress:
        - IpProtocol: tcp
          FromPort: '22'
          ToPort: '22'
          CidrIp: 0.0.0.0/0
        - IpProtocol: tcp
          FromPort: '7998'
          ToPort: '7998'
          CidrIp: 0.0.0.0/0
        - IpProtocol: tcp
          FromPort: '8000'
          ToPort: '8010'
          CidrIp: 0.0.0.0/0
        - IpProtocol: tcp
          FromPort: '7997'
          ToPort: '7997'
          CidrIp: 0.0.0.0/0
  LaunchConfig1:
    Type: 'AWS::AutoScaling::LaunchConfiguration'
    DependsOn:
      - InstanceSecurityGroup
    Properties:
      BlockDeviceMappings:
        - DeviceName: /dev/xvda
          Ebs:
            VolumeSize: 40
        - DeviceName: /dev/sdf
          NoDevice: true
          Ebs: {}
      KeyName: !Ref KeyName
      ImageId: !If [EssentialEnterprise, !FindInMap [LicenseRegion2AMI,!Ref 'AWS::Region',"Enterprise"], !FindInMap [LicenseRegion2AMI, !Ref 'AWS::Region', "BYOL"]]
      UserData: !Base64
        'Fn::Join':
          - ''
          - - MARKLOGIC_CLUSTER_NAME=
            - !Ref MarkLogicDDBTable
            - |+

            - MARKLOGIC_EBS_VOLUME=
            - !Ref MarklogicVolume1
            - ',:'
            - !Ref VolumeSize
            - '::'
            - !Ref VolumeType
            - |
              ::,*
            - |
              MARKLOGIC_NODE_NAME=NodeA#
            - MARKLOGIC_ADMIN_USERNAME=
            - !Ref AdminUser
            - |+

            - MARKLOGIC_ADMIN_PASSWORD=
            - !Ref AdminPass
            - |+

            - |
              MARKLOGIC_CLUSTER_MASTER=1
            - MARKLOGIC_LICENSEE=
            - !Ref Licensee
            - |+

            - MARKLOGIC_LICENSE_KEY=
            - !Ref LicenseKey
            - |+

            - MARKLOGIC_LOG_SNS=
            - !Ref LogSNS
            - |+

            - MARKLOGIC_AWS_SWAP_SIZE=
            - 32
            - |+

            - !If
              - UseVolumeEncryption
              - !Join
                - ''
                - - 'MARKLOGIC_EBS_KEY='
                  - !If
                    - HasCustomEBSKey
                    - !Ref VolumeEncryptionKey
                    - 'default'
              - ''

      SecurityGroups:
        - !Ref InstanceSecurityGroup
      InstanceType: !Ref InstanceType
      IamInstanceProfile: !Ref IAMRole
      SpotPrice: !If
        - UseSpot
        - !Ref SpotPrice
        - !Ref 'AWS::NoValue'
    Metadata:
      'AWS::CloudFormation::Designer':
        id: 2efb8cfb-df53-401d-8ff2-34af0dd25993
  LaunchConfig2:
    Condition: MultiZone
    Type: 'AWS::AutoScaling::LaunchConfiguration'
    DependsOn:
      - InstanceSecurityGroup
    Properties:
      BlockDeviceMappings:
        - DeviceName: /dev/xvda
          Ebs:
            VolumeSize: 40
        - DeviceName: /dev/sdf
          NoDevice: true
          Ebs: {}
      KeyName: !Ref KeyName
      ImageId: !If [EssentialEnterprise, !FindInMap [LicenseRegion2AMI,!Ref 'AWS::Region',"Enterprise"], !FindInMap [LicenseRegion2AMI, !Ref 'AWS::Region', "BYOL"]]
      UserData: !Base64
        'Fn::Join':
          - ''
          - - MARKLOGIC_CLUSTER_NAME=
            - !Ref MarkLogicDDBTable
            - |+

            - MARKLOGIC_EBS_VOLUME=
            - !Ref MarklogicVolume2
            - ',:'
            - !Ref VolumeSize
            - '::'
            - !Ref VolumeType
            - |
              ::,*
            - |
              MARKLOGIC_NODE_NAME=NodeB#
            - MARKLOGIC_ADMIN_USERNAME=
            - !Ref AdminUser
            - |+

            - MARKLOGIC_ADMIN_PASSWORD=
            - !Ref AdminPass
            - |+

            - |
              MARKLOGIC_CLUSTER_MASTER=0
            - MARKLOGIC_LICENSEE=
            - !Ref Licensee
            - |+

            - MARKLOGIC_LICENSE_KEY=
            - !Ref LicenseKey
            - |+

            - MARKLOGIC_LOG_SNS=
            - !Ref LogSNS
            - |+

            - MARKLOGIC_AWS_SWAP_SIZE=
            - 32
            - |+

            - !If
              - UseVolumeEncryption
              - !Join
                - ''
                - - 'MARKLOGIC_EBS_KEY='
                  - !If
                    - HasCustomEBSKey
                    - !Ref VolumeEncryptionKey
                    - 'default'
              - ''

      SecurityGroups:
        - !Ref InstanceSecurityGroup
      InstanceType: !Ref InstanceType
      IamInstanceProfile: !Ref IAMRole
      SpotPrice: !If
        - UseSpot
        - !Ref SpotPrice
        - !Ref 'AWS::NoValue'
    Metadata:
      'AWS::CloudFormation::Designer':
        id: c8296a50-a29e-4646-aa74-8f1b735a9a3f
  LaunchConfig3:
    Condition: MultiZone
    Type: 'AWS::AutoScaling::LaunchConfiguration'
    DependsOn:
      - InstanceSecurityGroup
    Properties:
      BlockDeviceMappings:
        - DeviceName: /dev/xvda
          Ebs:
            VolumeSize: 40
        - DeviceName: /dev/sdf
          NoDevice: true
          Ebs: {}
      KeyName: !Ref KeyName
      ImageId: !If [EssentialEnterprise, !FindInMap [LicenseRegion2AMI,!Ref 'AWS::Region',"Enterprise"], !FindInMap [LicenseRegion2AMI, !Ref 'AWS::Region', "BYOL"]]
      UserData: !Base64
        'Fn::Join':
          - ''
          - - MARKLOGIC_CLUSTER_NAME=
            - !Ref MarkLogicDDBTable
            - |+

            - MARKLOGIC_EBS_VOLUME=
            - !Ref MarklogicVolume3
            - ',:'
            - !Ref VolumeSize
            - '::'
            - !Ref VolumeType
            - |
              ::,*
            - |
              MARKLOGIC_NODE_NAME=NodeC#
            - MARKLOGIC_ADMIN_USERNAME=
            - !Ref AdminUser
            - |+

            - MARKLOGIC_ADMIN_PASSWORD=
            - !Ref AdminPass
            - |+

            - |
              MARKLOGIC_CLUSTER_MASTER=0
            - MARKLOGIC_LICENSEE=
            - !Ref Licensee
            - |+

            - MARKLOGIC_LICENSE_KEY=
            - !Ref LicenseKey
            - |+

            - MARKLOGIC_LOG_SNS=
            - !Ref LogSNS
            - |+

            - MARKLOGIC_AWS_SWAP_SIZE=
            - 32
            - |+

            - !If
              - UseVolumeEncryption
              - !Join
                - ''
                - - 'MARKLOGIC_EBS_KEY='
                  - !If
                    - HasCustomEBSKey
                    - !Ref VolumeEncryptionKey
                    - 'default'
              - ''

      SecurityGroups:
        - !Ref InstanceSecurityGroup
      InstanceType: !Ref InstanceType
      IamInstanceProfile: !Ref IAMRole
      SpotPrice: !If
        - UseSpot
        - !Ref SpotPrice
        - !Ref 'AWS::NoValue'
    Metadata:
      'AWS::CloudFormation::Designer':
        id: 7fa68c90-39bc-4874-ad20-8cd8c974ed52
  #Application Load Balancer description for MultiZone deployments (3 zones).
  Alb:
    Condition: MultiZone
    Type: AWS::ElasticLoadBalancingV2::LoadBalancer
    DependsOn:
      - ElbSecurityGroup
    Properties: 
      SecurityGroups: 
        - !Ref ElbSecurityGroup
      Subnets:
        - !Ref PublicSubnet1
        - !If [MultiZone, !Ref PublicSubnet2, !Ref 'AWS::NoValue']
        - !If [MultiZone, !Ref PublicSubnet3, !Ref 'AWS::NoValue']
    Metadata:
      'AWS::CloudFormation::Designer':
        id: e188e71e-5f01-4816-896e-9bd30b9a96c1
  #Descriptions of the 9 TargetGroups for MultiZone deployments (3 zones). TargetGroups route requests to registered targets.
  #Health checks are performed on each TargetGroup.
  AlbTargetGroup1:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::TargetGroup"
    Properties:
      HealthCheckIntervalSeconds: 10
      HealthCheckTimeoutSeconds: 5
      HealthyThresholdCount: 3
      HealthCheckPort: 7997
      UnhealthyThresholdCount: 5
      Port: 8000
      Protocol: HTTP
      TargetGroupAttributes:
        - Key: stickiness.enabled
          Value: true
        - Key: stickiness.type
          Value: lb_cookie
        - Key: stickiness.lb_cookie.duration_seconds
          Value: 3600
        - Key: deregistration_delay.timeout_seconds
          Value: 60
      VpcId: !Ref VPC
  AlbTargetGroup2:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::TargetGroup"
    Properties:
      HealthCheckIntervalSeconds: 10
      HealthCheckTimeoutSeconds: 5
      HealthyThresholdCount: 3
      HealthCheckPort: 7997
      UnhealthyThresholdCount: 5
      Port: 8001
      Protocol: HTTP
      TargetGroupAttributes:
        - Key: stickiness.enabled
          Value: true
        - Key: stickiness.type
          Value: lb_cookie
        - Key: stickiness.lb_cookie.duration_seconds
          Value: 3600
        - Key: deregistration_delay.timeout_seconds
          Value: 60
      VpcId: !Ref VPC
  AlbTargetGroup3:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::TargetGroup"
    Properties:
      HealthCheckIntervalSeconds: 10
      HealthCheckTimeoutSeconds: 5
      HealthyThresholdCount: 3
      HealthCheckPort: 7997
      UnhealthyThresholdCount: 5
      Port: 8002
      Protocol: HTTP
      TargetGroupAttributes:
        - Key: stickiness.enabled
          Value: true
        - Key: stickiness.type
          Value: lb_cookie
        - Key: stickiness.lb_cookie.duration_seconds
          Value: 3600
        - Key: deregistration_delay.timeout_seconds
          Value: 60
      VpcId: !Ref VPC
  AlbTargetGroup4:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::TargetGroup"
    Properties:
      HealthCheckIntervalSeconds: 10
      HealthCheckTimeoutSeconds: 5
      HealthyThresholdCount: 3
      HealthCheckPort: 7997
      UnhealthyThresholdCount: 5
      Port: 8003
      Protocol: HTTP
      TargetGroupAttributes:
        - Key: stickiness.enabled
          Value: true
        - Key: stickiness.type
          Value: lb_cookie
        - Key: stickiness.lb_cookie.duration_seconds
          Value: 3600
        - Key: deregistration_delay.timeout_seconds
          Value: 60
      VpcId: !Ref VPC
  AlbTargetGroup5:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::TargetGroup"
    Properties:
      HealthCheckIntervalSeconds: 10
      HealthCheckTimeoutSeconds: 5
      HealthyThresholdCount: 3
      HealthCheckPort: 7997
      UnhealthyThresholdCount: 5
      Port: 8004
      Protocol: HTTP
      TargetGroupAttributes:
        - Key: stickiness.enabled
          Value: true
        - Key: stickiness.type
          Value: lb_cookie
        - Key: stickiness.lb_cookie.duration_seconds
          Value: 3600
        - Key: deregistration_delay.timeout_seconds
          Value: 60
      VpcId: !Ref VPC
  AlbTargetGroup6:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::TargetGroup"
    Properties:
      HealthCheckIntervalSeconds: 10
      HealthCheckTimeoutSeconds: 5
      HealthyThresholdCount: 3
      HealthCheckPort: 7997
      UnhealthyThresholdCount: 5
      Port: 8005
      Protocol: HTTP
      TargetGroupAttributes:
        - Key: stickiness.enabled
          Value: true
        - Key: stickiness.type
          Value: lb_cookie
        - Key: stickiness.lb_cookie.duration_seconds
          Value: 3600
        - Key: deregistration_delay.timeout_seconds
          Value: 60
      VpcId: !Ref VPC
  AlbTargetGroup7:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::TargetGroup"
    Properties:
      HealthCheckIntervalSeconds: 10
      HealthCheckTimeoutSeconds: 5
      HealthyThresholdCount: 3
      HealthCheckPort: 7997
      UnhealthyThresholdCount: 5
      Port: 8006
      Protocol: HTTP
      TargetGroupAttributes:
        - Key: stickiness.enabled
          Value: true
        - Key: stickiness.type
          Value: lb_cookie
        - Key: stickiness.lb_cookie.duration_seconds
          Value: 3600
        - Key: deregistration_delay.timeout_seconds
          Value: 60
      VpcId: !Ref VPC
  AlbTargetGroup8:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::TargetGroup"
    Properties:
      HealthCheckIntervalSeconds: 10
      HealthCheckTimeoutSeconds: 5
      HealthyThresholdCount: 3
      HealthCheckPort: 7997
      UnhealthyThresholdCount: 5
      Port: 8007
      Protocol: HTTP
      TargetGroupAttributes:
        - Key: stickiness.enabled
          Value: true
        - Key: stickiness.type
          Value: lb_cookie
        - Key: stickiness.lb_cookie.duration_seconds
          Value: 3600
        - Key: deregistration_delay.timeout_seconds
          Value: 60
      VpcId: !Ref VPC
  AlbTargetGroup9:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::TargetGroup"
    Properties:
      HealthCheckIntervalSeconds: 10
      HealthCheckTimeoutSeconds: 5
      HealthyThresholdCount: 3
      HealthCheckPort: 7997
      UnhealthyThresholdCount: 5
      Port: 8008
      Protocol: HTTP
      TargetGroupAttributes:
        - Key: stickiness.enabled
          Value: true
        - Key: stickiness.type
          Value: lb_cookie
        - Key: stickiness.lb_cookie.duration_seconds
          Value: 3600
        - Key: deregistration_delay.timeout_seconds
          Value: 60
      VpcId: !Ref VPC
  #Descriptions of the 9 Listeners for MultiZone deployments (3 zones). Each Listener connects Application Load Balancer to a TargetGroup with a particular port.
  AlbListener1:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::Listener"
    DependsOn:
      - Alb
      - AlbTargetGroup1
    Properties:
      DefaultActions:
        - TargetGroupArn: !Ref AlbTargetGroup1
          Type: forward
      LoadBalancerArn: !Ref Alb
      Port: 8000
      Protocol: HTTP
  AlbListener2:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::Listener"
    DependsOn:
      - Alb
      - AlbTargetGroup2
    Properties:
      DefaultActions:
        - TargetGroupArn: !Ref AlbTargetGroup2
          Type: forward
      LoadBalancerArn: !Ref Alb
      Port: 8001
      Protocol: HTTP
  AlbListener3:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::Listener"
    DependsOn:
      - Alb
      - AlbTargetGroup3
    Properties:
      DefaultActions:
        - TargetGroupArn: !Ref AlbTargetGroup3
          Type: forward
      LoadBalancerArn: !Ref Alb
      Port: 8002
      Protocol: HTTP
  AlbListener4:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::Listener"
    DependsOn:
      - Alb
      - AlbTargetGroup4
    Properties:
      DefaultActions:
        - TargetGroupArn: !Ref AlbTargetGroup4
          Type: forward
      LoadBalancerArn: !Ref Alb
      Port: 8003
      Protocol: HTTP
  AlbListener5:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::Listener"
    DependsOn:
      - Alb
      - AlbTargetGroup5
    Properties:
      DefaultActions:
        - TargetGroupArn: !Ref AlbTargetGroup5
          Type: forward
      LoadBalancerArn: !Ref Alb
      Port: 8004
      Protocol: HTTP
  AlbListener6:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::Listener"
    DependsOn:
      - Alb
      - AlbTargetGroup6
    Properties:
      DefaultActions:
        - TargetGroupArn: !Ref AlbTargetGroup6
          Type: forward
      LoadBalancerArn: !Ref Alb
      Port: 8005
      Protocol: HTTP
  AlbListener7:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::Listener"
    DependsOn:
      - Alb
      - AlbTargetGroup7
    Properties:
      DefaultActions:
        - TargetGroupArn: !Ref AlbTargetGroup7
          Type: forward
      LoadBalancerArn: !Ref Alb
      Port: 8006
      Protocol: HTTP
  AlbListener8:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::Listener"
    DependsOn:
      - Alb
      - AlbTargetGroup8
    Properties:
      DefaultActions:
        - TargetGroupArn: !Ref AlbTargetGroup8
          Type: forward
      LoadBalancerArn: !Ref Alb
      Port: 8007
      Protocol: HTTP
  AlbListener9:
    Condition: MultiZone
    Type: "AWS::ElasticLoadBalancingV2::Listener"
    DependsOn:
      - Alb
      - AlbTargetGroup9
    Properties:
      DefaultActions:
        - TargetGroupArn: !Ref AlbTargetGroup9
          Type: forward
      LoadBalancerArn: !Ref Alb
      Port: 8008
      Protocol: HTTP
Outputs:
  URL:
    Description: The URL of the MarkLogic Cluster
    Value: !Join
      - ''
      - - 'http://'
        - !If [MultiZone, !GetAtt [Alb, DNSName], !GetAtt [ManagedEniStack, Outputs.ENI]]
        - ':8001'

STACK
}