# Yarn-Utilization
## Automated Yarn Capacity Utilisation Script &amp; Reporting

Most of our monthly reporting deliverables involve reporting around “Job submissions” and “HDFS capacity”.
We have very little information presented in regard to YARN Queues (Primarily -- CPU/Memory/Max Applications running)


A Graphical picture of Yarn Capacity Utilization, showing a time series referenced data of usage metrics throughout the week/month would help us understand multiple questions related to capacity. 
Queue Based Capacity Metrics could help Augment below listed answers about any cluster

•	How well Spaced Cluster Jobs are?
•	What times is the cluster underutilized/ over utilized?
•	How many containers are used at a particular point in time? 
•	Average Load of the cluster at any particular time window
•	Less priority jobs can be scheduled at what times.
•	DO WE NEED ADDITIONAL CAPACITY TO ACCOMMODATE OUR WORKLOAD?

## Script Details: 
* Language: Perl
* Base Util: Capacity Scheduler Api
* Libraries Needed: JSON

## How It Works ::
The Script Currently Works for Hortonworks CAPACITY SCHEDULER ALONE --- It calls the Rest API and scrapes the necessary values every 15 minutes (customizable time range) and sets up a csv file for the same. 

## Information Provided ::

1. Cluster utilization percentage all through the day   
1. Maximum #containers that were run daily 
1. Maximum application submitted for each queue 
1. Number of Vcores used through the day

## Currently there are 2 options to create the graphs once the csv file is generated from the script.

1. Automated HTML rigid graphs 		-- Minimal human efforts, No user flexibility (Better for small number of queues)

1. Excel based pivot graphs created manually	-- Needs human intervention, Flexible as a dancer’s body!! (Best for organization with Huge number of queues --- My Current Organization project grew upto 96 queues !!!)


 


