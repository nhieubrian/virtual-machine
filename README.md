# Installation:

Head over to https://kubernetes.io/docs/tasks/tools/ and install K8S based on your OS

Follow this guide, https://ucsd-prp.gitlab.io/userdocs/start/get-access/, to create your account and receive access to the Nautilus Servers. 

# Deployment

First, make edits based on the computing power needed:
In the file, “purpleaip.yaml”, you will need to change the hostname to a server that is open and has the components needed. Check out, https://nautilus.optiputer.net/resources to see the most up to date information on the servers. 

![alt text](/images/isaac1.png)

Currently, the .yaml file requires a total of 16gbs of memory available. This can be edited by: 

![alt text](/images/isaac2.png)

Changing the section, “memory:” and “ephemeral-storage:'' to 8, 16, 32 or 64Gi. Remember, change both sections! 


The machine can be deployed by going to Dockerfile in the repo, making an edit, undoing the edit, and then committing.  This will automatically start a job that can be seen in CI/CD -> Jobs.  Its progress can be tracked from there.



# Opening the VM

After the deployment is running, you can open https://purpleaip.nautilus.optiputer.net in a browser, click “connect” and login with the credentials.  The default credentials we have set are
Username: purpleaip
Password: purpleaip 

# Running things

Once logged in, you will have complete control over the virtual machine.  You may run the Isaac example apps and tutorials.  When leaving the virtual machine, only close the browser tab.  Do not log out.
