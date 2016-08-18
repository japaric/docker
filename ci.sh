set -ex

main() {
    if [ "$TRAVIS_BRANCH" = "deploy-$IMAGE" ]; then
        if [ "$TRAVIS_PULL_REQUEST" == false ]; then
            set +x
            docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USER" -p="$DOCKER_PASS"
            set -x
            travis_wait bash $IMAGE/deploy.sh
        else
            echo 'error: deploy branches must not diverge from master' && exit 1
        fi
    elif [[ "$TRAVIS_BRANCH" != deploy-* ]]; then
        bash $IMAGE/deploy.sh --test-only
    fi
}

main
