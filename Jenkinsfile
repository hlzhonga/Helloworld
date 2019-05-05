pipeline{
    agent any
  parameters {
        string(defaultValue: "Release2019001", description: 'Which branch?', name: 'gitBranch')
        booleanParam(name: 'build', defaultValue: false)
        booleanParam(name: 'delopy', defaultValue: false)
        booleanParam(name: 'Build_ByTag', defaultValue: false)
        string(defaultValue: "TAG_1.0.1", description: 'Which tag?', name: 'gitTag')
        choice choices: ['agency', 'order', 'taobao', 'product'], description: '请选择构建的APP', name: 'choice'
        text defaultValue: 'test', description: '', name: 'text'
        password defaultValue: '123456', description: '请输入密码', name: 'passwd'
        gitParameter branch: '', branchFilter: '.*', defaultValue: '', description: '', name: 'gitlist', quickFilterEnabled: false, selectedValue: 'NONE', sortMode: 'NONE', tagFilter: '*', type: 'PT_BRANCH_TAG'


    }
    stages {
        stage('pullcode'){
                steps{
                echo "${text}"
                script{
                 Object o = env.gitTag
                if (o) {
                 sh 'git checkout test_0426'
               sh ''' echo "正在进入tag: ${gitTag}"
                ls'''
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '1e5af25d-ce33-4611-9db7-35a3e8e6aaee', url: 'http://192.168.17.143/root/ocp.git']]])
                } else {
                echo "进入branch"
                }
             }
             echo "${params.gitTag}"
             echo "${env.gitTag}"
             echo "${gitTag}"
             echo "hello world"
             }
                
            }
    stage('build'){
            steps{
               sh '''
            /usr/local/apache-maven-3.6.0/bin/mvn package
            docker build --build-arg JAVA_DIR=/var  -t  test2019:${JOB_NAME}_${BUILD_ID} .
            docker tag test2019:${JOB_NAME}_${BUILD_ID} 192.168.17.143:5000/test2019:${JOB_NAME}_${BUILD_ID}
            '''
            dir('target') {
             sh 'pwd'
            }
           
            archiveArtifacts artifacts: 'target/*.war', onlyIfSuccessful: true
            }
       }
       
    stage('run'){
        steps{
     dir('/home/'){
     sh 'docker run --name test2019__${BUILD_ID} -d  -p 80${BUILD_ID}:8080 test2019:${JOB_NAME}_${BUILD_ID}'
     sh 'pwd'
      }
       sh 'pwd'
     }
    
    }
        }
    post {       
        always {          
            echo 'One way or another, I have finished'           
            deleteDir()
        }       
}
    }
    
