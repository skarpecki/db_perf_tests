import os
import pandas as pd
from enum import Enum
import numpy as np
from pandas.io.sql import read_sql_query
from pandas.tseries.offsets import DateOffset

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

    

class QueryType(Enum):
    WHERE = "where"
    ALL = "all"

    @staticmethod
    def getQueryType(query: str):
        if "where" in query:
            return QueryType.WHERE
        elif "all" in query:
            return QueryType.ALL
        else:
            return None 

class TestName(Enum):
    CREATE = "create"
    GROUP_BY_ORDER = "group_by_order"
    IMPORT = "import"
    INDEX = "index"
    INSERT = "insert"
    JOINS = "joins"
    LOG = "log"

    def getTestType(self):
        if self.value in ["group_by_order", "log", "joins"]:
            return TestType.SELECT
        else:
            return TestType(self.value)

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


class SizeMapper:
    def __init__(self):
        pass

    def getQuerySize(self, test_name: TestName, query: str):
        if test_name == TestName.CREATE:
            return None
        elif test_name == TestName.INSERT:
            return 1000
        elif test_name == TestName.IMPORT or test_name == TestName.INDEX:
            return self._getImportIndexQuerySize(query)
        elif test_name == TestName.GROUP_BY_ORDER:
            return self._getGroupByQuerySize(query)
        elif test_name == TestName.LOG:
            query_type = QueryType.getQueryType(query)
            return self._getLogQuerySize(query_type, query)
        elif test_name == TestName.JOINS:
            return self._getJoinsQuerySize(query)
        else:
            return None
            


    def _getImportIndexQuerySize(self, query: str):
        import_map = {"clients_1":       1,
                      "clients_10":      10,
                      "clients_100":     100,
                      "clients_1000":    1000,
                      "clients_10000":   10000,
                      "clients_100000":  100000,
                      "clients_1000000": 1000000,
                      "clients":         10000000}
        return import_map.get(query, None)

    def _getLogQuerySize(self, query_type: QueryType, query: str):
        select_all_map = {"clients_1_all":       1,
                          "clients_10_all":      10,
                          "clients_100_all":     100,
                          "clients_1000_all":    1000,
                          "clients_10000_all":   10000,
                          "clients_100000_all":  100000,
                          "clients_1000000_all": 1000000,
                          "clients_base_all":    10000000}
        
        if query_type == QueryType.WHERE:
            return 1
        else:
            return select_all_map.get(query, None)
        
    def _getGroupByQuerySize(self, query: str):
        group_by_map = {"clients_1_all":       1,
                        "clients_10_all":      10,
                        "clients_100_all":     100,
                        "clients_1000_all":    989,
                        "clients_10000_all":   9384,
                        "clients_100000_all":  72478,
                        "clients_1000000_all": 361802,
                        "clients_base_all":    923828}
        return group_by_map.get(query, None)

    def _getJoinsQuerySize(self, query: str):
        join_map = {"one_join_where": 1,
                    "one_join": 10000000,
                    "two_joins_where": 1,
                    "two_joins": 10000000,
                    "three_joins_where": 3,
                    "three_joins": 100000}
        return join_map.get(query, None)

class TimeResult:
    def __init__(self, resultType: ResultType):
        self.resultType = resultType
        self.values = []
        self.round_decimals = 4
    
    def addValue(self, value):
        self.values.append(value)

    def getUnfilteredStdDev(self):
        stdddev = np.std(self.values)
        return np.around(stdddev, self.round_decimals)

    def getUnfilteredMean(self):
        mean = np.mean(self.values)
        return np.around(mean, self.round_decimals)

    def getFilteredStdDev(self, no_sd_outlier):
        stddev = np.std(self._removeOutliers(no_sd_outlier))
        return np.around(stddev, self.round_decimals)

    def getFilteredMean(self, no_sd_outlier):
        mean = np.mean(self._removeOutliers(no_sd_outlier))
        return np.around(mean, self.round_decimals)

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


