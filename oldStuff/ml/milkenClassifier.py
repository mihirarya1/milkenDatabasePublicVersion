import csv
import random
import matplotlib.pyplot
from sklearn.ensemble import RandomForestClassifier
from sklearn.datasets import make_classification
from sklearn.preprocessing import OneHotEncoder
from sklearn.preprocessing import LabelEncoder
from sklearn.metrics import precision_score
from sklearn.metrics import recall_score
import math
import numpy


def readDataIn(filePath):
    mainArr = []
    with open(filePath, "r") as milken:
        reader = csv.reader(milken)
        for row in reader:
            mainArr.append(row)
    random.shuffle(mainArr)
    mainArr = numpy.array(mainArr)
    return mainArr


def splitAndEncode(mainArr, trainDataPct, valDataPct, testDataPct, columnToTest):
    mainArr = mainArr[:, 7:]

    n = len(mainArr)

    yTrain = mainArr[0:math.floor(n * trainDataPct), columnToTest]
    yValidate = mainArr[math.ceil(
        n * trainDataPct):math.floor(n * (trainDataPct + valDataPct)), columnToTest]
    yTest = mainArr[math.ceil(
        n * (trainDataPct + valDataPct)):, columnToTest]

    numpy.array(numpy.delete(mainArr, columnToTest, axis=1))

    enc = OneHotEncoder()
    enc.fit(mainArr)
    trainArr = enc.transform(mainArr).toarray()

    xTrain = trainArr[0:math.floor(n * trainDataPct), :]
    xValidate = trainArr[math.ceil(
        n * trainDataPct):math.floor(n * (trainDataPct + valDataPct)), :]
    xTest = trainArr[math.ceil(n * (trainDataPct + valDataPct)):, :]

    return xTrain, xValidate, xTest, yTrain, yTest, yValidate


def learn(xTrain, yTrain):
    le = LabelEncoder()
    yTrain = numpy.array(yTrain)
    le.fit(yTrain)
    le.transform(yTrain)

    clf = RandomForestClassifier()
    z = clf.fit(xTrain, yTrain)

    return clf


def predict(xTest, yTest, clf):
    le = LabelEncoder()
    yTest = numpy.array(yTest)
    le.fit(yTest)
    le.transform(yTest)

    yTestPredicted = clf.predict(xTest)

    counter = 0
    if len(yTest) != len(yTestPredicted):
        exit(1)
    for j in range(len(yTest)):
        if (yTest[j] != yTestPredicted[j]):
            counter += 1
    print("Number of mismatches between predicted and actual results", counter)
    print("Out of ", len(yTest))

    print("Precison Score is : ", precision_score(
        yTest, yTestPredicted, average='macro'))
    print("Recall Score is : ", recall_score(
        yTest, yTestPredicted, average='macro'))


def performMilkenClassification():
    # shuffle, delete, extract column, delete column, encode, split

    filePath = "/Users/mihirarya/dh199/rawData/generalApproach/milkenMain.csv"
    trainPct = .7
    testPct = .3
    validationPct = 0

    master = {
        'Commission Y / N?': 1,
        'Commissioning Institution(Name)': 2,
        'Commissioning Institution(Type)': 3,
        'Primary Genre': 4,
        'Instrumentation': 5,
        'Form - General': 6,
        'Form - Specific(was Tertiary Genre)': 7,
        'Other': 8,
        'Sacred': 9,
        'Secular': 10,
        'Ashkenazi': 11,
        'Sephardi': 12,
        'Israeli': 13,
        'Mizrahi': 14,
        'Musical': 15,
        'Conceptual': 16,
        'Textual': 17,
        'Functional': 18,
        'Sonic': 19,
        'Social': 20,
        'Classical': 21,
        'Klezmer': 22,
        'Cantorial': 23,
        'Folk': 24,
        'Jazz': 25,
        'Devotional - Solemn': 26,
        'Popular': 27,
        'Theatrical': 28,
        'Text Y / N': 29,
        'Text Type': 30,
        'Text Source': 31,
        'Hebrew': 32,
        'Yiddish': 33,
        'English': 34,
        'Ladino': 35,
        'German': 36,
        'Other': 37
    }

    mainArr = readDataIn(filePath)

    xTrain, xValidate, xTest, yTrain, yTest, yValidate = \
        splitAndEncode(mainArr, trainPct, validationPct,
                       testPct, master['Klezmer'])

    clf = learn(xTrain, yTrain)

    predict(xTest, yTest, clf)

def main():
    performMilkenClassification()

if __name__ == '__main__':
    main()
