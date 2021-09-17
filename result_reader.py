import os
import pandas as pd
from enum import Enum
import numpy as np
from pandas.io.sql import read_sql_query


"""
#TODO: 
    1. Add appropriate result size (currenlty almost everywhere is set to 0)
    2. Add query name for each result type
"""

class ResultType(Enum):
    real = 1
    user = 2 
    sys = 3

class TestType(Enum):
    SELECT = "select"
    CREATE = "create"
    IMPORT = "import"
    INDEX = "index"
    INSERT = "insert"


class CPUCoresMapper:
    def __init__(self, cpu_cores_map: dict):
        """Dict of <str: int>"""
        self.cpu_cores_map = cpu_cores_map
    
    def getNumberOfCores(self, text: str) -> int:
        return self.cpu_cores_map[text]

class IndexingMapper:
    def __init__(self, indexing_map: dict):
        """Dict of <str: bool>"""
        self.indexing_map = indexing_map

    def getWasIndexedBool(self, text: str) -> int:
        return self.indexing_map[text]

class TimeResult:
    def __init__(self, resultType: ResultType):
        self.resultType = resultType
        self.values = []
    
    def addValue(self, value):
        self.values.append(value)

    def getUnfilteredStdDev(self):
        return np.std(self.values)

    def getUnfilteredMean(self):
        return np.mean(self.values)

    def getFilteredStdDev(self, no_sd_outlier):
        return np.std(self._removeOutliers(no_sd_outlier))
    
    def getFilteredMean(self, no_sd_outlier):
        return np.mean(self._removeOutliers(no_sd_outlier))
    
    def _removeOutliers(self, no_sd_outlier):
        """
        Method returns values that exceeds value [ mean (+/-) no_sd_outlier * standard_deviation ] of values array
        """
        filtered_values = np.array(list(filter(lambda x: x < self.getUnfilteredMean() + no_sd_outlier * self.getUnfilteredStdDev() \
                                                    and x > self.getUnfilteredMean() - no_sd_outlier * self.getUnfilteredStdDev(), 
                                                    self.values)))
        return filtered_values


class ResultFileReader:
    def __init__(self, file_path: str):
        self.file_path = file_path
        self.entry_types = [ResultType.real, 
                           ResultType.user,
                           ResultType.sys]

    def readFile(self):
        resulsDictionary = {}
        with open(file=self.file_path) as f:
            lines = [line.rstrip() for line in f]
            for line in lines:
                splittedLine = line.split("\t")
                for entry_type in self.entry_types:
                    if splittedLine[0] == entry_type.name:
                        resulsDictionary[entry_type] = ResultFileReader.parseTimeEntryToSeconds(splittedLine[1])
        return resulsDictionary

    @staticmethod
    def parseTimeEntryToSeconds(entry: str):
        # sample entry: 0m0.367s
        seconds = 0.000
        splittedEntry = entry.split("m")
        seconds += float(splittedEntry[0]) * 60.0
        seconds += float(splittedEntry[1].replace("s", ""))
        return seconds 

class ResultsCatalogReader:
    def __init__(self, catalog_path: str):
        self.catalog_path = catalog_path
        self.real_result: TimeResult = None
        self.user_result: TimeResult = None
        self.sys_result: TimeResult = None

    def _read_files(self):
        self._initResults()
        for file in os.listdir(self.catalog_path):
            resultDict = ResultFileReader(os.path.join(self.catalog_path,file)).readFile()
            self.real_result.addValue(resultDict[self.real_result.resultType])
            self.user_result.addValue(resultDict[self.user_result.resultType])
            self.sys_result.addValue(resultDict[self.sys_result.resultType])

    def _initResults(self):
        self.real_result = TimeResult(ResultType.real)
        self.user_result = TimeResult(ResultType.user)
        self.sys_result = TimeResult(ResultType.sys)

    def getRealResult(self):
        if not self.real_result:
            self._read_files()
        return self.real_result
    
    def getUserResult(self):
        if not self.user_result:
            self._read_files()
        return self.user_result
    
    def getSysResult(self):
        if not self.sys_result:
            self._read_files()
        return self.sys_result



