properties([
    parameters([
        [$class: 'ChoiceParameter',
            choiceType: 'PT_SINGLE_SELECT',
            description: 'Select the Env Name from the Dropdown List',
            filterLength: 1,
            filterable: true,
            name: 'Env',
            randomName: 'choice-parameter-5631314439613978',
            script: [
                $class: 'GroovyScript',
                fallbackScript: [
                    classpath: [],
                    sandbox: false,
                    script:
                        'return[\'Could not get Env\']'
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
            description: 'Select the Server from the Dropdown List',
            filterLength: 1,
            filterable: true,
            name: 'Server',
            randomName: 'choice-parameter-5631314456178619',
            referencedParameters: 'Env',
            script: [
                $class: 'GroovyScript',
                fallbackScript: [
                    classpath: [],
                    sandbox: false,
                    script:
                        'return[\'Could not get Environment from Env Param\']'
                ],
                script: [
                    classpath: [],
                    sandbox: false,
                    script:
                        ''' if (Env.equals("us-west-1")){
                                return["subnet-69612131"]
                            }
                            else if(Env.equals("eu-central-1")){
                                return["subnet-27477a4f"]
                            }
                            else if(Env.equals("ap-northeast-2")){
                                return["subnet-55d00d3d"]
                            }
                            else if(Env.equals("us-east-2")){
                                return["subnet-094fe18d7cf9f0815","subnet-01eb9f979f9c56b1d","subnet-008b4ae662f3d58f9"]
                            }
                            else if(Env.equals("ap-southeast-1")){
                                return["subnet-0eddc2ed7cbeb2f94","subnet-0faa9192fe172f47f","subnet-05470ef48abbad44f"]
                            }
                            else if(Env.equals("eu-west-2")){
                                return["subnet-0bd4f720fc33e5c91","subnet-0f426bf7ba831f215","subnet-0210abcf68ebb0c99"]
                            }
                            else if(Env.equals("sa-east-1")){
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
      string(defaultValue: "brazil", description: 'What environment?', name: 'Name')
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
          echo "${params.Env}"
          echo "${params.Server}"
          if (params.Server.equals("Could not get Environment from Env Param")) {
              echo "Must be the first build after Pipeline deployment.  Aborting the build"
              currentBuild.result = 'ABORTED'
              return
          }
          echo "Crossed param validation"
        } }
      }
  }
}
