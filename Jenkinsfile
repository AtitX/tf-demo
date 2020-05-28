properties([
    parameters([
        [$class: 'ChoiceParameter',
            choiceType: 'PT_SINGLE_SELECT',
            description: 'Select the Region from the Dropdown List',
            filterLength: 1,
            filterable: true,
            name: 'Region',
            randomName: 'choice-parameter-5631314439613978',
            script: [
                $class: 'GroovyScript',
                fallbackScript: [
                    classpath: [],
                    sandbox: false,
                    script:
                        'return[\'Could not get Region\']'
                ],
                script: [
                    classpath: [],
                    sandbox: false,
                    script:
                        'return["us-west-1","eu-central-1","us-east-2","ap-northeast-2","ap-southeast-1","eu-west-2","sa-east-1"]'
                ]
            ]
        ],
        [$class: 'CascadeChoiceParameter',
            choiceType: 'PT_SINGLE_SELECT',
            description: 'Select the Subnet from the Dropdown List',
            filterLength: 1,
            filterable: true,
            name: 'Subnet',
            randomName: 'choice-parameter-5631314456178619',
            referencedParameters: 'Region',
            script: [
                $class: 'GroovyScript',
                fallbackScript: [
                    classpath: [],
                    sandbox: false,
                    script:
                        'return[\'Could not get Region from Region Param\']'
                ],
                script: [
                    classpath: [],
                    sandbox: false,
                    script:
                        ''' if (Region.equals("us-west-1")){
                                return["subnet-69612131"]
                            }
                            else if(Region.equals("eu-central-1")){
                                return["subnet-27477a4f"]
                            }
                            else if(Region.equals("ap-northeast-2")){
                                return["subnet-55d00d3d"]
                            }
                            else if(Region.equals("us-east-2")){
                                return["subnet-094fe18d7cf9f0815","subnet-01eb9f979f9c56b1d","subnet-008b4ae662f3d58f9"]
                            }
                            else if(Region.equals("ap-southeast-1")){
                                return["subnet-0eddc2ed7cbeb2f94","subnet-0faa9192fe172f47f","subnet-05470ef48abbad44f"]
                            }
                            else if(Region.equals("eu-west-2")){
                                return["subnet-0bd4f720fc33e5c91","subnet-0f426bf7ba831f215","subnet-0210abcf68ebb0c99"]
                            }
                            else if(Region.equals("sa-east-1")){
                                return["subnet-03c18dcc3a5c36bc8","subnet-0d0e5beedd0350a5f","subnet-09b4ac70dea61c2bc"]
                            }
                        '''
                ]
            ]
        ]
    ])
])

pipeline {
  parameters {
      string(defaultValue: "brazil", description: 'What is the client name?', name: 'Name')
      choice(choices: ['t2.micro', 't2.small'], description: 'Instance Type?', name: 'Instance')
  }
  environment {
         vari = ""
  }
  agent any
  stages {
      stage ("Example") {
        steps {
         script{
          echo 'Hello'
          echo "${params.Region}"
          echo "${params.Subnet}"
          if (params.Subnet.equals("Could not get Region from Region Param")) {
              echo "Must be the first build after Pipeline deployment.  Aborting the build"
              currentBuild.result = 'ABORTED'
              return
          }
          echo "Crossed param validation"
        } }
      }

    stages {
      stage('fetch_latest_code') {
        steps {
          git url: 'https://github.com/PrashantBhatasana/terraform-jenkins-ec2'
        }
      }

    stage('Set Terraform path') {
      steps {
        script {
          def tfHome = tool name: 'Terraform'
          env.PATH = "${tfHome}:${env.PATH}"
        }
        sh 'terraform version'


      }
    }





      stage('TF Init&Plan') {
        steps {
          sh 'terraform init'
          sh 'terraform plan'
        }
      }

    stage('Approval') {
      steps {
        script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        }
      }
    }

    stage('TF Apply') {
      steps {
        sh 'terraform apply -input=false'
      }
    }


  }
}
