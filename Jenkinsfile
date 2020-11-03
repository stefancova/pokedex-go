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
                sh docker run pokedex-go:latest
                sh cd pokedex-go && npm install
            }
        }
        stage("C : run the unit tests within the image using npm test"){
            steps{
                echo "========executing C========"
            }
        }
        stage("D : run a container from your image, publishing port 5555, run npm start"){
            steps{
                echo "========executing D========"
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
