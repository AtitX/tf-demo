// pipeline {
//   agent any
//   stages {
//     stage('checkout') {
//       steps {
//         git url: 'https://github.com/bigandbuy/tf-jenkins-demo.git'
//       }
//     }
//   }
// }

pipeline {
  agent any


  parameters {
      string(defaultValue: "TEST", description: 'What environment?', name: 'userFlag')
      choice(choices: ['US-EAST-1', 'US-WEST-2'], description: 'What AWS region?', name: 'region')
  }

  stages {


    stage("foo") {
        steps {
            echo "flag: ${params.userFlag}"
        }
    }


    // stage('User Input') {


    //     steps {

    //         script {
    //                 CHOICES = ["tag1", "tag2", "tag3"];
    //                 env.YourTag = input  message: 'What are we deploying today?',ok : 'Deploy',id :'tag_id',
    //                                 parameters:[choice(choices: CHOICES, description: 'Select a tag for this build', name: 'TAG')]
    //         }
    //         echo "Deploying ${env.YourTag}. Have a nice day."
    //     }
    // }

    stage('checkout') {
      steps {
        git branch: 'master', url: 'https://github.com/bigandbuy/tf-demo.git'

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

    stage('Provision infrastructure') {

      steps {
        // dir('dev') {
          sh 'terraform init'
          sh 'terraform plan -out=plan'
          // sh ‘terraform destroy -auto-approve’
          //sh 'terraform apply plan'
          // sh 'terraform apply -var="region=sa-east-1" -var="instance_type=t2.micro" -var="name=brazil" -var="security_group_id=sg-0491a2ca90237338c" -var='private_subnet_ids=["subnet-06548f558415372f4","subnet-0c47cf28de8f6a039","subnet-0ff3bffb0e9aa2fcb"]' -var='public_subnet_ids=["subnet-03c18dcc3a5c36bc8","subnet-0d0e5beedd0350a5f","subnet-09b4ac70dea61c2bc"]''
        // }


      }
    }



  }
}
