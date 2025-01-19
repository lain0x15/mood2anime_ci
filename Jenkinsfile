pipeline {
    agent any
	stages {
		stage('Build') {
			steps {
				sh "git clone https://github.com/lain0x15/mood2anime.git"
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable : 'username_dockerhub', passwordVariable: 'password_dockerhub' )]) {
                      sh 'docker login -u $username_dockerhub --password $password_dockerhub'
                }
                sh "docker buildx build -t max0x15/mood2anime . --push"
			}
		}
	}
    post {
        always {
            cleanWs()
        }
    }
}