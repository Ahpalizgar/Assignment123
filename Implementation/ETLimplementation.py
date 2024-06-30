from typing import Optional
from pyspark.sql.functions import col, when, sum as spark_sum, to_date, trim, lower
from pyspark.sql.window import Window
from pyspark.sql.dataframe import DataFrame
from Framework.EtlFramework import ETL

import os


class ETLImplementation(ETL):
    """
    ETL class to extract an excel file of transactions to calculate balance of accounts and
    write to a target location as a parquet file
    """
    def __init__(
            self,
            source_path: str,
            target_path: Optional[str] = None
    ) -> None:
        self.source_path = source_path
        self.target_path = target_path

        if target_path is None:
            # Generate default target path based on source_path
            source_filename = os.path.basename(source_path)
            source_directory = os.path.dirname(source_path)
            target_path = os.path.join(source_directory, "output_" + source_filename)
        
        self.target_path = target_path


    def extract(self) -> DataFrame:
        """
        Extract an excel file from the defined path and creats a dataframe out of it
        """
        df = spark.read.format("com.crealytics.spark.excel") \
            .option("header", "true") \
            .option("inferSchema", "true") \
            .load(self.source_path)
        
        return df.dropna()

    def transform(self, df: DataFrame) -> DataFrame:
        """
        Calculates balance of each account number when a transaction is made.
        """
        df = df.withColumn("TransactionType", trim(col("TransactionType")))
        df = df.withColumn("TransactionDate", to_date(col("TransactionDate").cast("long").cast("string"), 'yyyyMMdd'))
        df = df.withColumn("correct_amount", when(lower(col("TransactionType")) == "debit", -col("Amount")).otherwise(col("Amount")))

        # Calculate running balance for each account number
        windowSpec = Window.partitionBy("AccountNumber").orderBy("TransactionDate").rowsBetween(Window.unboundedPreceding, Window.currentRow)
        df = df.withColumn("Balance", spark_sum("correct_amount").over(windowSpec))
        df = df.drop('correct_amount')
        
        return df
    
    def load(self, df: DataFrame) -> None:
        """
        Writes a dataframe in parquet format to the target location
        """
        df.write.mode("overwrite").parquet(self.target_path)
