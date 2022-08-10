Hacking Chinese WordPress Development
=====================================

## Building the theme

The following commands will export the theme to a zip archive in the `export/` directory.

```bash
nvm install
npm install
./node_modules/.bin/gulp export
```

## Running the development server

Install dependencies:

```bash
sudo apt-get install virtualbox virtualbox-dkms vagrant npm
```

You'll need these files that aren't in the repo:

 - An SQL-format export of the Hacking Chinese WordPress database. Put this in `vagrant/hc`
 and set the filename in the `DBFILE` variable in `vagrant/hc/server-
 provision.sh`.
 - Recent WordPress uploads from Hacking Chinese. Put these in e.g.
 `vagrant/hc/uploads/2022`

Then run the following:

```bash
./node_modules/.bin/gulp style
```

Finally, run:

```bash
vagrant up --provision
```

When that's done, visit http://localhost:8888 in your browser. If all is well, the development version of Hacking
Chinese will be displayed.

You can now go to http://localhost:8888/wp-admin/index.php and log in with
the username `developer` and password `developer`.
