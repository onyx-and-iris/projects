import argparse

if __name__ == '__main__':
    """ Initiate the parser """
    parser = argparse.ArgumentParser()

    """ define flag """
    parser.add_argument('-a', action='store_true')
    parser.add_argument('-b', action='store_true')
    parser.add_argument('-c', action='store_true')

    """ define option arguments """
    parser.add_argument('-optionA', nargs=None,
    choices=['valueA'])
    parser.add_argument('-optionB', nargs=None,
    choices=['valueB'])
    parser.add_argument('-optionC', nargs=None,
    choices=['valueC'])

    """ Read arguments from the command line """
    args = parser.parse_args()

    if args.a:
        val = 'Argument A'
    if args.b:
        val = 'Argument B'
    if args.c:
        val ='Argument C'

    if args.optionA:
        val = args.optionA
    if args.optionB:
        val = args.optionB
    if args.optionC:
        val = args.optionC

    print(val)
