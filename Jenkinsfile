pipeline {
  environment {
    registry = "sububiker/django"
    registryCredential = 'sububikerdocker'
    dockerImage = ''
 }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        git url:'https://github.com/sububiker/notejamdjango.git', branch:'master'
      }
    }
    
      stage("Build image") {
            steps {
                script {
                    myapp = docker.build("sububiker/django:${env.BUILD_ID}")
                }
            }
        }
    
      stage("Push image") {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'sububikerdocker') {
                           myapp.push("${env.BUILD_ID}")
                           myapp.push("latest")
                    }
                }
            }
        }

    


    stage('Deploy on k8s') {

         steps {

            script {

               //env.PIPELINE_NAMESPACE = "apps"

               //kubernetesDeploy(kubeconfigId: 'mykubeconfig', configs: 'k8s-specifications/')

                withKubeConfig([credentialsId: 'kubeconfigfile', serverUrl: 'https://10.0.10.164:6443']) {

                sh 'kubectl apply -f k8s/deployment.yaml'
                sh 'kubectl get all -n apps'

            }

         }

      }

    }
}
}
