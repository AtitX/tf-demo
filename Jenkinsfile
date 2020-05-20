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
      string(defaultValue: "TEST", description: 'What environment?', name: 'name')
      choice(choices: ['us-west-1', 'ap-southeast-1'], description: 'What AWS region?', name: 'region')
      choice(choices: ['t2.micro', 't2.small'], description: 'Instance Type?', name: 'instancetype')
      string(defaultValue: "TEST", description: 'Security Group?', name: 'secgroup')
      string(defaultValue: "TEST", description: 'Subnet?', name: 'public')
  }

  stages {


    stage("foo") {
        steps {
            echo "flag: ${params.name}"
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
          // sh 'terraform apply plan -var="region=${params.region}" -var="instance_type=${params.instancetype}" -var="name=${params.name}" -var="security_group_id=${params.secgroup}"'
          // sh 'terraform apply plan -var="region=${params.region}"'
          sh "terraform apply -var=region=${params.region}
        // }


      }
    }



  }
}