class CreateResultsReader:
    def __init__(self, 
                path: str,
                cpu_mapper: CPUCoresMapper):
        self.path = path
        self.cpu_mapper = cpu_mapper
        self.col_names = ["test_name", 
                          "test_type",
                          "cpus", 
                          "indexed_table", 
                          "was_indexed", 
                          "result_size",
                          "query",
                          "real", 
                          "real_stddev",
                          "user", 
                          "user_stddev",
                          "sys", 
                          "sys_stddev"]
        self.df = pd.DataFrame(columns=self.col_names)


    def getDataframe(self, no_sd_outlier):
        for cpus_results in os.listdir(self.path):
            cpus = self.cpu_mapper.getNumberOfCores(cpus_results)
            directory = os.path.join(self.path, cpus_results, "results", "create")
            results_catalog_reader = ResultsCatalogReader(directory)
            real_result = results_catalog_reader.getRealResult()
            user_result = results_catalog_reader.getUserResult()
            sys_result = results_catalog_reader.getSysResult()

            results_dict = {self.col_names[0]: "create",
                            self.col_names[1]: TestType.CREATE.value,
                            self.col_names[2]: cpus,
                            self.col_names[3]: None,
                            self.col_names[4]: None,
                            self.col_names[5]: 0,
                            self.col_names[6]: None,
                            self.col_names[7]: real_result.getFilteredMean(no_sd_outlier),
                            self.col_names[8]: real_result.getUnfilteredStdDev(),
                            self.col_names[9]: user_result.getFilteredMean(no_sd_outlier),
                            self.col_names[10]: user_result.getUnfilteredStdDev(),
                            self.col_names[11]: sys_result.getFilteredMean(no_sd_outlier),
                            self.col_names[12]: sys_result.getUnfilteredStdDev()}
            self.df = self.df.append(results_dict, ignore_index=True)
        return self.df

class ImportResultsReader:
    def __init__(self, 
                path: str,
                cpu_mapper: CPUCoresMapper):
        self.path = path
        self.cpu_mapper = cpu_mapper
        self.col_names = ["test_name", 
                          "test_type",
                          "cpus", 
                          "indexed_table", 
                          "was_indexed", 
                          "result_size",
                          "query",
                          "real", 
                          "real_stddev",
                          "user", 
                          "user_stddev",
                          "sys", 
                          "sys_stddev"]
        self.df = pd.DataFrame(columns=self.col_names)


    def getDataframe(self, no_sd_outlier):
        for cpus_results in os.listdir(self.path):
            cpus = self.cpu_mapper.getNumberOfCores(cpus_results)
            directory = os.path.join(self.path, cpus_results, "results", "import")
            for query in os.listdir(directory):
                subdirectory = os.path.join(directory, query)
                results_catalog_reader = ResultsCatalogReader(subdirectory)
                real_result = results_catalog_reader.getRealResult()
                user_result = results_catalog_reader.getUserResult()
                sys_result = results_catalog_reader.getSysResult()

                results_dict = {self.col_names[0]: "import",
                                self.col_names[1]: TestType.IMPORT.value,
                                self.col_names[2]: cpus,
                                self.col_names[3]: None,
                                self.col_names[4]: None,
                                self.col_names[5]: 0,
                                self.col_names[6]: query,
                                self.col_names[7]: real_result.getFilteredMean(no_sd_outlier),
                                self.col_names[8]: real_result.getUnfilteredStdDev(),
                                self.col_names[9]: user_result.getFilteredMean(no_sd_outlier),
                                self.col_names[10]: user_result.getUnfilteredStdDev(),
                                self.col_names[11]: sys_result.getFilteredMean(no_sd_outlier),
                                self.col_names[12]: sys_result.getUnfilteredStdDev()}
                self.df = self.df.append(results_dict, ignore_index=True)
        return self.df

