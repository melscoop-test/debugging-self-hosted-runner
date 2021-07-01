# debugging-self-hosted-runner
## The script
This repository aims to show an issue we are facing by using self-hosted runners.

It installs and run a self-hosted runner in a docker container with `./run.sh --once`
When the runner finish the job and stop, we try to delete it with `./config.sh remove`. 
Then it configures a new runner for the next action.

## The error
A problem occurred, some time, when we try to remove a runner. It returns us an error, saying the job is busy, the same error occurred with the force delete API call. An action is linked to the runner even if he is offline and this fail the whole workflow. 
Error from the runner:
```
Failed: Removing runner from the server
Runner "********" is still running a job"
```

Error on github.com:
```
The self-hosted runner: ******** lost communication with the server. Verify the machine is running and has a healthy network connection. Anything in your workflow that terminates the runner process, starves it for CPU/Memory, or blocks its network access can cause this error.
```

Error with the API:
```
{
  "message": "Bad request - Runner "********" is still running a job\"",
  "documentation_url": "https://docs.github.com/rest/reference/actions#delete-a-self-hosted-runner-from-an-organization"
}
```

## What we are expecting
One of this call should delete the runner, no action should be linked to this runner after the job has ran. And should delete it even if an action is linked to it.

# Test it
Start the script with
```shell
./run.sh <github-organization> <self-hosted-github-token>
```

then run the action which is in the `.github/workflows` folder.
