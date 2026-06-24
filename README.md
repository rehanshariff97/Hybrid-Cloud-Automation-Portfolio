# Hybrid Cloud Automation & Infrastructure Lab

## Project Overview
This repository showcases a hybrid cloud automation pipeline. It integrates an on-premises environment running **Windows Server 2025** with **Microsoft Azure** cloud infrastructure utilizing custom **PowerShell 7** automation.

## Architecture & Workflow
1. **Local Telemetry Collection:** A local automated script (`Backup-ServerHealth.ps1`) queries the host OS for hardware volume utilization metrics and aggregates data into structured system health logs.
2. **Cloud Synchronization Pipeline:** An advanced cloud-integration script (`Sync-ToAzure.ps1`) handles authentication requirements via secure device code tokens, establishes an active context with **Azure for Students**, and pushes telemetry straight into **Azure Blob Storage (Hot Tier)**.

## Skills Demonstrated
* Systems Administration (Windows Server 2025 Architecture)
* Cloud Engineering & Storage Management (Microsoft Azure Core Services)
* Infrastructure Automation & Advanced Tooling (PowerShell Scripting)
* Revision & Source Control (Git / GitHub Workflow Management)