class InsertResultsReader:
    def __init__(self, 
                path: str,
                cpu_mapper: CPUCoresMapper,
                indexing_mapper: IndexingMapper):
        self.path = path
        self.cpu_mapper = cpu_mapper
        self.index_mapper = indexing_mapper
        self.col_names = ["test_name", 
                          "test_type",
                          "cpus", 
                          "indexed_table", 
                          "was_indexed", 
                          "result_size",
                          "query",
                          "real", 
                          "real_stddev",
                          "user", 
                          "user_stddev",
                          "sys", 
                          "sys_stddev"]
        self.df = pd.DataFrame(columns=self.col_names)


    def getDataframe(self, no_sd_outlier):
        for cpus_results in os.listdir(self.path):
            cpus = self.cpu_mapper.getNumberOfCores(cpus_results)
            directory = os.path.join(self.path, cpus_results, "results", "inserts")

            for was_indexed in os.listdir(directory):
                was_indexed_bool = self.index_mapper.getWasIndexedBool(was_indexed)
                results_files_directory = os.path.join(directory, was_indexed)

                results_catalog_reader = ResultsCatalogReader(results_files_directory)
                real_result = results_catalog_reader.getRealResult()
                user_result = results_catalog_reader.getUserResult()
                sys_result = results_catalog_reader.getSysResult()

                results_dict = {self.col_names[0]: "inserts",
                                self.col_names[1]: TestType.INSERT.value,
                                self.col_names[2]: cpus,
                                self.col_names[3]: "clients",
                                self.col_names[4]: was_indexed_bool,
                                self.col_names[5]: 100000,
                                self.col_names[6]: None,
                                self.col_names[7]: real_result.getFilteredMean(no_sd_outlier),
                                self.col_names[8]: real_result.getUnfilteredStdDev(),
                                self.col_names[9]: user_result.getFilteredMean(no_sd_outlier),
                                self.col_names[10]: user_result.getUnfilteredStdDev(),
                                self.col_names[11]: sys_result.getFilteredMean(no_sd_outlier),
                                self.col_names[12]: sys_result.getUnfilteredStdDev()}
                self.df = self.df.append(results_dict, ignore_index=True)
        return self.df

class IndexResultsReader:
    def __init__(self, 
                path: str,
                cpu_mapper: CPUCoresMapper):
        self.path = path
        self.cpu_mapper = cpu_mapper
        self.col_names = ["test_name", 
                          "test_type",
                          "cpus", 
                          "indexed_table", 
                          "was_indexed", 
                          "result_size",
                          "query",
                          "real", 
                          "real_stddev",
                          "user", 
                          "user_stddev",
                          "sys", 
                          "sys_stddev"]
        self.df = pd.DataFrame(columns=self.col_names)


    def getDataframe(self, no_sd_outlier):
        for cpus_results in os.listdir(self.path):
            cpus = self.cpu_mapper.getNumberOfCores(cpus_results)
            directory = os.path.join(self.path, cpus_results, "results", "index")
            for query in os.listdir(directory):
                subdirectory = os.path.join(directory, query)
                results_catalog_reader = ResultsCatalogReader(subdirectory)
                real_result = results_catalog_reader.getRealResult()
                user_result = results_catalog_reader.getUserResult()
                sys_result = results_catalog_reader.getSysResult()

                results_dict = {self.col_names[0]: "index",
                                self.col_names[1]: TestType.INDEX.value,
                                self.col_names[2]: cpus,
                                self.col_names[3]: query,
                                self.col_names[4]: None,
                                self.col_names[5]: 0,
                                self.col_names[6]: query,
                                self.col_names[7]: real_result.getFilteredMean(no_sd_outlier),
                                self.col_names[8]: real_result.getUnfilteredStdDev(),
                                self.col_names[9]: user_result.getFilteredMean(no_sd_outlier),
                                self.col_names[10]: user_result.getUnfilteredStdDev(),
                                self.col_names[11]: sys_result.getFilteredMean(no_sd_outlier),
                                self.col_names[12]: sys_result.getUnfilteredStdDev()}
                self.df = self.df.append(results_dict, ignore_index=True)
        return self.df

