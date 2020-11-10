pipeline{
    // Agent : fait éxecuter les étapes lors du build
    agent any

    // Déclenche un pull de git à intervalle régulier au niveau du job (override la conf du pipeline)
    triggers {
        pollSCM('* * * * *')
    }

    stages{
        stage ("Environment variables"){
            steps{
                echo "Workspace directory is ${env.WORKSPACE}"
            }
        }
        // Récupère le code source déclaré dans la conf du multibranch pipeline
        stage("1.CHECKOUT : branch master"){
            steps{
                echo "Pulling..." + env.BRANCH_NAME
                checkout scm
            }
        }
        // Build l'image pokedex-go:latest en utilisant le Dockerfile (base node6-alpine + expose 5555 + copie app + install + start)
        stage("2.BUILD : a docker image using the Dockerfile you created in step 2"){
            steps{
                echo "Build docker image"
                sh "docker build -t pokedex-go:latest ."
            }
        }
        // Lance les tests dans le container pokedex-go:latest en remplacant le "CMD npm start" du Dockerfile par "npm test"
       stage("3.TEST : Run the unit tests within the image using npm test"){
            steps{
                echo "Run unit tests"
                sh "docker run --rm pokedex-go:latest npm test"
            }
        }
        //
        stage("4. DEPLOY : Run a container from your image, publishing port 5555, run npm start"){
            steps{
                echo "Delete existing mypokedex image or continue"
                sh "docker rm -f mypokedex || true"
                // Lance l'image docker (avec suppresion à la fin --rm ) en mode détaché -d, nommé mypokedex --name
                echo "Publish mypokedex on port 5555 and start app"
                sh "docker run --rm -d -p 5555:5555 --name mypokedex pokedex-go:latest"
            }
        }
    }
    // Se lance toujours à la fin du pipeline : fait le ménage dans le workspace
    post {
        always {
            cleanWs()
        }
    }
}
