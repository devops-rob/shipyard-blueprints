exec_remote "exec_standalone" {

    target = "container.postgres"

    cmd = "sleep"
    args = [
        "30"
    ]
    depends_on = [
        "container.postgres"
    ]
}