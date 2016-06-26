# chef-solo-demo
An intro to chef-solo ways of doing things with Chef


This repo cookbook will install mysql on a machine, create a database file and will do a restore of database
So in order to run this you'll need to go the chef-solo way.
##What you'll need:
  i) Chef SDK
  
  ii) knife-solo plugin

We'll assume that you have already setup Chef and Knife
You should install `knife-solo` to let you run chef-solo to bootstrap/configure servers.
Install with:

`chef gem install knife-solo`

Once installed run:

`knife solo prepare <username>@<server-address> -i <path/to/ssh_key>`

The server will be installed with Chef and chef-solo.

A file will be created in `nodes/` with the ip/nodename of the server. This is the file where we can define the node attributes for each of our node we have so far prepared.
Now modify the runlist/attributes for the node you just prepared and run:

`knife solo cook <username>@<server-address> -i <path/to/ssh_key>`
