node {
    
    def cluster = "accountant-cluster"
    def service = "accountant-service"
    def gitUrl = 'https://github.com/cjc2785/accountant-backend.git'
    
	def app

	stage('clone') {
         git gitUrl
    }

    stage('build') {
         withCredentials([string(credentialsId: 'ecr-account', variable: 'ECR_ACCOUNT')]) {
            def repo = "${ECR_ACCOUNT}.dkr.ecr.us-east-1.amazonaws.com/accountant"
            app = docker.build("${repo}")
        }
    }
 
	stage('push') {
        sh "eval \$(aws ecr get-login --region us-east-1 --no-include-email)"
        app.push("latest")
    }
	

    stage('deploy') {
        sh "aws ecs update-service --region us-east-1 --cluster ${cluster} --service ${service} --force-new-deployment"
    }
}