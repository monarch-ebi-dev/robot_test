## Testing a new ROBOT feature on a branch with the ODK

To test a new ROBOT feature on a branch with the ODK, simply run:


```
BRANCH=532-fix ROBOT_REPO=rctauber/robot ./prepare_robot_test.sh 
```

The previous command 

1. clones the repo, 
1. checks out the branch with the fix
1. build the robot jar 
1. pushes it upstream to the target directory of this repo
1. clones ODK
1. compiles a dev version (obolibrary/odkdev) of the new jar using the new version of robot

This ODK can then be used to run tests.