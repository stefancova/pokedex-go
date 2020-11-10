pipeline{
    agent any
    stages{
        stage("Checkout branch master"){
            steps{
                echo "Pulling..." + env.BRANCH_NAME
                checkout scm
            }
        }
        stage ("Environment variables"){
            steps{
            echo "Workspace directory is ${env.WORKSPACE}"
            }
        }
        stage("Build a docker image using the Dockerfile you created in step 2"){
            steps{
                echo "Build docker image"
                sh "docker build -t pokedex-go ."
            }
        }
       stage("Run the unit tests within the image using npm test"){
            steps{
                echo "Run unit tests"
                sh "docker run --rm pokedex-go:latest npm test"
            }
        }
        stage("Run a container from your image, publishing port 5555, run npm start"){
            steps{
                echo "Delete existing mypokedex image"
                sh "docker rm -f mypokedex || true"
                echo "Publish mypokedex on port 5555 and start app"
                sh "docker run -d -p 5555:5555 --name mypokedex pokedex-go:latest sh -c 'npm start'"
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
