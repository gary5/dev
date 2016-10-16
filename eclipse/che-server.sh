ECLIPSE_HOME=$(pwd)

CHE_SERVER_CONTAINER_NAME=che-server

CHE_LOCAL_BINARY_ARGS=

CHE_PORT=8080
CHE_RESTART_POLICY=no
CHE_USER=root

CHE_CONF_ARGS="-v $(pwd)/conf:/container \
  -e CHE_LOCAL_CONF_DIR=/container \
  -e ECLIPSE_HOME=${ECLIPSE_HOME}"
CHE_STORAGE_ARGS="-v ${ECLIPSE_HOME}/che-data/workspaces:/home/user/che/workspaces \
  -v ${ECLIPSE_HOME}/che-data/storage:/home/user/che/storage"

CHE_SERVER_IMAGE_NAME=codenvy/che-server
CHE_VERSION=nightly

CHE_HOST_IP=$(ip a show | grep 'inet ' | cut -d/ -f1 | awk '{ print $2}' | grep '192.168.')
CHE_DEBUG_OPTION=

docker stop "${CHE_SERVER_CONTAINER_NAME}"
docker rm "${CHE_SERVER_CONTAINER_NAME}"
docker pull "${CHE_SERVER_IMAGE_NAME}":"${CHE_VERSION}"

docker run -it --name "${CHE_SERVER_CONTAINER_NAME}" \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /home/user/che/lib:/home/user/che/lib-copy \
  ${CHE_LOCAL_BINARY_ARGS} \
  -p "${CHE_PORT}":8080 \
  --restart="${CHE_RESTART_POLICY}" \
  --user="${CHE_USER}" \
  ${CHE_CONF_ARGS} \
  ${CHE_STORAGE_ARGS} \
  "${CHE_SERVER_IMAGE_NAME}":"${CHE_VERSION}" \
    --remote:"${CHE_HOST_IP}" \
    -s:uid \
    -s:client \
    ${CHE_DEBUG_OPTION} \
    run
    # > /dev/null
