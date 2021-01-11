# DataDrivenSecurity-CAR

Se descargan todos los ficheros yaml de https://github.com/mitre-attack/car/tree/master/analytics y se generan dos dataframes a partir de la info extraida.

Como punto de interés, en esta url https://car.mitre.org/analytics/ encontramos dos tablas, la primera relaciona los ficheros con las técnicas de ATT&CK, las implementaciones y las plataformas que afecta y la segunda encontramos sobre las técnicas de ATT&CK y las subtecnicas en que ficheros encontramos información sobre ellas.

## Primer dataframe (variable en car.R -> df)

Parametros que encontramos:

- id: Nombre del fichero yaml que se ha extraido la info
- Title: //TODO
- Description: //TODO
- Submission_date: //TODO
- Information_domain: //TODO
  - Tipos: Analalytic, Host, Network
- platforms: //TODO
  - Tipos: Windows, Linux, macOS
- subtypes: //TODO
  - Tipos: Registry, Login, Process, PCAP, Netflow, Network, Network Process, Network Process File, Network Registry File, Map building, Anomal, Hostflow, Process DLL, Registry File Process, Hostflow, API RPC, File API, Network API RPC, Event Records.
  
- subtechniques: //TODO
  - Tipos: Situational Awareness, TTP, Situational Awareness, Detection, Anomaly

## Segundo dataframe (variable en car.R -> dfCoverage)

Las técnicas hacen referencia a ATT&CK Techniques

  - id: Nombre del fichero yaml que se ha extraido la info
  - Technique: //TODO
  - Tactics: //TODO
  - Coverage: //TODO
    - Tipos: Low, Moderate, High
  - Subtechniques: //TODO
