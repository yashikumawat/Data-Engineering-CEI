
# Assignment 4 –  Azure Cloud Fundamentals and Data Pipeline Implementation using ADF

## Overview

This repository contains the implementation and output of **Assignment 4**, which focuses on building a complete data integration workflow using **Microsoft Azure** services. The assignment demonstrates the process of creating Azure resources, configuring storage, building Azure Data Factory (ADF) pipelines, executing data movement operations, and managing access through Azure Identity and Access Management (IAM).

The repository includes the final output document containing screenshots and evidence for each task completed during the assignment. 

---

# Assignment Description

This assignment demonstrates the end-to-end implementation of a cloud-based data integration solution using Azure services. The objective was to understand how Azure Storage and Azure Data Factory work together to create automated data movement pipelines while implementing secure access management.

The assignment begins with provisioning Azure resources, followed by configuring Azure Storage for storing source and destination data. Azure Data Factory is then used to establish linked services, datasets, and activities required to automate data movement between storage locations. Finally, access permissions are managed through IAM, and the complete workflow is validated by successfully executing the pipeline.

---

# Tasks Performed

## 1. Azure Resource Group Creation

* Created a new Azure Resource Group to organize all cloud resources.
* Verified successful deployment of the resource group.
* Documented the created resources with screenshots. 

## 2. Azure Storage Configuration

* Created an Azure Storage Account.
* Configured Blob Storage containers.
* Uploaded sample files into the container for pipeline processing.
* Verified successful file upload and storage configuration. 

## 3. Azure Data Factory Configuration

* Created an Azure Data Factory instance.
* Configured Linked Services to establish connectivity with Azure Storage.
* Created datasets representing the source and destination data.
* Configured the **Get Metadata** activity to retrieve information about the stored files before processing. 

## 4. Pipeline Development

* Designed a complete Azure Data Factory pipeline.
* Configured the source dataset.
* Configured the destination dataset.
* Implemented the Copy Data activity for transferring files.
* Connected all activities to create a functional workflow.
* Validated the pipeline configuration before execution. 

## 5. Pipeline Execution and Validation

* Executed the developed pipeline.
* Verified the successful execution status.
* Confirmed successful completion of both the **Get Metadata** and **Copy Data** activities.
* Validated that the data was successfully copied from the source container to the destination container. 

## 6. Identity and Access Management (IAM)

* Assigned the required Azure IAM roles.
* Configured secure permissions for Azure Data Factory to access Azure Storage.
* Verified successful role assignment and secure connectivity between services. 

## 7. Mini Project

The final task integrates all the concepts implemented throughout the assignment into a complete Azure Data Factory solution. The project demonstrates a fully functional ETL workflow where data is successfully transferred between storage locations using an automated pipeline. The final execution confirms that all activities completed successfully and the destination storage contains the copied data, validating the end-to-end implementation. 

---

# Learning Outcomes

After completing this assignment, the following concepts were successfully implemented:

* Azure Resource Group creation and management
* Azure Storage Account configuration
* Blob Storage container creation and file management
* Azure Data Factory setup
* Linked Services configuration
* Dataset creation
* Get Metadata activity
* Copy Data activity
* Pipeline development and orchestration
* Pipeline execution and monitoring
* Azure IAM role assignment
* Secure access management
* End-to-end cloud-based ETL workflow implementation


