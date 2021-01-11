library(httr)
library(yaml)

# Make a GET request to get the list of the files to download
request <-
    GET("https://api.github.com/repos/mitre-attack/car/git/trees/master?recursive=1")
stop_for_status(request)

# Create a temporary directory to store temporary car analytics files
temporaryDirectory <- tempdir()

# Transform the data from the request into lists of car analytics urls
# and temporary file names
carRepositoryFileUrlList <-
    unlist(lapply(content(request)$tree, "[", "path"), use.names = F)
carAnalyticsFileUrlList <-
    paste0(
        "https://github.com/mitre-attack/car/raw/master/",
        grep(".*CAR(-\\d+)+.yaml", carRepositoryFileUrlList, value = TRUE)
    )
carAnalyticsFileNameList <- lapply(carAnalyticsFileUrlList,
                                   function(carAnalyticFileUrl) {
                                       strsplit(carAnalyticFileUrl, "/")[[1]][9]
                                   })
temporaryFiles <-
    lapply(carAnalyticsFileNameList, function(carAnalyticFileName) {
        file.path(temporaryDirectory, carAnalyticFileName)
    })

# Download car analytics files
mapply(function(carAnalyticsFileUrl,
                temporaryFile) {
    download.file(url = carAnalyticsFileUrl,
                  destfile = temporaryFile)
},
carAnalyticsFileUrlList,
temporaryFiles)

# -------------We generate the dataframes--------------

# First dataframe we generate
df <- lapply(temporaryFiles, function(temporaryFile) {
    rawCarAnalyticData <- yaml::read_yaml(temporaryFile)

    carAnalyticDataFrame <- data.frame(
        id = rawCarAnalyticData$id,
        title = rawCarAnalyticData$title,
        description = rawCarAnalyticData$description,
        submission_date = rawCarAnalyticData$submission_date,
        information_domain = factor(strsplit(rawCarAnalyticData$information_domain, ", |\\s+-\\s+")[[1]], levels = c("Analytic", "External", "Host", "Network")),
        platforms = paste(rawCarAnalyticData$platforms, collapse="/"),
        subtypes = paste(rawCarAnalyticData$subtypes, collapse="/"),
        analytic_types = paste(rawCarAnalyticData$analytic_types, collapse="/"),
        coverage = paste(rawCarAnalyticData$coverage, collapse="/")
    )
    carAnalyticDataFrame
})
df <- do.call(rbind, df)
df$submission_date <- as.Date(df$submission_date)

print(unique(df$subtypes))
print("-----")
print(unique(df$analytic_types))

# Second dataframe that we generate, this includes the coverage of all files.
dfCoverage <- plyr::ldply(temporaryFiles, function(temporaryFile) {
  rawCarAnalyticData <- yaml::read_yaml(temporaryFile)
  k <- plyr::ldply(1:length(rawCarAnalyticData$coverage), function(index) {
    technique <- rawCarAnalyticData$coverage[[index]]$technique
    tactics <- paste(rawCarAnalyticData$coverage[[index]]$tactics, collapse="/")
    coverage <- rawCarAnalyticData$coverage[[index]]$coverage
    subtechniques <- paste(rawCarAnalyticData$coverage[[index]]$subtechniques, collapse="/")
    temp <- data.frame(
      id = rawCarAnalyticData$id,
      tecnique = ifelse(test = !is.null(technique), yes = technique, no = "-"),
      tactics = ifelse(test = !is.null(tactics), yes = tactics, no = "-"),
      coverage = ifelse(test = !is.null(coverage), yes = coverage, no = "-"),
      subtechniques = ifelse(test = !is.null(subtechniques), yes = subtechniques, no = "-")
    )
    temp
  })
  k
})

#save(df, file = "generalDataFrame.rda")
#save(dfCoverage, file = "coverageDataFrame.rda")
