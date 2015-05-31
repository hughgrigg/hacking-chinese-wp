Hacking Chinese WordPress Development
=====================================

Install dependencies:

```bash
sudo apt-get install virtualbox virtualbox-dkms vagrant npm bower
```

Add `192.168.33.10  hackingchinese.dev` to your hosts file:

```bash
sudo cat >> /etc/hosts '192.168.33.10  hackingchinese.dev'
```

Alternatively you can just use `localhost:8888` or `192.168.33.10` in which case
there's no need to edit the hosts file.

You'll need these files that aren't in the repo:

 - An export of the Hacking Chinese WordPress database. Put this in `vagrant/hc`
 and set the filename in the `DBFILE` variable in `vagrant/hc/server-
 provision.sh`.
 - Recent WordPress uploads from Hacking Chinese. Put these in
 `vagrant/hc/uploads/2015`

Finally, run:

```bash
vagrant up --provision
```

When that's done, visit http://hackingchinese.dev in your browser. If all is
well, the development version of Hacking Chinese will be displayed.

You can now go to http://hackingchinese.dev/wp-admin/index.php and log in with
the username `developer` and password `developer`.
