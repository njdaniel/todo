echo "Starting endpoint tests*************"
echo "*****************"

echo "testing /Home ******"
# TODO: add variables for port
# TODO: add functions for api calls
curl localhost:3000
echo ""
home_status=$(curl -s -o /dev/null -w "%(http_code)" localhost:3000)
echo ""
if [[ "${home_status}" =~ ^200 ]]; then
    echo "SUCCESS: Got $home_status"
else
    echo "FAILED wanted 200, got $home_status "
fi

echo ""
#METHOD | PATH              | ALIASES | NAME      | HANDLER
#------ | ----              | ------- | ----      | -------
#GET    | /                 |         | rootPath  | todo/actions.HomeHandler
#GET    | /tasks/           |         | tasksPath | todo/actions.TasksResource.List
#POST   | /tasks/           |         | tasksPath | todo/actions.TasksResource.Create
#GET    | /tasks/{task_id}/ |         | taskPath  | todo/actions.TasksResource.Show
#PUT    | /tasks/{task_id}/ |         | taskPath  | todo/actions.TasksResource.Update
#DELETE | /tasks/{task_id}/ |         | taskPath  | todo/actions.TasksResource.Destroy

echo "Testing GET /tasks *****************"
echo "  testing for success 200"
get_tasks_200=$(curl -s -o /dev/null -w "%{http_code}" localhost:3000/tasks)

if [[ "${get_tasks_200}" =~ ^200]]; then
    echo "SUCCESS: Got $get_tasks_200"
else
    echo "FAILED wanted 200, got $get_tasks_200"
fi


baseurl="localhost"
post_tasks_200=$(curl --location -g --request POST '{{baseurl}}/tasks'\
    --data-raw '{
        "id": "4559edbb-48f1-4a92-b8c2-4488fbdf5b30",
        "description": "everything",
        "done": "true",
        "created_at": ""2022-01-30 11:22:45.808065-05,
        "updated_at": ""2022-01-30 11:22:46.808065-05
}'

)

if [[ "${post_tasks_200}" =~ ^200]]; then
    echo "SUCCESS: Got $post_tasks_200"
else
    echo "FAILED wanted 200, got $post_tasks_200"
fi
