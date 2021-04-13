import getopt
from sys import argv

if __name__ == '__main__':
    argv = argv[1:]
    """ 
    define flags and option arguments
    arguments taking options followed by colon
    """
    try:
        options, args = getopt.getopt(argv, "abcd:e:f:", 
        ["argD =", "argE =", "argF ="])
    except:
        print('Error')

    for name, value in options:
        if name == '-a':
            val = 'Argument A'
        elif name =='-b':
            val = 'Argument B'
        elif name == '-c':
            val = 'Argument C'

        if name in ['-d', '--argD']:
            val = value
        elif name in ['-e', '--argE']:
            val = value
        elif name in ['-f', '--argF']:
            val = value
        else:
            print('Error, please provide an argument!')

    print(val)
