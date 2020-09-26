# Research
Research compiled worldskills.

### Preparing for aws gameday series
- iam: check and lock down accounts if possbile, change passwords

### Past aws gameday code
https://github.com/rumd3x/aws-gameday-unicorn
 - server appears to be some form of binary (aws 2019 reinvent gameday)
 - docker is possible (alpine seems to work, so small docker images
 
### aws gameday briefing from stream 2017
https://www.youtube.com/watch?v=1ry0mYEdfno
- iam: check what we can access
- services map: go through ec2/elastic cache/rds figure out what is connected to what
- check vpcs: instances in production vpc etc.
- billing: check for expensive stuff
- server responses cachable, so use a cdn i guess
- requests GET /calc?/input=base64 stuff HTTP 1.1
- optimise both cost & request time
- points: sucessfully serve requests with time limit 
- trend: whether we gaining or loosing points
- badges: special tasks
- t2.micro instances $8/15 min, 15min min bill
- download keypair to access server
- lock down server with security groups (ie limit ports, ip addresses, ) & ie db not exposed to the world etc.
- lock down iam: change passwords of extra accounts 
- create instance with new ssh key to access instance
- caching pretty important: requests are repeated
- better system utilisation if we pack multiple servers into sg ec2 instance. (ie though docker/k8s/ecs)

# ws 2020 sg tech description
- 16 hrs 3 days
- ha with multiple az , autoscaling
- mointoring with various metrics
- make it cheap: score based  on cost apparently (ie spot instances)
- - skills: windows 10, ssh client, mysql, filzilla ftp, MS office

# sch briefing
- redis probably (maybe elastic cache, although apparently self-host cheaper)
- sql db not sure which kind (learn managed rds)
- learn dynamo db

# some guys medium article (dbs sg aws gameday) 2019
https://medium.com/@isaeefullah/dbs-aws-gameday-experience-9a9fa35db9e6
- challenge 1 - getting production back up and running 
- ec2 instance setup  website and serve images from s3
- fortify against cyber attack (not sure what)
- challenge 2 - time to market
- contract dev to deployment time

# runbook review
- servers standalone binary (4s per requests)
- server has internal queue? accessable at /healthcheck
- server horizontally scalable, completely stateless
- *responds well to caching techniques (suggests cdn/cloud front)
- 503 when the servers request queue fills > 5 connection
 
- review score log/entries, which slow the reason u earn or lose score.
- amazon linux is used as base OS although in theory any linux should work
- server might to reference something in s3? (probably server)
- user data of instance details script that downloads server binary from s3.

# worldskils standards specification
- nosql: dyanmo db
- Blue/Green deployments
- resilency against failure senario

# worldskills 2019 Kazan
1. Day One
- non work api: one hour to get it working
- redis/mysql/shared file mount will speed requests served
- mysql need create table
- config file server.ini and logs to specific file 

2. Day Two
- non work api: 30 min to get it working
- multiple instances api & web lookup service
- root server: memcached server, config file server.ini and logs to specific file 
 - lookup server: config file server.ini , postgressql,  log file, app_log, log file, memcache
 - url routing require / should route to root server /lookup should show something else
 - db prevent insertion if match “H@XX0RR333DDD”, delete entries matching “H@XX0RR333DDD”
 - s3 permissions: mointor use using s3 logs and lock down buckets not serving webcontent
 - forced to use ecs migrate python app.py to container

3. Day Three
- already working - make it highly available and resilent to network failure
- elb -> ec2 server - via route 53 dns -> rds
- tests by shutting down  us-east-2b
- aws prevent ssh logins - ec2 -> sqs -> lambda - auto quanrantine
- find secrets embedded in source code/change ssh keys to access ec2?
- obsure aws  stuff: IDS guardduty write script to automatically respond to incidents, fix lambda function

4. Day Four - AWS fest
- rouge script invoking services: cloud watch to track which api tracking stuf
- quanrantine instance automation: disconnect instance, allow traffic from just the fronesics instance ony, block outgoing traffic
- AWS API gatway fest

