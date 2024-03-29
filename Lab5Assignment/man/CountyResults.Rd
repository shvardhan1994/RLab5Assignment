% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CountyResults.R
\name{CountyResults}
\alias{CountyResults}
\title{This function loads data from API and performs functionality based on the data.}
\usage{
CountyResults(County_name)
}
\arguments{
\item{County_name}{Takes this as argument and party wise vote distribution is plotted adding all the vote shares from eah municipality in that county.}
}
\value{
Returns the plot with party wise vote distribution of the County user entered.
}
\description{
In this package, we connect to a web API and fetch data from API, a functionality is created where in user inputs County Name and  party wise vote distribution is plotted adding all the vote shares from eah municipality in that count. The same functionality is called in shiny app making it a reactive input output program.
}
