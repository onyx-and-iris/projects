import argparse

if __name__ == '__main__':
    """ Initiate the parser """
    parser = argparse.ArgumentParser()

    parser.add_argument('-file', nargs=3,
    choices=['file1', 'file2', 'file3'])

    """ Read arguments from the command line """
    args = parser.parse_args()

    data = []
    for file in args.file:
        with open(f'{file}.txt') as this_file:
            data.append(this_file.read())

    print('\n'.join(data))
