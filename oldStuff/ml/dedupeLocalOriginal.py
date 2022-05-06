import csv
import os
import re
import logging
import optparse
import dedupe
from unidecode import unidecode


def preProcess(column):
    column = unidecode(column)
    column = re.sub('  +', ' ', column)
    column = re.sub('\n', ' ', column)
    column = column.strip().strip('"').strip("'").lower().strip()

    if not column:
        column = None
    return column


def readData(filepath):
    data_d = {}
    k= 0
    with open(filepath) as f:
        reader = csv.DictReader(f)
        for row in reader:
            clean_row = [(k, preProcess(v)) for (k, v) in row.items()]
            row_id = k  # int(row['Id'])
            k += 1
            data_d[row_id] = dict(clean_row)
    return data_d


def performDedupe(file, directory, threshold, fields):

    input_file = directory+file
    file=file[:-4]
    output_file = '/Users/mihirarya/PycharmProjects/dh199ML/'+file+'OutputFile.csv'
    settings_file = '/Users/mihirarya/PycharmProjects/dh199ML/'+file+'SettingsFile.csv'
    training_file = '/Users/mihirarya/PycharmProjects/dh199ML/'+file+'DedupeTrainingFile.csv'

    data_d = readData(input_file)


    if os.path.exists(settings_file):
        print('Settings file found, reading from', settings_file)
        with open(settings_file, 'rb') as f:
            deduper = dedupe.StaticDedupe(f)
    else:

        deduper = dedupe.Dedupe(fields)

        if os.path.exists(training_file):
            print('Training file exists, reading labeled examples from ', training_file)
            with open(training_file, 'rb') as f:
                deduper.prepare_training(data_d, f)
        else:
            deduper.prepare_training(data_d)

        print('Starting active labeling...')
        dedupe.console_label(deduper)

        deduper.train()

        with open(training_file, 'w') as tf:
            deduper.write_training(tf)

        with open(settings_file, 'wb') as sf:
            deduper.write_settings(sf)

    print('clustering...')
    clustered_dupes = deduper.partition(data_d, threshold)

    print('# duplicate sets', len(clustered_dupes))

    cluster_membership = {}
    for cluster_id, (records, scores) in enumerate(clustered_dupes):
        for record_id, score in zip(records, scores):
            cluster_membership[record_id] = {
                "Cluster ID": cluster_id,
                "confidence_score": score
            }

    with open(output_file, 'w') as f_output, open(input_file) as f_input:

        reader = csv.DictReader(f_input)
        fieldnames = ['Cluster ID', 'confidence_score'] + reader.fieldnames

        writer = csv.DictWriter(f_output, fieldnames=fieldnames)
        writer.writeheader()

        k = 0
        for row in reader:
            row_id = k
            k+=1
            row.update(cluster_membership[row_id])
            writer.writerow(row)

def getUserInputs():
    dirPath = (input("Enter directory path for .csv file to perform Dedupe on: ")).strip()
    if dirPath[-1] != "/": dirPath += "/"
    file = (input("Enter file name for .csv file to perform Dedupe on: ")).strip()

    threshold = input("Provide a [0-1] thereshold to be used in clustering: ")

    colNames = []
    with open(dirPath+file, newline='') as f:
        reader = csv.reader(f)
        colNames = list(next(reader))  # gets the first line

    # fields = []
    fields = [{'field': 'Title of Track' , 'type': 'String'}]
    if len(fields)==0:
        for colName in colNames:
            print("Provide data type desired for ", colName, ": ")
            dType = input()
            if dType=="s":
                continue
        fields.append({'field': colName, 'type': dType})

    return (file,dirPath,float(threshold),fields)

def main():
    file,directory,threshold,fields = getUserInputs()
    performDedupe(file,directory,threshold,fields)


if __name__ == '__main__':
    main()