class ResultsReader:
    def __init__(self, 
                test_name: TestName,
                test_type: TestType,
                path: str,
                cpu_mapper: CPUCoresMapper,
                index_mapper: IndexingMapper):
        self.test_type = test_type
        self.path = path
        self.cpu_mapper = cpu_mapper
        self.index_mapper = index_mapper
        self.test_name = test_name
        self.results_dict = {"test_name":       test_name.value,
                             "test_type":       test_type.value,
                             "cpus":            0,
                             "indexed_table":   None,
                             "was_indexed":     None,
                             "result_size":     None,
                             "query":           None,
                             "real":            None,
                             "real_stddev":     None,
                             "user":            None,
                             "user_stddev":     None,
                             "sys":             None,
                             "sys_stddev":      None,
                             "query_type":      None}
                             
        
    def getDataFrame(self, no_sd_outlier):
        df = pd.DataFrame()
        for cpus_results in os.listdir(self.path):
            cpus = self.cpu_mapper.getNumberOfCores(cpus_results)
            directory = os.path.join(self.path, cpus_results, "results", self.test_type.value)
            self.results_dict["cpus"] = cpus
            
            if self.test_type == TestType.SELECT:
                df = df.append(self._readSelectResult(directory, no_sd_outlier), ignore_index=True)
            elif self.test_type == TestType.CREATE:
                df = df.append(self._readCreateResult(directory, no_sd_outlier), ignore_index=True)
            elif self.test_type == TestType.INDEX or self.test_type == TestType.IMPORT:
                df = df.append(self._readImportIndexResult(directory, no_sd_outlier), ignore_index=True)
            elif self.test_type == TestType.INSERT:
                df = df.append(self._readInsertResult(directory, no_sd_outlier), ignore_index=True)
            else:
                raise ValueError("Not known test type")
        
        return df
        

    def _readSelectResult(self, directory, no_sd_outlier):
        df = pd.DataFrame()
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
                        if self.test_name == TestName.GROUP_BY_ORDER or self.test_name == TestName.LOG:
                            self.results_dict["indexed_table"] = query
                        else:
                            self.results_dict["indexed_table"] = indexed_table
                        if "all" in query:
                            self.results_dict["query_type"] = "ALL"
                        elif "where" in query:
                            self.results_dict["query_type"] = "WHERE"
                        self.results_dict["was_indexed"] = was_indexed_bool
                        self.results_dict["result_size"] = SizeMapper().getQuerySize(self.test_name, query)
                        self.results_dict["query"] = query
                        self._fillResultTimes(real_result, user_result, sys_result, no_sd_outlier)
                        df = df.append(self.results_dict, ignore_index=True)
        return df

    def _readCreateResult(self, directory, no_sd_outlier):
        df = pd.DataFrame()
        results_catalog_reader = ResultsCatalogReader(directory)
        real_result = results_catalog_reader.getRealResult()
        user_result = results_catalog_reader.getUserResult()
        sys_result = results_catalog_reader.getSysResult()

        self._fillResultTimes(real_result, user_result, sys_result, no_sd_outlier)

        df = df.append(self.results_dict, ignore_index=True)
        return df

    def _readImportIndexResult(self, directory, no_sd_outlier):
        df = pd.DataFrame()
        for query in os.listdir(directory):
            subdirectory = os.path.join(directory, query)
            results_catalog_reader = ResultsCatalogReader(subdirectory)
            real_result = results_catalog_reader.getRealResult()
            user_result = results_catalog_reader.getUserResult()
            sys_result = results_catalog_reader.getSysResult()

            self.results_dict["result_size"] = SizeMapper().getQuerySize(self.test_name, query)
            self.results_dict["query"] = query
            if self.test_type == TestType.INDEX:
                self.results_dict["indexed_table"] = query
            self._fillResultTimes(real_result, user_result, sys_result, no_sd_outlier)

            df = df.append(self.results_dict, ignore_index=True)

        return df
    
    def _readInsertResult(self, directory, no_sd_outlier):
        df = pd.DataFrame()  
        for was_indexed in os.listdir(directory):
            was_indexed_bool = self.index_mapper.getWasIndexedBool(was_indexed)

            subdirectory = os.path.join(directory, was_indexed)
            results_catalog_reader = ResultsCatalogReader(subdirectory)

            real_result = results_catalog_reader.getRealResult()
            user_result = results_catalog_reader.getUserResult()
            sys_result = results_catalog_reader.getSysResult()

            self.results_dict["indexed_table"] = "clients"
            self.results_dict["was_indexed"] = was_indexed_bool
            self.results_dict["result_size"] = 1000

            self._fillResultTimes(real_result, user_result, sys_result, no_sd_outlier)
            df = df.append(self.results_dict, ignore_index=True)
        return df
    
    def _fillResultTimes(self,
                         real_result: TimeResult, 
                         user_result: TimeResult, 
                         sys_result: TimeResult,
                         no_sd_outlier: int):

        self.results_dict["real"] = real_result.getFilteredMean(no_sd_outlier)
        self.results_dict["user"] = user_result.getFilteredMean(no_sd_outlier)
        self.results_dict["sys"] = sys_result.getFilteredMean(no_sd_outlier)

        self.results_dict["real_stddev"] = real_result.getUnfilteredStdDev()
        self.results_dict["user_stddev"] = user_result.getUnfilteredStdDev()
        self.results_dict["sys_stddev"] = sys_result.getUnfilteredStdDev()


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

        for test_name_val in os.listdir(self.path):
            test_path = os.path.join(self.path, test_name_val)
            test_name = TestName(test_name_val)
            test_type = test_name.getTestType()

            if not test_type:
                raise Exception(f"Wrong test name {test_name}")
            df = df.append(ResultsReader(test_name, test_type, test_path, self.cpu_mapper, self.indexing_mapper).getDataFrame(no_sd_outlier), ignore_index=True)
        
        df.insert(0, "database", self.db)
        df.insert(1, "engine", self.engine)
        return df

