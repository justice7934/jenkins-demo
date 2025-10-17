pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = 'dockerhub-cred'
        DOCKERHUB_REPO = 'justice797934/jenkins-demo'  // Docker Hub 리포 이름
    }

    stages {
        stage('Checkout') {
            steps {
                echo "📦 GitHub에서 코드 가져오는 중..."
                git branch: 'main', url: 'https://github.com/justice7934/jenkins-demo.git', credentialsId: 'github-cred'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "🐳 Docker 이미지 빌드 중..."
                sh 'docker build -t ${DOCKERHUB_REPO}:latest .'
            }
        }

        stage('Login & Push to DockerHub') {
            steps {
                echo "🚀 DockerHub 로그인 및 푸시 중..."
                withCredentials([usernamePassword(credentialsId: "${DOCKERHUB_CREDENTIALS}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${DOCKERHUB_REPO}:latest
                        docker logout
                    '''
                }
            }
        }

        stage('Test Run') {
            steps {
                echo "🧪 이미지 실행 테스트..."
                sh 'docker run -d -p 8088:80 --name demo-web ${DOCKERHUB_REPO}:latest || true'
                sh 'sleep 3 && curl -s http://localhost:8088 || echo "curl failed"'
            }
        }

        stage('Cleanup') {
            steps {
                echo "🧹 컨테이너 정리 중..."
                sh 'docker stop demo-web || true'
                sh 'docker rm demo-web || true'
            }
        }
    }

    post {
        success {
            echo "✅ Jenkins Pipeline 성공적으로 완료 (DockerHub 업로드 포함)!"
        }
        failure {
            echo "❌ Pipeline 실패 — 로그를 확인하세요."
        }
    }
}
