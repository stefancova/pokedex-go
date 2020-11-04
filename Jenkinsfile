pipeline{
    agent any
    stages{
        stage("A : Checkout branch master"){
            steps{
                echo 'Pulling...' + env.BRANCH_NAME
                checkout scm
            }
        }
        stage("B : build a docker image using the Dockerfile you created in step 2"){
            steps{
                echo "Build docker image"
                sh 'docker build -t pokedex-go .'
                sh 'cd pokedex-go && npm install'
            }
        }
        stage("C : run the unit tests within the image using npm test"){
            steps{
                echo "Run unit tests"
                sh 'npm test'
            }
        }
        stage("D : run a container from your image, publishing port 5555, run npm start"){
            steps{
                echo "Run image and publish on port 5555"
                sh 'docker rm -f mypokedex || true'
                sh 'docker run -d -p 5555:5555 --name mypokedex pokedex-go:latest'
            }
        }
    }
    post{
        always{
            echo "========always========"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}
