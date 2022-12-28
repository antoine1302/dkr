start_shell() {
    local service_name=$1
    docker exec -it ${service_name} bash
}