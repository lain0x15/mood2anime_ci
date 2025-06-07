pipeline {
    agent any
    parameters {
      string(name: 'Dockerhub_secret', defaultValue: 'dockerhub', description: 'Jenkins secret name for auth into dockerhub')
      string(name: 'Tag_docker_image', defaultValue: 'max0x15/mood2anime', description: 'Tag for pushing image')
      string(name: 'git_branch', defaultValue: 'main', description: 'branch for git clone')
    }
    options {
        disableConcurrentBuilds()
    }
	stages {
		stage('Build') {
			steps {
				sh "git clone --depth 1 -b ${params.git_branch}  https://github.com/lain0x15/mood2anime.git"
                withCredentials([usernamePassword(credentialsId: "${params.Dockerhub_secret}", usernameVariable : 'username_dockerhub', passwordVariable: 'password_dockerhub' )]) {
                      sh 'docker login -u $username_dockerhub --password $password_dockerhub'
                }
                sh "docker buildx build -t ${params.Tag_docker_image} . --push"
			}
		}
	}
    post {
        always {
            cleanWs()
        }
    }
}