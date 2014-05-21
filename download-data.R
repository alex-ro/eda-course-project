setwd("~/workspace/eda-course-project/")

data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
data_zip_file_name <- "exdata-data-NEI_data.zip"

if (!file.exists(data_zip_file_name)) {
    download.file(data_url, destfile=data_zip_file_name, method="curl")
}

