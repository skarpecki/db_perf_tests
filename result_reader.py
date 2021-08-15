import os
import pandas as pd
from enum import Enum
import numpy as np


class ResultType(Enum):
    real = 1
    user = 2 
    sys = 3


class QueryType(Enum):
    select = 1


class ResultsMetadata:
    def __init__(self, numberOfValues, path):
        self.numberOfValues = numberOfValues
        self.path = path


class ResultEntry:
    def __init__(self, resultType: ResultType):
        self.resultType = resultType
        self.values = []
    
    def addValue(self, value):
        self.values.append(value)

    
    def removeOutliers(self, no_SD):
        """
        Method returns values that exceeds value [ mean (+/-) no_SD * standard_deviation ] of values array
        """
        mean = np.mean(self.values)
        sd = np.std(self.values)
        self.filteredValues = np.array(list(filter(lambda x: x < mean + no_SD * sd and x > mean - no_SD * sd, 
                                self.values)))
        return self.filteredValues


class ResultFileReader:
    def __init__(self, pathToFile: str):
        self.pathToFile = pathToFile
        self.entryTypes = [ResultType.real, 
                           ResultType.user,
                           ResultType.sys]

    def readFile(self):
        resulsDictionary = {}
        with open(file=self.pathToFile) as f:
            lines = [line.rstrip() for line in f]
            for line in lines:
                splittedLine = line.split("\t")
                for entryType in self.entryTypes:
                    if splittedLine[0] == entryType.name:
                        resulsDictionary[entryType] = ResultFileReader.parseTimeEntryToSeconds(splittedLine[1])
        return resulsDictionary

    @staticmethod
    def parseTimeEntryToSeconds(entry: str):
        # sample entry: 0m0.367s
        seconds = 0.000
        splittedEntry = entry.split("m")
        seconds += float(splittedEntry[0]) * 60.0
        seconds += float(splittedEntry[1].replace("s", ""))
        return seconds 

class QueryResults:
    def __init__(self,
                 queryType: QueryType, 
                 isAfterIndexing: bool,
                 indexedColumn: str,
                 baseTable: str,
                 isWhereUsed: bool):
        self.queryType = queryType
        self.resultEntriesList = {ResultType.real: ResultEntry(ResultType.real),
                                  ResultType.user: ResultEntry(ResultType.user),
                                  ResultType.sys:  ResultEntry(ResultType.sys)}
        self.isAfterIndexing = isAfterIndexing
        self.indexedColumn = indexedColumn,
        self.baseTable = baseTable,
        self.isWhereUsed = isWhereUsed

    def getAverageTime(self, resultType: ResultType):
        return self.resultEntriesList[resultType].getAverage()

    
class QueryResultsFactory:
    @staticmethod
    def createResultClass(path: str, filename: str):
        pass




class SelectResults:
    def __init__(self, 
                resultsMetadata: ResultsMetadata, 
                indexedColumn: str,
                queryType: QueryType,
                queryTable: str):
        self.resultsMetadata = resultsMetadata
        self.indexedColumn = indexedColumn
        self.queryType = queryType
        self.queryTable = queryTable
        self.realResult = ResultEntry(ResultType.real)
        self.userResult = ResultEntry(ResultType.user)
        
        self.sysResult = ResultEntry(ResultType.sys)


class SelectResultsReader:
    def __init__(self, directory):
        self.directory = directory
        self.df = pd.DataFrame(columns=['real', 'user', 'sys'])

    def iterate_files(self):
        for filename in os.listdir(self.directory):
            with open(file=self.directory + "\\" + filename) as f:
                lines = [line.rstrip() for line in f]
                for line in lines:
                    print(line.split("\t"))


if __name__=="__main__":
    mysqlPathBase = r"C:\Users\Szymon\OneDrive\praca_inzyneirska\wyniki\mysql\07-08-2021\results"
    mssqlPathBase = r"C:\Users\Szymon\OneDrive\praca_inzyneirska\wyniki\sql_server\27-07\results"
    pathBase = mysqlPathBase
    # path = r"D:\praca_inz_sample\1.txt"
    # reader = ResultFileReader(path)
    # dir = reader.readFile()
    colNames = ["indexed_table", "was_indexed", "query_type", "real", "user", "sys"]
    df = pd.DataFrame(columns=colNames)
    
    import os
    selectBaseDirectory = os.path.join(pathBase, "selects")

    for indexedTable in os.listdir(selectBaseDirectory):
        print(indexedTable)
        for isIndexed in os.listdir(os.path.join(selectBaseDirectory, indexedTable)):
            subdirectory = os.path.join(selectBaseDirectory, indexedTable, isIndexed)
            for queryType in os.listdir(subdirectory):
                print("--{}".format(queryType))

                realResultEntry = ResultEntry(ResultType.real)
                userResultEntry = ResultEntry(ResultType.user)
                sysResultEntry = ResultEntry(ResultType.sys)

                for file in os.listdir(os.path.join(subdirectory, queryType)):
                    resultDict = ResultFileReader(os.path.join(subdirectory,queryType,file)).readFile()
                    realResultEntry.addValue(resultDict[realResultEntry.resultType])
                    userResultEntry.addValue(resultDict[userResultEntry.resultType])
                    sysResultEntry.addValue(resultDict[sysResultEntry.resultType])
                
                filteredRealArr = realResultEntry.removeOutliers(1)
                filteredUserArr = userResultEntry.removeOutliers(1)
                filteredSysArr = sysResultEntry.removeOutliers(1)

                resultList = {colNames[0]: indexedTable, 
                              colNames[1]: isIndexed,
                              colNames[2]: queryType,
                              colNames[3]: np.average(filteredRealArr),
                              colNames[4]: np.average(filteredUserArr),
                              colNames[5]: np.average(filteredSysArr)}
                df = df.append(resultList, ignore_index=True)
    print(df)
    path = os.path.join(pathBase, "summarized.xlsx")
    df.to_excel(path)      
    pass