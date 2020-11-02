pipeline{
    agent{
        label "any"
    }
    stages{
        stage("A : Checkout branch master"){
            steps{
                checkout scm
				echo 'Pulling...' + env.BRANCH_NAME
            }
            post{
                always{
                    echo "========always========"
                }
                success{
                    echo "========A executed successfully========"
                }
                failure{
                    echo "========A execution failed========"
                }
            }
        }
        stage("B : build a docker image using the Dockerfile you created in step 2"){
            steps{
                echo "========executing B========"
            }
            post{
                always{
                    echo "========always========"
                }
                success{
                    echo "========B executed successfully========"
                }
                failure{
                    echo "========B execution failed========"
                }
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
