def buildTypes(String branch) {
    return ['Release', 'Debug', 'RelWithDebInfo'];
}

pipeline {
    options { buildDiscarder(logRotator(numToKeepStr: '3')) }

    environment {
        BASE_DIR = "/tmp"
        BUILD_DIR = "/tmp/build"
        ARTIFACT_FILE = "dcmtk.tar.bz2"
    }

    agent {
        dockerfile {
            filename 'Dockerfile.build'
            label 'backend'
            args '-v ${WORKSPACE}:/tmp'
        }
    }

    parameters {
        choice(
            name: 'BUILD_TYPE', 
            choices: buildTypes(env.BRANCH_NAME), 
            description: 'Select type of build: Release, Debug, Release with Debug Info'
        )
    }

    stages {
        stage('Build') {
            steps {
                sh '''
                echo "[Build] Branch: ${BRANCH_NAME}"
                cc --version
                c++ --version
                ls -l ${BASE_DIR}
                cd ${BUILD_DIR}
                cmake \
                    -DCMAKE_BUILD_TYPE="Release" \
                    -DDCMTK_ENABLE_PRIVATE_TAGS="ON" \
                    -DDCMTK_ENABLE_STL="ON" \
                    ..
                make -j16
                tar cjf ${ARTIFACT_FILE} -C ${BUILD_DIR}/bin .
                '''
            }
        }
    }

    post {
        success {
            archive "${ARTIFACT_FILE}"
        }
    }
}
