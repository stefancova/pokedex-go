pipeline{
    agent any
    stages{
        stage("A : Checkout branch master"){
            steps{
                echo 'Pulling...' + env.BRANCH_NAME
                checkout scm
            }
        }
        stage ("Environnment variables"){
            // PULL IN ENVIRONMENT VARIABLES
            // Jenkins makes these variables available for each job it runs
            def buildNumber = env.BUILD_NUMBER
            def workspace = env.WORKSPACE
            def buildUrl = env.BUILD_URL

            // PRINT ENVIRONMENT TO JOB
            echo "workspace directory is ${workspace}"
            echo "build URL is ${env.BUILD_URL}"
        }
        stage("B : Build a docker image using the Dockerfile you created in step 2"){
            steps{
                echo "Build docker image"
                sh 'docker build -t pokedex-go .'
                echo "Install packages"
                sh 'cd app'
                sh 'npm install'
            }
        }
        stage("C : Run the unit tests within the image using npm test"){
            steps{
                echo "Run unit tests"
                sh 'npm test'
            }
        }
        stage("D : Run a container from your image, publishing port 5555, run npm start"){
            steps{
                echo "Run mypokex image"
                sh 'docker rm -f mypokedex || true'
                echo "Publish mypokedex on port 5555"
                sh 'docker run -d -p 5555:5555 --name mypokedex pokedex-go:latest'
                echo "Start app"
                sh 'npm start'
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
