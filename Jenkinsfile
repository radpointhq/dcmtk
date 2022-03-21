def buildTypes(String branch) {
    return ['Release', 'Debug', 'RelWithDebInfo'];
}

pipeline {
    options { buildDiscarder(logRotator(numToKeepStr: '3')) }

    environment {
        BASE_DIR = "/tmp"
        BUILD_DIR = "/tmp/build"
        BIN_DIR = "/tmp/build/bin"
        ARTIFACT_FILE = "dcmtk.tar.bz2"
    }

    agent {
        dockerfile {
            filename 'Dockerfile.build'
            label 'backend'
            args '--mount source=${env.WORKSPACE},target=/tmp'
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
                sh 'echo "[Build] Branch: ${env.BRANCH_NAME}"'
                sh 'cc --version'
                sh 'c++ --version'
                sh 'ls -l ${BASE_DIR}'
                sh 'mkdir -p ${BUILD_DIR}'
                sh 'cd ${BUILD_DIR}'
                sh 'cmake \
                    -DCMAKE_BUILD_TYPE="Release" \
                    -DDCMTK_ENABLE_PRIVATE_TAGS="ON" \
                    -DDCMTK_ENABLE_STL="ON" \
                    ..'
                sh 'make -j16'
                sh 'tar cjf ${ARTIFACT_FILE} -C ${BIN_DIR} .'
            }
        }
    }

    post {
        success {
            archive "${ARTIFACT_FILE}"
        }
    }
}