class SelectResultsReader:
    def __init__(self, 
                test_name: str,
                path: str,
                cpu_mapper: CPUCoresMapper,
                index_mapper: IndexingMapper):
        self.test_name = test_name
        self.path = path
        self.cpu_mapper = cpu_mapper
        self.index_mapper = index_mapper
        self.col_names = ["test_name", 
                          "test_type",
                          "cpus", 
                          "indexed_table", 
                          "was_indexed", 
                          "result_size",
                          "query",
                          "real", 
                          "real_stddev",
                          "user", 
                          "user_stddev",
                          "sys", 
                          "sys_stddev"]
        self.df = pd.DataFrame(columns=self.col_names)


    def getDataframe(self, no_sd_outlier):
        for cpus_results in os.listdir(self.path):
            cpus = self.cpu_mapper.getNumberOfCores(cpus_results)
            directory = os.path.join(self.path, cpus_results, "results", "selects")
            
            for indexed_table in os.listdir(directory):
                indexed_table_directory = os.path.join(directory, indexed_table)
                
                for was_indexed in os.listdir(indexed_table_directory):
                    was_indexed_bool = self.index_mapper.getWasIndexedBool(was_indexed)
                    was_indexed_directory = os.path.join(indexed_table_directory, was_indexed)
                
                    for query in os.listdir(was_indexed_directory):
                        subdirectory = os.path.join(was_indexed_directory, query)
                        results_catalog_reader = ResultsCatalogReader(subdirectory)
                        real_result = results_catalog_reader.getRealResult()
                        user_result = results_catalog_reader.getUserResult()
                        sys_result = results_catalog_reader.getSysResult()

                        results_dict = {self.col_names[0]: self.test_name,
                                        self.col_names[1]: TestType.SELECT.value,
                                        self.col_names[2]: cpus,
                                        self.col_names[3]: indexed_table,
                                        self.col_names[4]: was_indexed_bool,
                                        self.col_names[5]: 0,
                                        self.col_names[6]: query,
                                        self.col_names[7]: real_result.getFilteredMean(no_sd_outlier),
                                        self.col_names[8]: real_result.getUnfilteredStdDev(),
                                        self.col_names[9]: user_result.getFilteredMean(no_sd_outlier),
                                        self.col_names[10]: user_result.getUnfilteredStdDev(),
                                        self.col_names[11]: sys_result.getFilteredMean(no_sd_outlier),
                                        self.col_names[12]: sys_result.getUnfilteredStdDev()}
                        self.df = self.df.append(results_dict, ignore_index=True)
        return self.df

class ResultsReader:
    def __init__(self, 
                test_type: TestType,
                path: str,
                cpu_mapper: CPUCoresMapper,
                index_mapper: IndexingMapper,
                **kwargs):
        self.test_type = test_type
        self.path = path
        self.cpu_mapper = cpu_mapper
        self.index_mapper = index_mapper
        self.test_name = kwargs.get("test_name", str(test_type))
        self.result_reader = self._createResultsReader()
        
    def _createResultsReader(self):
        if self.test_type ==  TestType.SELECT:
            return SelectResultsReader(self.test_name,
                                        self.path,
                                        self.cpu_mapper,
                                        self.index_mapper)
        elif self.test_type == TestType.IMPORT:
            return ImportResultsReader(self.path, self.cpu_mapper)
        elif self.test_type == TestType.CREATE:
            return CreateResultsReader(self.path, self.cpu_mapper)
        elif self.test_type == TestType.INSERT:
            return InsertResultsReader(self.path, self.cpu_mapper, self.index_mapper)
        elif self.test_type == TestType.INDEX:
            return IndexResultsReader(self.path, self.cpu_mapper)
        else:
            raise AttributeError("Such TestType not exists.")

    def getDataFrame(self, no_sd_outlier):
        return self.result_reader.getDataframe(no_sd_outlier)


