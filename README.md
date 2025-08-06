# All of Us Pathogen Alignment docker 

This is a repo to run {TOOL} on All of Us workbench via dsub. 
dsub deploys multiple google VMs sparked up via a pubic docker image that contains all the stuff you want. 


Following the instructions from: https://support.researchallofus.org/hc/en-us/articles/21179878475028-Using-Docker-Images-on-the-Workbench
https://cloud.google.com/storage/docs/access-control/making-data-public#:~:text=Terraform%20REST%20APIs-,In%20the%20Google%20Cloud%20console%2C%20go,the%20Cloud%20Storage%20Buckets%20page.&text=In%20the%20list%20of%20buckets,the%20person_add%20Grant%20access%20button.

Example github: https://github.com/zlskidmore/docker-hla-la
> NOTE! This dockefile fails and cant be used to spark an image it makes me so MAD. to be fair it is 6 years old so it could start preschool

Neccesary tools: 
1) gatk-4.2.6.0 ## No other GATK version can be used the remote PrintReads function screams bloody murder
* https://hub.docker.com/r/broadinstitute/gatk/tags
i.e. FROM broadinstitute/gatk:4.2.6.0
2) Bowtie2 
3) BWA (just in case you want it) 

# DOCKERFILE
My approach is to like... minimize the tools I need to install.
That said, having multiple docker environments for each step increases the costs for spinning up various VMs and sycronizing the batches on a google bucket. STRIKE THE BAlANCE 
> htslib was old so I had to do a manual apt-get install for the developer version.. 

I loaded gatk, then I installed git, then I installed bt2 and bwa, finally I clone a public repo with the fasta files and indexed them

Index is available at this path in the docker 
`~/bin/pathogen_reference/ref/ukb_pathogens_longread_toxo` 

# Workflow 

1) Establish a Dockerfile that can be built into an image on a linux machine (Crystal). 
2) Log into dockerhub and then push that image to dockerhub (jacobog02@gmail.com) 
> Dont forget to `docker login -u "jacobog02" -p 'XXX' docker.io`
3) Create a new google project and upload the image (pulled from dockerhub) to Google Container Registry (GCR) following instructions above ^^^ 
4) Log onto google console to confirm the image exists, finally in the IAM for that specific container add AllUsers as roles/storage.objectViewer to allow dsub to read the image

If everything worked finally in all of us you can reference this docker image in your dsub call to load the environment: gcr.io/jg-public-docker-gcp/jg-pathogen

