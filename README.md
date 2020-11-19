# URL Shortener
 This is a project from my CPSC 254 (Open Source Software Development) class, utilizing Docker containerization and Kjell Zetterstroem's Flask URL Shortener
 This was a project that I had developed in 2019. This was a particularly rewarding project, and one that I feel is a strong indicator of my skills in software development.
 
# Lab 5: Docker

[Docker](https://www.docker.com/) containers are a type of [OS-level virtualization](https://en.wikipedia.org/wiki/OS-level_virtualization). Building application containers is a valuable, lightweight tool in developing, deploying, and managing applications. Furthermore, applications can be composed from different containers. Containers may take advantage of virtual machines as well.

## Goals
* Complete the Docker Getting Started tutorial for an introduction to the Docker toolset.
* Create and run a Docker container which defines a web application written in Python.
* Use a pre-existing Docker container to run a server on your personal computer.

## Prerequisites
For this assignment, you must have:
* a GitHub account linked to your university email address
* a Tuffix system (use of a VM is not recommended)
* a Docker Hub account is suggested but not required.

## Lab instructions

The lab has three parts. The first part is trivial and is meant to be an introduction to the Docker software. The second part requires requires using Git, Docker, some working knowledge of Python web applications, and your knowledge about the BASH shell. The third part requires the use of Docker, BASH shell, and a basic understanding of DNS and Bind.

You may find the following references useful in navigating the software used in this exercise:
* [ISC Bind homepage](https://www.isc.org/bind/)
* [ISC Bind Administrator Reference Manual](https://bind9.readthedocs.io/en/latest/)
* [Docker homepage](https://www.docker.com/)
* [Docker Getting Started v.17.09](https://docs.docker.com/v17.09/get-started/)
* [Docker Getting Started v17.09](https://docs.docker.com/v17.09/get-started/)
* [Docker Community Edition (CE) for Ubuntu](https://docs.docker.com/v17.09/engine/installation/linux/docker-ce/ubuntu/)
* [Install Docker Machine](https://docs.docker.com/machine/install-machine/)
* [Python Documentation](https://docs.python.org/3/)
* [Flask Documentation](https://www.palletsprojects.com/p/flask/)
* [Dig](https://www.madboa.com/geek/dig/)

### Cloning the Git Repository

Like the previous exercise, once you are logged into your GitHub account, open the assignment URL that your instructor has shared with you. (Most likely it will be on the class Titanium page.) Clone your repository and begin working on your laboratory assignment.

### Part 1: Getting Started with Docker

The first part of the laboratory exercise to is to follow the steps given in the [Docker Getting Started v.17.09](https://docs.docker.com/v17.09/get-started/) page. (Please follow the older Getting Started documentation because it is much more Linux specific than later versions and omits coverage of [Kubernetes](https://kubernetes.io/) which is beyond the scope of this exercise.)

Use the folder named part1 in your git repository for this portion of the laboratory exercise.

Please follow every step in the Getting Started guide up from Part 1 to Part 3. Parts 4, 5, and 6 are optional but you are encouraged to go through these parts.

### Part 2: A Flask App - Kjell Zetterstroem's Flask-URL-Shortener

In the directory named part2, you shall create a Docker container defining a URL shortening service. This exercise is very similar to the Getting Started exercise because in steps 2-3 you created a trivial Hello World Flask application and ran it in a container.

In this exercise, [Kjell Zetterstroem's Flask-URL-Shortener](https://github.com/GlowSquid/Flask-URL-Shortener) shall be the web application which you will place into a container.

*Do not clone this repository into your homework assignment until you have read and understood [Git Submodules](https://book.git-scm.com/book/en/v2/Git-Tools-Submodules).*

Did you read and understand how to use [Git Submodules](https://book.git-scm.com/book/en/v2/Git-Tools-Submodules)? If you're answer is no, then please read [https://book.git-scm.com/book/en/v2/Git-Tools-Submodules](https://book.git-scm.com/book/en/v2/Git-Tools-Submodules).

Since the Flask-URL-Shortener is already a Git repository, you can add it to your own repository as a submodule. Once you have added the url shortener as a submodule, you can create a Dockerfile for the container.

Use the Getting Started Dockerfile as a starting point. The two containers are very similar in that they both use Python, Flask, and have a requirements.txt file.

The URL shortener makes use of the MySQL relational database to store all the short and long URLs similar to how Wordpress used it to store blog postings. Add a [MySQL container](https://hub.docker.com/search?q=mysql&type=image) to your Dockerfile and connect your URL shortener to the database manager.

The final step is to write a shell script named 'docker_urlshortener.sh'. The script takes one parameter. There parameter may be one of the following: start, stop, status. If you run docker_urlshortener.sh with the start parameter, it shall start the URL shortening container you defined. If you run the docker_urlshortener.sh with the stop parameter, it shall halt the URL shortening container you defined. The status parameter shall show if the container is running or not.

### Part 3: A DNS Server

In the directory named part3, please create a DNS service using Docker.  The DNS service you shall be creating shall use ISC Bind. Bind is a very sophisticated and robust DNS server. The goal is to create a DNS service which caches answers to queries and blocks advertising.

Instead of building a Docker container from scratch, we shall use Ventz Petkov's [ventz/bind](https://hub.docker.com/r/ventz/bind) as a starting point. Please refer to Ventz Petkov's GitHub repository [ventz/docker-bind](https://github.com/ventz/docker-bind) to understand how the Docker container was built. 

We shall use the data from [Peter Lowe's Blocking Adservers page](https://pgl.yoyo.org/adservers/) to build our DNS server's blocking feature.

The firt step is to fetch the [ventz/bind](https://hub.docker.com/r/ventz/bind) container and run it on your computer. Instructions on how to do this are at the bottom of Docker Hub page. Recall that you can use the dig command to make DNS queries against a specific resolver. Note that if you have a competing server running on port 53 you will have to either run the Bind container on an alternate port or disable whatever service you have running on port 53.

Once you have mastered turning on, querying, and turning off your DNS server, the next step is to configure your DNS server to block advertisements. You need to decide if you wish to use the legacy Bind 8 style of blocking advertisements or using the modern Response Policy Zones (RPZ) of Bind 9 to block advertisements. The complexity in implementing either option is roughly the same.

If you decide to use the Bind 8 style, please select 'bind 8 config -- in bind 8 named.conf format' on Peter Lowe's Blocking Adservers page. This will generate a file that you can name 'named.conf.adblock'. In this file, there is one zone for every domain that serves advertisements. The zones point to a null.zone.file which effectively returns a null response to any client trying to resolve an advertisement serving domain name. Include the generated file into your named.conf file.

If you decide to use the RPZ format, select 'rpz -- for use as an RPZ file with BIND' on Peter Lowe's Blocking Adservers page. This will generate a file that you can name 'db.adblock'. In this file, all the adserving domains are defined under one zone database file. You will need to create a zone entry in the named.conf file and point that zone to this db file. An in depth tutorial on how to create an RPZ for Bind is online at [https://www.isc.org/docs/BIND_RPZ.pdf](https://www.isc.org/docs/BIND_RPZ.pdf). Starting from slide from the bottom of slide 14, the author demonstrates how to load multiple RPZ zone databases and configure responses for those domains.

As in the first step, master how to start and stop the DNS service using this docker container.

The final step is to write a shell script named 'docker_dns.sh'. The script takes one parameter. There parameter may be one of the following: start, stop, status. If you run docker_dns.sh with the start parameter, it shall start the DNS container you defined. If you run the docker_dns.sh with the stop parameter, it shall halt the DNS container you defined. The status parameter shall show if the container is running or not.

### Pushing code to Git (submitting your assignment)

To submit your code, you will need to add the files that you want to submit, commit your changes, and push them into the GitHub repository.

## Rubric (10 points)
1. (4 points) The Vagrantfile and bootstrap.sh in part1 exists and correctly provisions a VM.
2. (3 points) The Vagrantfile and bootstrap.sh in part2 exists and provisions a VM with the correct software.
3. (3 points) Part2's bootstrap.sh correctly provisions the VM to serve a Wordpress site without any operator intervention.

Assignments that are not submitted through GitHub shall not be graded.

