from abc import ABC, abstractmethod
from pyspark.sql.functions import DataFrame


class ETL(ABC):
    """
    Contains the abstract methods required to carry out ETL steps of the data pipeline.
    Each ETL pipeline must create an instance of this class.
    """

    @abstractmethod
    def extract(self) -> DataFrame:
        """
        Abstract method for the extract of the ETL pipeline.
        :return: extracted raw data
        """

    @abstractmethod
    def transform(self, data: DataFrame) -> DataFrame:
        """
        Abstract method for the transform of the ETL pipeline.
        paran data: raw data to transform
        :return: transformed data ready to be loaded
        """

    @abstractmethod
    def load(self, data: DataFrame) -> DataFrame:
        """
        Abstract method for the load of the ETL pipeline.
        :param result: transformed data ready to be loaded
        """
    
    def execute(self) -> None:
        """
        Runs the whole ETL process from loading to writing to the target
        """
        df = self.extract()
        data = self.transform(df)
        self.load(data)
