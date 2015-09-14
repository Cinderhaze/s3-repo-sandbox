# s3-repo-sandbox
A sandbox set of configs for trying to get an s3 yum repo plugin working on aws with signature version 4


I'll create two seperate puppet manifests, and a bootstrap script to switch between the repositories



Links / resources
http://stackoverflow.com/questions/27400105/using-boto-for-aws-s3-buckets-for-signature-v4   --  Example to get aws sig 4 working with boto

http://stackoverflow.com/a/14288563 - Way to connect directly to s3 though boto

http://boto.readthedocs.org/en/latest/s3_tut.html - offical boto docs

https://github.com/yegor256/s3auth/issues/214 -- Discussion about how to add sig4 to an s3auth project

