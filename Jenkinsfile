pipeline {

    agent {
        node {
            label 'AGENT-1'
        }
    }

    environment {
        Greeting = 'Hello World'
    }

    stages{
        stage("Build"){
            steps{
                echo "====Build===="
            }
        }
        stage("Test"){
            steps{
                echo "====Test===="
            }
        }
        stage("Deploy"){
            steps{
                echo "====Deploy===="
            }
        }
        stage("shell")[
            steps{
                sh """
                    env
                """
            }
        ]
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