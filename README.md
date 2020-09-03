Courtlistener Disclosure Extractor
==================================

Courtlistener disclosure extractor is an open source repository to 
maintain, disclosure-extractor in a docker image for use in Courtlistener.com

Further development is intended and all contributors, corrections and 
additions are welcome.

Background
==========

Free Law Project built this to help extract out data from roughly 18k financial
records. These records are available for a limited period from the US Government
before they are destroyed.  In an effort to review roughly 20 years of records we needed
a method to extract out the information at a high degree of accuracy.

We use this docker image inside courtlistener.

Deployment to Docker
====================

1.  Update version number in hooks/version.txt

2.  Commit to master


The post_push is required to generate both latest and version numbering 
in our builds.  If no version number is updated, any commit to master will 
overwrite the latest docker image. 

Future
=======

1) Continue to improve ...
2) Future updates



License
=======

This repository is available under the permissive BSD license, making it easy and safe to incorporate in your own libraries.

Pull and feature requests welcome. Online editing in Github is possible (and easy!)