if __name__=="__main__":
    mysql_innodb_path = r"C:\Users\szymon\OneDrive\praca_inzyneirska\wyniki\mysql_innodb"
    mysql_myisam_path = r"C:\Users\szymon\OneDrive\praca_inzyneirska\wyniki\mysql_myisam"
    mariadb_innodb_path = r"C:\Users\szymon\OneDrive\praca_inzyneirska\wyniki\mariadb_innodb"
    mssql_path = r"C:\Users\szymon\OneDrive\praca_inzyneirska\wyniki\mssql"

    cpu_cores_mapper = CPUCoresMapper({"results_1cpus": 1,
                                       "results_2cpus": 2,
                                       "results_4cpus": 4})
    indexing_mapper = IndexingMapper({"before_index": False,
                                      "after_index": True})

    df = DatabaseResultsReader(mysql_innodb_path, "MySQL", "InnoDB", cpu_cores_mapper, indexing_mapper).getDataFrame(2)
    df = df.append(DatabaseResultsReader(mysql_myisam_path, "MySQL", "MyISAM", cpu_cores_mapper, indexing_mapper).getDataFrame(2), ignore_index=True)
    df = df.append(DatabaseResultsReader(mariadb_innodb_path, "MariaDB", "InnoDB", cpu_cores_mapper, indexing_mapper).getDataFrame(2), ignore_index=True)
    df = df.append(DatabaseResultsReader(mssql_path, "MSSQL", "MSSQL", cpu_cores_mapper, indexing_mapper).getDataFrame(2), ignore_index=True)
    
    df.to_csv(r"C:\Users\szymon\OneDrive\praca_inzyneirska\wyniki\results_v1.csv")

