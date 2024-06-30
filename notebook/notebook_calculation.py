from Implementation.ETLimplementation import ETLImplementation


# In the real word, this will be a dynamic location which will be feeded into the ETL implementation
source_path = "dbfs:/FileStore/Data_asessment_dataset1.xlsx"
ETLImplementation(source_path).execute()