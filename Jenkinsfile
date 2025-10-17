pipeline {
    agent any

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
                sh 'docker build -t jenkins-demo:latest .'
            }
        }

        stage('Run Container') {
            steps {
                echo "🚀 컨테이너 실행 중..."
                sh 'docker run -d -p 8088:80 --name demo-web jenkins-demo:latest || true'
            }
        }

        stage('Check Page') {
            steps {
                echo "🌐 페이지 응답 테스트 중..."
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
            echo "✅ Jenkins Pipeline 성공적으로 완료!"
        }
        failure {
            echo "❌ Pipeline 실패 — 로그를 확인하세요."
        }
    }
}
