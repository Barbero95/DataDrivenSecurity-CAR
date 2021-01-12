# DataDrivenSecurity-CAR

All the yaml files are downloaded from https://github.com/mitre-attack/car/tree/master/analytics and two dataframes are generated from the information in the files

As a point of interest, in this url https://car.mitre.org/analytics/ we find two tables, the first one relates the files with the ATT&CK techniques, the implementations and the platforms it affects. The second we find about ATT&CK techniques and the subtechniques in which files we find information about them.

## First dataframe (variable en car.R -> df)

Parameters of interest:

- id: Name of the yaml file
- Title: //TODO
- Description: //TODO
- Submission_date: //TODO
- Information_domain: The information domain is the top-level categorization of the analytic. It should describe the type of analytic: Is it based on anomaly detection? A specific behavior? Statistical analysis?
  - There are five possible information domains: Host, Network, and Analytic, External, and Other.
- platforms: Platforms affected
  - Tipos: Windows, Linux, macOS
- subtypes: //TODO
  - Tipos: Registry, Login, Process, PCAP, Netflow, Network, Network Process, Network Process File, Network Registry File, Map building, Anomal, Hostflow, Process DLL, Registry File Process, Hostflow, API RPC, File API, Network API RPC, Event Records.
- subtechniques: //TODO
  - Tipos: Situational Awareness, TTP, Situational Awareness, Detection, Anomaly

## Second dataframe (variable en car.R -> dfCoverage)

Techniques refer to ATT & CK Techniques

  - id: Name of the yaml file
  - Technique: //TODO
  - Tactics: //TODO
  - Coverage: //TODO
    - Tipos: Low, Moderate, High
  - Subtechniques: //TODO