class DatabaseResultsReader:
    def __init__(self,
                 path: str, 
                 db: str,
                 engine: str,
                 cpu_cores_mappper: CPUCoresMapper,
                 indexing_mapper: IndexingMapper):
        self.path = path
        self.db = db
        self.engine = engine
        self.cpu_mapper = cpu_cores_mappper
        self.indexing_mapper = indexing_mapper
    
    def getDataFrame(self, no_sd_outlier):
        df = pd.DataFrame()
        tests_name_type_dict = {"log": TestType.SELECT,
                                "group_by_order": TestType.SELECT,
                                "joins": TestType.SELECT,
                                "create": TestType.CREATE,
                                "insert": TestType.INSERT,
                                "import": TestType.IMPORT,
                                "index": TestType.INDEX}
        for test_name in os.listdir(self.path):
            test_path = os.path.join(self.path, test_name)
            test_type = tests_name_type_dict.get(test_name)
            if not test_type:
                raise Exception(f"Wrong test name {test_name}")
            if test_type == TestType.SELECT:
                df = df.append(ResultsReader(test_type, test_path, self.cpu_mapper, self.indexing_mapper, test_name = test_name).getDataFrame(no_sd_outlier), ignore_index=True)
            else:
                df = df.append(ResultsReader(test_type, test_path, self.cpu_mapper, self.indexing_mapper).getDataFrame(no_sd_outlier), ignore_index=True)
        
        df.insert(0, "database", self.db)
        df.insert(1, "engine", self.engine)
        return df

if __name__=="__main__":
    log_path = r"C:\Users\szymon\OneDrive\praca_inzyneirska\wyniki\mysql_innodb\log"
    groupby_path = r"C:\Users\szymon\OneDrive\praca_inzyneirska\wyniki\mysql_innodb\group_by_order"
    joins_path  = r"C:\Users\szymon\OneDrive\praca_inzyneirska\wyniki\mysql_innodb\joins"
    create_path = r"C:\Users\szymon\OneDrive\praca_inzyneirska\wyniki\mysql_innodb\create"
    insert_path = r"C:\Users\szymon\OneDrive\praca_inzyneirska\wyniki\mysql_innodb\insert"
    import_path = r"C:\Users\szymon\OneDrive\praca_inzyneirska\wyniki\mysql_innodb\import"
    index_path = r"C:\Users\szymon\OneDrive\praca_inzyneirska\wyniki\mysql_innodb\index"
    
    path = r"C:\Users\szymon\OneDrive\praca_inzyneirska\wyniki\mysql_innodb"

    cpu_cores_mapper = CPUCoresMapper({"results_1cpus": 1,
                                       "results_2cpus": 2,
                                       "results_4cpus": 4})
    indexing_mapper = IndexingMapper({"before_index": False,
                                      "after_index": True})

    results_dict = { "log_select": ResultsReader(TestType.SELECT, log_path, cpu_cores_mapper, indexing_mapper, test_name="log"),
                    "group_by_select": ResultsReader(TestType.SELECT, groupby_path, cpu_cores_mapper, indexing_mapper, test_name="group_by_order"),
                    "joins_select": ResultsReader(TestType.SELECT, joins_path, cpu_cores_mapper, indexing_mapper, test_name="joins"),
                    "create": ResultsReader(TestType.CREATE, create_path, cpu_cores_mapper, indexing_mapper),
                    "insert": ResultsReader(TestType.INSERT, insert_path, cpu_cores_mapper, indexing_mapper),
                    "import_": ResultsReader(TestType.IMPORT, import_path, cpu_cores_mapper, indexing_mapper),
                    "index": ResultsReader(TestType.INDEX, index_path, cpu_cores_mapper, indexing_mapper)
    }

    db_results_reader = DatabaseResultsReader(path, "MySQL", "InnoDB", cpu_cores_mapper, indexing_mapper)
    df = db_results_reader.getDataFrame(2)
    df.to_csv(r"C:\Users\szymon\AppData\Local\Temp\results.csv")
    # for result_entry in results_dict.values():
    #     print(result_entry.getDataFrame(2))
